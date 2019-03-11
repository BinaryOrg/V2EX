//
//  ZDDMyCollectController.m
//  V2EX
//
//  Created by Maker on 2019/3/11.
//  Copyright © 2019 binary. All rights reserved.
//

#import "ZDDMyCollectController.h"
#import "ZDDPoetryModel.h"
#import "ZDDContentDetailController.h"

@interface ZDDMyCollectController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation ZDDMyCollectController

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[].mutableCopy;
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    
    self.title = @"我的收藏";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self tableViewDidTriggerHeaderRefresh];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadData];
}

- (void)reloadData {
    NSDictionary *paragmras = @{
                                @"phone" : [GODUserTool shared].user.phone
                                };
    MFNETWROK.requestSerialization = MFJSONRequestSerialization;
    [MFNETWROK get:@"getcollectionpoetry" params:paragmras success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
        [MFHUDManager dismiss];
        if (statusCode == 200) {
            if (self.dataArr.count) {
                [self.dataArr removeAllObjects];
            }
            //            self.dataArr = [NSArray yy_modelArrayWithClass:ZDDPoetryModel.class json:result];
            for (NSDictionary *dic in result) {
                ZDDPoetryModel *poetry = [ZDDPoetryModel yy_modelWithJSON:dic];
                poetry.isCollected = YES;
                [self.dataArr addObject:poetry];
            }
            [self.tableView reloadData];
        }else {
           
        }
    } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
        
    }];
}

- (void)tableViewDidTriggerHeaderRefresh {
    
    [MFHUDManager showLoading:@"请求中..."];
    NSDictionary *paragmras = @{
                                @"phone" : [GODUserTool shared].user.phone
                                };
    MFNETWROK.requestSerialization = MFJSONRequestSerialization;
    [MFNETWROK get:@"getcollectionpoetry" params:paragmras success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
        [MFHUDManager dismiss];
        if (statusCode == 200) {
//            self.dataArr = [NSArray yy_modelArrayWithClass:ZDDPoetryModel.class json:result];
            for (NSDictionary *dic in result) {
                ZDDPoetryModel *poetry = [ZDDPoetryModel yy_modelWithJSON:dic];
                poetry.isCollected = YES;
                [self.dataArr addObject:poetry];
            }
            [self.tableView reloadData];
        }else {
            [MFHUDManager showError:@"请求失败"];
        }
    } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
        
        [MFHUDManager dismiss];
        [MFHUDManager showError:@"请求失败"];
    }];
    
}

#pragma mark - 追问/回答的数据源+代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    ZDDPoetryModel *model =  self.dataArr[indexPath.row];
    cell.textLabel.text = model.title;
    cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:16];
    cell.textLabel.textColor = color(137, 137, 137, 1);
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZDDPoetryModel *model =  self.dataArr[indexPath.row];
    ZDDContentDetailController *vc = [ZDDContentDetailController new];
    vc.topModel = model;
    [self.navigationController pushViewController:vc animated:YES];
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
}

@end
