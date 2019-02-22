//
//  ZDDTabFourDetail1ViewController.m
//  V2EX
//
//  Created by 张冬冬 on 2019/2/22.
//  Copyright © 2019 binary. All rights reserved.
//

#import "ZDDTabFourDetail1ViewController.h"
#import <MFNetworkManager/MFNetworkManager.h>
#import <MJRefresh.h>
#import <YYWebImage.h>
#import "ZDDBZModel.h"
#import "ZDDBZTableViewCell.h"
#import "ZDDBZ2TableViewCell.h"
#import "ZDDBZ3TableViewCell.h"
#import "ZDDBZ4TableViewCell.h"
#import "UIColor+ZDDColor.h"
#import "Topics.h"
#import "Pagination.h"
#import <ESPictureBrowser/ESPictureBrowser.h>
@interface ZDDTabFourDetail1ViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
MFNetworkManagerDelegate,
ESPictureBrowserDelegate
>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray<Topics *> *bzList;
@property (nonatomic, strong) Pagination *pagination;
@property(nonatomic, assign) NSInteger current;
@end

@implementation ZDDTabFourDetail1ViewController

- (NSMutableArray<Topics *> *)bzList {
    if (!_bzList) {
        _bzList = @[].mutableCopy;
    }
    return _bzList;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, StatusBarHeight, ScreenWidth, ScreenHeight - StatusBarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
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
            [weakSelf mf_loadMoreDataWithId:weakSelf.pagination.last_key];
        }];
        _tableView.mj_footer = footer;
        
    }
    return _tableView;
}

- (void)mf_loadMoreDataWithId:(NSInteger)key {
    if (!self.bzList.count) {
        if ([self.tableView.mj_footer isRefreshing]) {
            [self.tableView.mj_footer endRefreshing];
        }
        return;
    }
    [MFNETWROK get:[NSString stringWithFormat:@"http://notch.qdaily.com/api/v2/wallpaper_topics?last_key=%@&platform=ios", @(key)] params:nil success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
        NSLog(@"-----loadmore: %@", result[@"meta"][@"pagination"]);
        NSMutableArray *list = [NSMutableArray array];
        for (NSDictionary *dic in result[@"topics"]) {
            Topics *model = [Topics yy_modelWithJSON:dic];
            [list addObject:model];
        }
        self.pagination = [Pagination yy_modelWithJSON:result[@"meta"][@"pagination"]];
        if (list.count) {
            [self.bzList addObjectsFromArray:list];
            
        }
        if ([self.tableView.mj_footer isRefreshing]) {
            if (self.pagination.has_more) {
                [self.tableView.mj_footer endRefreshing];
            }else {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [self.tableView reloadData];
    } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
        if ([self.tableView.mj_footer isRefreshing]) {
            [self.tableView.mj_footer endRefreshing];
        }
    }];
}

- (void)mf_refreshData {
    [MFNETWROK get:@"http://notch.qdaily.com/api/v2/wallpaper_topics?last_key=0&platform=ios" params:nil success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
        NSLog(@"-----refresh: %@", result[@"meta"][@"pagination"]);
        [self.tableView.mj_footer resetNoMoreData];
        NSMutableArray *list = [NSMutableArray array];
        for (NSDictionary *dic in result[@"topics"]) {
            Topics *model = [Topics yy_modelWithJSON:dic];
            [list addObject:model];
        }
        self.pagination = [Pagination yy_modelWithJSON:result[@"meta"][@"pagination"]];
        if (list.count) {
            
            if (self.bzList.count) {
                [self.bzList removeAllObjects];
            }
            [self.bzList addObjectsFromArray:list];
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
        if (self.bzList.count) {
            [self.bzList removeAllObjects];
        }
        [self.tableView reloadData];
    }];
}

- (void)sendFirstRequest {
    [MFHUDManager showLoading:@"加载中..."];
    [MFNETWROK get:@"http://notch.qdaily.com/api/v2/wallpaper_topics?last_key=0&platform=ios" params:nil success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
        [MFHUDManager dismiss];
        NSLog(@"-----first: %@", result[@"meta"][@"pagination"]);
        NSMutableArray *list = [NSMutableArray array];
        for (NSDictionary *dic in result[@"topics"]) {
            Topics *model = [Topics yy_modelWithJSON:dic];
            [list addObject:model];
        }
        self.pagination = [Pagination yy_modelWithJSON:result[@"meta"][@"pagination"]];
        if (list.count) {
            if (self.bzList.count) {
                [self.bzList removeAllObjects];
            }
            [self.bzList addObjectsFromArray:list];
        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
        [MFHUDManager dismiss];
        NSLog(@"%@", error.userInfo);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"壁纸";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self sendFirstRequest];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bzList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Topics *model = self.bzList[indexPath.row];
    if (model.pictures.count == 1) {
        ZDDBZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bz1"];
        if (!cell) {
            cell = [[ZDDBZTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"bz1"];
        }
        [self configCell1:cell withModel:model];
        return cell;
    }else if (model.pictures.count == 2) {
        ZDDBZ2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bz2"];
        if (!cell) {
            cell = [[ZDDBZ2TableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"bz2"];
        }
        [self configCell2:cell withModel:model];
        return cell;
    }else if (model.pictures.count == 3) {
        ZDDBZ3TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bz3"];
        if (!cell) {
            cell = [[ZDDBZ3TableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"bz3"];
        }
        [self configCell3:cell withModel:model];
        return cell;
    }else {
        ZDDBZ4TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bz4"];
        if (!cell) {
            cell = [[ZDDBZ4TableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"bz4"];
        }
        [self configCell4:cell withModel:model];
        return cell;
    }
    return nil;
}

- (void)configCell1:(ZDDBZTableViewCell *)cell withModel:(Topics *)model {
    
    [cell.imageView yy_setImageWithURL:[NSURL URLWithString:model.pictures.firstObject.pic_info.medium] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    cell.titleLabel.text = model.title;
    cell.summaryLabel.text = model.description1;
    cell.dateLabel.text = [self formatFromTS:model.publish_at];
    
    [cell.button1 addTarget:self action:@selector(button1Click:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)configCell2:(ZDDBZ2TableViewCell *)cell withModel:(Topics *)model {
    [cell.imageView1 yy_setImageWithURL:[NSURL URLWithString:model.pictures.firstObject.pic_info.medium] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    [cell.imageView2 yy_setImageWithURL:[NSURL URLWithString:model.pictures.lastObject.pic_info.medium] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    cell.titleLabel.text = model.title;
    cell.summaryLabel.text = model.description1;
    cell.dateLabel.text = [self formatFromTS:model.publish_at];
    
    [cell.button1 addTarget:self action:@selector(button1Click:) forControlEvents:UIControlEventTouchUpInside];
    [cell.button2 addTarget:self action:@selector(button2Click:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)configCell3:(ZDDBZ3TableViewCell *)cell withModel:(Topics *)model {
    [cell.imageView1 yy_setImageWithURL:[NSURL URLWithString:model.pictures.firstObject.pic_info.medium] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    [cell.imageView2 yy_setImageWithURL:[NSURL URLWithString:model.pictures[1].pic_info.medium] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    [cell.imageView3 yy_setImageWithURL:[NSURL URLWithString:model.pictures.lastObject.pic_info.medium] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    cell.titleLabel.text = model.title;
    cell.summaryLabel.text = model.description1;
    cell.dateLabel.text = [self formatFromTS:model.publish_at];
    
    [cell.button1 addTarget:self action:@selector(button1Click:) forControlEvents:UIControlEventTouchUpInside];
    [cell.button2 addTarget:self action:@selector(button2Click:) forControlEvents:UIControlEventTouchUpInside];
    [cell.button3 addTarget:self action:@selector(button3Click:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)configCell4:(ZDDBZ4TableViewCell *)cell withModel:(Topics *)model {
    [cell.imageView1 yy_setImageWithURL:[NSURL URLWithString:model.pictures.firstObject.pic_info.medium] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    [cell.imageView2 yy_setImageWithURL:[NSURL URLWithString:model.pictures[1].pic_info.medium] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    [cell.imageView3 yy_setImageWithURL:[NSURL URLWithString:model.pictures[2].pic_info.medium] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    [cell.imageView4 yy_setImageWithURL:[NSURL URLWithString:model.pictures.lastObject.pic_info.medium] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    cell.titleLabel.text = model.title;
    cell.summaryLabel.text = model.description1;
    cell.dateLabel.text = [self formatFromTS:model.publish_at];
    
    [cell.button1 addTarget:self action:@selector(button1Click:) forControlEvents:UIControlEventTouchUpInside];
    [cell.button2 addTarget:self action:@selector(button2Click:) forControlEvents:UIControlEventTouchUpInside];
    [cell.button3 addTarget:self action:@selector(button3Click:) forControlEvents:UIControlEventTouchUpInside];
    [cell.button4 addTarget:self action:@selector(button4Click:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)button1Click:(UIButton *)sender {
    NSLog(@"%@", sender.superview.superview.superview);
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)sender.superview.superview.superview];
    NSLog(@"%@", @(indexPath.row));
    ESPictureBrowser *browser = [[ESPictureBrowser alloc] init];
    [browser setDelegate:self];
    [browser setLongPressBlock:^(NSInteger index) {
        UIImageWriteToSavedPhotosAlbum(((UIImageView *)sender.superview).image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }];
    self.current = indexPath.row;
    [browser showFromView:sender.superview picturesCount:self.bzList[indexPath.row].pictures.count currentPictureIndex:0];
}

- (void)button2Click:(UIButton *)sender {
    NSLog(@"%@", sender.superview.superview.superview);
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)sender.superview.superview.superview];
    NSLog(@"%@", @(indexPath.row));
    ESPictureBrowser *browser = [[ESPictureBrowser alloc] init];
    [browser setDelegate:self];
    [browser setLongPressBlock:^(NSInteger index) {
        UIImageWriteToSavedPhotosAlbum(((UIImageView *)sender.superview).image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }];
    self.current = indexPath.row;
    [browser showFromView:sender.superview picturesCount:self.bzList[indexPath.row].pictures.count currentPictureIndex:1];
}

- (void)button3Click:(UIButton *)sender {
    NSLog(@"%@", sender.superview.superview.superview);
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)sender.superview.superview.superview];
    NSLog(@"%@", @(indexPath.row));
    ESPictureBrowser *browser = [[ESPictureBrowser alloc] init];
    [browser setDelegate:self];
    [browser setLongPressBlock:^(NSInteger index) {
        UIImageWriteToSavedPhotosAlbum(((UIImageView *)sender.superview).image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }];
    self.current = indexPath.row;
    [browser showFromView:sender.superview picturesCount:self.bzList[indexPath.row].pictures.count currentPictureIndex:2];
}

- (void)button4Click:(UIButton *)sender {
    NSLog(@"%@", sender.superview.superview.superview);
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)sender.superview.superview.superview];
    NSLog(@"%@", @(indexPath.row));
    ESPictureBrowser *browser = [[ESPictureBrowser alloc] init];
    [browser setDelegate:self];
    [browser setLongPressBlock:^(NSInteger index) {
        UIImageWriteToSavedPhotosAlbum(((UIImageView *)sender.superview).image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }];
    self.current = indexPath.row;
    [browser showFromView:sender.superview picturesCount:self.bzList[indexPath.row].pictures.count currentPictureIndex:3];
}

#pragma mark -- <保存到相册>
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){
        msg = @"保存图片失败" ;
        [MFHUDManager showError:msg];
    }else{
        msg = @"保存图片成功" ;
        [MFHUDManager showSuccess:msg];
    }
}

- (UIImage *)pictureView:(ESPictureBrowser *)pictureBrowser defaultImageForIndex:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.current inSection:0];
    NSInteger count = self.bzList[self.current].pictures.count;
    if (count == 1) {
        ZDDBZTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        return cell.imageView1.image;
    }
    else if (count == 2) {
        ZDDBZ2TableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (index) {
            return cell.imageView2.image;
        }
        return cell.imageView1.image;
    }
    else if (count == 3) {
        ZDDBZ3TableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (index == 1) {
            return cell.imageView2.image;
        }
        else if (index == 2) {
            return cell.imageView3.image;
        }
        return cell.imageView1.image;
    }
    else {
        ZDDBZ4TableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (index == 1) {
            return cell.imageView2.image;
        }
        else if (index == 2) {
            return cell.imageView3.image;
        }
        else if (index == 3) {
            return cell.imageView4.image;
        }
        return cell.imageView1.image;
    }
}

- (NSString *)pictureView:(ESPictureBrowser *)pictureBrowser highQualityUrlStringForIndex:(NSInteger)index {
    NSLog(@"%@", @(index));
    return self.bzList[self.current].pictures[index].pic_info.original;
}

- (UIView *)pictureView:(ESPictureBrowser *)pictureBrowser viewForIndex:(NSInteger)index {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.current inSection:0];
    NSInteger count = self.bzList[self.current].pictures.count;
    if (count == 1) {
        ZDDBZTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        return cell.imageView1;
    }
    else if (count == 2) {
        ZDDBZ2TableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (index) {
            return cell.imageView2;
        }
        return cell.imageView1;
    }
    else if (count == 3) {
        ZDDBZ3TableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (index == 1) {
            return cell.imageView2;
        }
        else if (index == 2) {
            return cell.imageView3;
        }
        return cell.imageView1;
    }
    else {
        ZDDBZ4TableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (index == 1) {
            return cell.imageView2;
        }
        else if (index == 2) {
            return cell.imageView3;
        }
        else if (index == 3) {
            return cell.imageView4;
        }
        return cell.imageView1;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor clearColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Topics *model = self.bzList[indexPath.row];
    if (model.pictures.count == 1) {
        return 150 + ((ScreenWidth - 80)/2)*16/9;
    }else if (model.pictures.count == 2) {
        return 150 + ((ScreenWidth - 80)/2)*16/9;
    }else if (model.pictures.count == 2) {
        return 160 + (((ScreenWidth - 80)/2)*16/9)*2;
    }else {
        return 160 + (((ScreenWidth - 80)/2)*16/9)*2;
    }
}

- (NSString *)formatFromTS:(NSInteger)ts {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM yyyy"];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSString *str = [NSString stringWithFormat:@"%@",
                     [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:ts]]];
    return str;
}

@end
