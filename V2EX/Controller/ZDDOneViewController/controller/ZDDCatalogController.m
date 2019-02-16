//
//  ZDDCatalogController.m
//  V2EX
//
//  Created by Maker on 2019/2/16.
//  Copyright © 2019 binary. All rights reserved.
//

#import "ZDDCatalogController.h"
#import "ZDDHomeListController.h"
#import "ZDDManHuaController.h"


#import <MJRefresh.h>
#import "ZDDManHuaCatalogModel.h"

@interface ZDDCatalogController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

/** <#class#> */
@property (nonatomic, strong) ZDDManHuaCatalogModel *mainModel;

@end

@implementation ZDDCatalogController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)setupUI {
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(tableViewDidTriggerHeaderRefresh)];
}

- (void)setComic_id:(NSInteger)comic_id {
    _comic_id = comic_id;
    [self tableViewDidTriggerHeaderRefresh];

}

- (void)tableViewDidTriggerHeaderRefresh {
    
    [MFHUDManager showLoading:@"请求中..."];
    NSDictionary *paragmras = @{
                                };
    NSString *url = [NSString stringWithFormat:@"http://ios-getcomicinfo.321mh.com/app_api/v5/getcomicinfo_body/?platformname=iphone&comic_id=%ld&productname=aym", (long)self.comic_id];
    MFNETWROK.requestSerialization = MFJSONRequestSerialization;
    [MFNETWROK post:url params:paragmras success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
        [MFHUDManager dismiss];
        [self.tableView.mj_header endRefreshing];
        if (statusCode == 200) {
            self.mainModel = [ZDDManHuaCatalogModel yy_modelWithJSON:result];
            
            [self.tableView reloadData];
        }else {
            [MFHUDManager showError:@"请求失败"];
        }
    } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
        [self.tableView.mj_header endRefreshing];

        [MFHUDManager dismiss];
        [MFHUDManager showError:@"请求失败"];
    }];
    
}

#pragma mark - 追问/回答的数据源+代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mainModel.comic_chapter.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    ZDDManHuaCapterModel *model =  self.mainModel.comic_chapter[indexPath.row];
    cell.textLabel.text = model.chapter_name;
    //    cell.backgroundColor = LHColor(arc4random()%255, arc4random()%255, arc4random()%255);
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZDDManHuaCapterModel *model =  self.mainModel.comic_chapter[indexPath.row];

    
    ZDDHomeListController *vc = [ZDDHomeListController new];
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:model.end_num];
    for (NSInteger i = 1; i < model.end_num + 1; i ++) {
        NSString *url = [NSString stringWithFormat:@"http://mhpic.jumanhua.com/%@", model.chapter_image.middle];
        url = [url stringByReplacingOccurrencesOfString:@"$$" withString:[NSString stringWithFormat:@"%d", 1]];
        [tempArr addObject:url];
    }
    vc.imagesArray = [tempArr copy];
//
//
//    ZDDManHuaController *vc = [ZDDManHuaController new];
//    vc.img_url = url;
    [self.navigationController pushViewController:vc animated:YES];
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
