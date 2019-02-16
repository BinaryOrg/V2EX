//
//  ZDDHomeController.m
//  V2EX
//
//  Created by Maker on 2019/2/16.
//  Copyright © 2019 binary. All rights reserved.
//

#import "ZDDHomeController.h"
#import "ZDDCatalogController.h"

#import "ZDDHomeCelNode.h"

@interface ZDDHomeController ()<ASTableDelegate, ASTableDataSource>

@property (nonatomic, strong) ASTableNode *tableNode;


@end

@implementation ZDDHomeController

- (void)viewDidLoad {
    [super viewDidLoad];


    [self.view addSubview:self.tableNode.view];
    [self.tableNode.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

-(void)setDataArray:(NSArray<ZDDBookListModel *> *)dataArray {
    _dataArray = dataArray;
    [self.tableNode reloadData];
}


#pragma mark - tableViewDataSourceAndDelegate
- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ^ASCellNode *() {
        ZDDHomeCelNode *node = [[ZDDHomeCelNode alloc] initWithModel:self.dataArray[indexPath.row]];
        return node;
    };
    
}

- (void)tableNode:(ASTableNode *)tableNode didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableNode deselectRowAtIndexPath:indexPath animated:YES];
    ZDDBookListModel *model = self.dataArray[indexPath.row];
    ZDDCatalogController *vc = [[ZDDCatalogController alloc] init];
    vc.comic_id = model.comic_id;
    vc.title = model.comic_name;
    [self.navigationController pushViewController:vc animated:YES];
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


@end
