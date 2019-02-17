//
//  ZDDTabTrheeViewController.m
//  V2EX
//
//  Created by pipelining on 2019/2/16.
//  Copyright © 2019年 binary. All rights reserved.
//

#import "ZDDTabTrheeViewController.h"
#import <MFNetworkManager/MFNetworkManager.h>
#import <MJRefresh.h>
#import <YYWebImage.h>
#import "ZDDGXTableViewCell.h"
#import "UIColor+ZDDColor.h"
#import "ZDDGXModel.h"
#import "ZDDDisplayVideoViewController.h"
@interface ZDDTabTrheeViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
MFNetworkManagerDelegate
>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray<ZDDGXModel *> *gxList;
@end

@implementation ZDDTabTrheeViewController

- (NSMutableArray<ZDDGXModel *> *)gxList {
    if (!_gxList) {
        _gxList = @[].mutableCopy;
    }
    return _gxList;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, StatusBarHeight, ScreenWidth, ScreenHeight - StatusBarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        __weak typeof(self) weakSelf = self;
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf mf_refreshData];
        }];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.textColor = [UIColor customGrayColor];
        header.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;

        _tableView.mj_header = header;

        [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
        [header setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
        [header setTitle:@"正在刷新数据" forState:MJRefreshStateRefreshing];
        
        MJRefreshAutoFooter *footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            
            [weakSelf mf_loadMoreDataWithId:weakSelf.gxList.lastObject.id];
        }];
        _tableView.mj_footer = footer;
    }
    return _tableView;
}

- (void)mf_loadMoreDataWithId:(NSInteger)gxId {
    if (!self.gxList.count) {
        if ([self.tableView.mj_footer isRefreshing]) {
            [self.tableView.mj_footer endRefreshing];
        }
        return;
    }
    [MFNETWROK get:[NSString stringWithFormat:@"http://gaoxiaoshipin.vipappsina.com/index.php/NewApi38/index/lastId/%@/random_more/0/sw/0", @(gxId)] params:nil success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
        NSLog(@"success");
        NSLog(@"%@", result);
        NSMutableArray *list = [NSMutableArray array];
        for (NSDictionary *dic in result) {
            ZDDGXModel *model = [ZDDGXModel yy_modelWithJSON:dic];
            [list addObject:model];
        }
        if (list.count) {
            [self.gxList addObjectsFromArray:list];
            
        }
        if ([self.tableView.mj_footer isRefreshing]) {
            [self.tableView.mj_footer endRefreshing];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
        if ([self.tableView.mj_footer isRefreshing]) {
            [self.tableView.mj_footer endRefreshing];
        }
    }];
}

- (void)mf_refreshData {
    [MFNETWROK get:@"http://gaoxiaoshipin.vipappsina.com/index.php/NewApi38/index/markId/0/random/0/sw/0" params:nil success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
        NSLog(@"success");
        NSMutableArray *list = [NSMutableArray array];
        for (NSDictionary *dic in result[@"rows"]) {
            ZDDGXModel *model = [ZDDGXModel yy_modelWithJSON:dic];
            [list addObject:model];
        }
        if (list.count) {

            if (self.gxList.count) {
                [self.gxList removeAllObjects];
            }
            [self.gxList addObjectsFromArray:list];
            if ([self.tableView.mj_header isRefreshing]) {
                [self.tableView.mj_header endRefreshing];
            }
        }else {
            if ([self.tableView.mj_header isRefreshing]) {
                [self.tableView.mj_header endRefreshing];
            }
        }
        [self.tableView reloadData];
    } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
        }
        if (self.gxList.count) {
            [self.gxList removeAllObjects];
        }
        [self.tableView reloadData];
    }];
}

- (void)sendFirstRequest {
    [MFHUDManager showLoading:@"加载中..."];
    [MFNETWROK get:@"http://gaoxiaoshipin.vipappsina.com/index.php/NewApi38/index/markId/0/random/0/sw/0" params:nil success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
        [MFHUDManager dismiss];
        NSMutableArray *list = [NSMutableArray array];
        for (NSDictionary *dic in result[@"rows"]) {
            ZDDGXModel *model = [ZDDGXModel yy_modelWithJSON:dic];
            [list addObject:model];
        }
        if (list.count) {
            if (self.gxList.count) {
                [self.gxList removeAllObjects];
            }
            [self.gxList addObjectsFromArray:list];
        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
        [MFHUDManager dismiss];
        NSLog(@"%@", error.userInfo);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搞笑";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self sendFirstRequest];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.gxList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZDDGXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"gx"];
    if (!cell) {
        cell = [[ZDDGXTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"gx"];
    }
    ZDDGXModel *model = self.gxList[indexPath.row];
    [self configCell:cell withModel:model];
    return cell;
    
}

- (void)configCell:(ZDDGXTableViewCell *)cell withModel:(ZDDGXModel *)model {
    
    [cell.gxImageView yy_setImageWithURL:[NSURL URLWithString:model.pic] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    cell.summaryLabel.text = model.title;
    [cell.summaryLabel sizeToFit];
    cell.summaryLabel.frame = CGRectMake(cell.summaryLabel.frame.origin.x, cell.summaryLabel.frame.origin.y, ScreenWidth - 20 - 110 - 10 - 5, cell.summaryLabel.frame.size.height);
    cell.dateLabel.text = model.cTime;
    cell.zanLabel.text = [NSString stringWithFormat:@"%@", @(model.zan_num)];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZDDGXModel *model = self.gxList[indexPath.row];
    if (self.navigationController.viewControllers.count == 1) {
        ZDDDisplayVideoViewController *display = [[ZDDDisplayVideoViewController alloc] init];
        display.model = model;
        [self.navigationController pushViewController:display animated:YES];
    }else {
        return;
    }
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor clearColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}
@end
