//
//  ZDDTabTwoViewController.m
//  V2EX
//
//  Created by pipelining on 2019/1/26.
//  Copyright © 2019年 binary. All rights reserved.
//

#import "ZDDTabTwoViewController.h"
#import "ZDDPoetryListCellNode.h"
#import "ZDDContentDetailController.h"
#import <MJRefresh.h>
#import "ZDDLogController.h"



@interface ZDDTabTwoViewController ()<ASTableDelegate, ASTableDataSource>

@property (nonatomic, strong) ASTableNode *tableNode;
@property (nonatomic, strong) NSMutableArray <ZDDPoetryModel *>*dataArray;

@end

@implementation ZDDTabTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    
}

- (void)setupUI {
    
    self.title = @"古诗词";
    
    [self.view addSubview:self.tableNode.view];
    [self.tableNode.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(NavBarHeight);
        make.bottom.mas_equalTo(-SafeTabBarHeight);
    }];
    
    self.tableNode.view.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(tableViewDidTriggerHeaderRefresh)];
    self.tableNode.view.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(tableViewDidTriggerFooterRefresh)];
    
    [self tableViewDidTriggerHeaderRefresh];
    
}


- (void)tableViewDidTriggerHeaderRefresh {
    [self loadData:NO];
}

- (void)tableViewDidTriggerFooterRefresh {
    [self loadData:YES];
}


- (void)loadData:(BOOL)isAdd {
    [MFHUDManager showLoading:@"加载中"];
    NSInteger index = 1;
    if (isAdd) {
        if (self.dataArray.count % 10 > 0) {
            index = (self.dataArray.count / 10) + 1;
        }else {
            index = self.dataArray.count / 10;
        }
    }
    
    [MFHUDManager showLoading:@"请求中..."];
    MFNETWROK.requestSerialization = MFJSONRequestSerialization;
    [MFNETWROK get:[NSString stringWithFormat:@"getTangPoetry?page=%ld&count=20", index] params:nil success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
        [MFHUDManager dismiss];
        [self.tableNode.view.mj_header endRefreshing];

        if ([result[@"code"] integerValue] == 200) {
            if (index == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:[NSArray yy_modelArrayWithClass:ZDDPoetryModel.class json:result[@"result"]]];
            [self.tableNode reloadData];
        }else {
            [MFHUDManager showError:@"请求失败"];
        }
    } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
        [self.tableNode.view.mj_header endRefreshing];

        [MFHUDManager dismiss];
        [MFHUDManager showError:@"请求失败"];
    }];
    
}


#pragma mark - tableViewDataSourceAndDelegate
- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ^ASCellNode *() {
        ZDDPoetryListCellNode *node = [[ZDDPoetryListCellNode alloc] initWithModel:self.dataArray[indexPath.row]];
        return node;
    };
    
}

- (void)tableNode:(ASTableNode *)tableNode didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableNode deselectRowAtIndexPath:indexPath animated:YES];

    ZDDPoetryModel *model = self.dataArray[indexPath.row];

    if (![GODUserTool isLogin]) {
        ZDDLogController *vc = [ZDDLogController new];
        
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        ZDDContentDetailController *vc = [ZDDContentDetailController new];
        vc.topModel = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}


-(ASTableNode *)tableNode {
    if (!_tableNode) {
        _tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];
        _tableNode.view.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableNode.backgroundColor = [UIColor whiteColor];
        _tableNode.view.estimatedRowHeight = 0;
        _tableNode.leadingScreensForBatching = 1.0;
        _tableNode.delegate = self;
        _tableNode.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _tableNode.view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableNode;
}

- (NSMutableArray<ZDDPoetryModel *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
