//
//  ZDDTabFourViewController.m
//  V2EX
//
//  Created by pipelining on 2019/2/17.
//  Copyright © 2019年 binary. All rights reserved.
//

#import "ZDDTabFourViewController.h"
#import <MFNetworkManager/MFNetworkManager.h>

#import <YYWebImage.h>

#import "UIColor+ZDDColor.h"
#import "Topics.h"
#import "Pagination.h"

#import "ZDDTabFourDetail1ViewController.h"
#import "ZDDTabFourDetail2ViewController.h"

#import "ZDDTabFour1TableViewCell.h"
#import "ZDDTabFour2TableViewCell.h"

@interface ZDDTabFourViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *dic;

@end

@implementation ZDDTabFourViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, StatusBarHeight, ScreenWidth, ScreenHeight - StatusBarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}


- (void)sendFirstRequest {
    [MFHUDManager showLoading:@"加载中..."];
    [MFNETWROK get:@"https://api.godzzzzz.club/api/v2ex/getQdaily" params:nil success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
        [MFHUDManager dismiss];
        self.dic = result;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view addSubview:self.tableView];
            [self.tableView reloadData];
        });
    } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
        [MFHUDManager dismiss];
        NSLog(@"%@", error.userInfo);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"嘎嘎";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self sendFirstRequest];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.row) {
        NSLog(@"%@", self.dic[@"wallpaper"][@"pic"]);
        ZDDTabFour1TableViewCell *cell = [[ZDDTabFour1TableViewCell alloc] init];
        [cell.bzImageView yy_setImageWithURL:[NSURL URLWithString:self.dic[@"wallpaper"][@"pic"]] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
        cell.bzLabel.text = self.dic[@"wallpaper"][@"title"];
        
        [cell.imageView1 yy_setImageWithURL:[NSURL URLWithString:self.dic[@"wallpaper"][@"pictures"][0][@"pic"]] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
        cell.label1.text = self.dic[@"wallpaper"][@"pictures"][0][@"topic_title"];
        cell.dateLabel1.text = [self formatFromTS:[self.dic[@"wallpaper"][@"pictures"][0][@"publish_at"] integerValue]];
        
        [cell.imageView2 yy_setImageWithURL:[NSURL URLWithString:self.dic[@"wallpaper"][@"pictures"][1][@"pic"]] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
        cell.label2.text = self.dic[@"wallpaper"][@"pictures"][1][@"topic_title"];
        cell.dateLabel2.text = [self formatFromTS:[self.dic[@"wallpaper"][@"pictures"][1][@"publish_at"] integerValue]];
        
        [cell.imageView3 yy_setImageWithURL:[NSURL URLWithString:self.dic[@"wallpaper"][@"pictures"][2][@"pic"]] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
        cell.label3.text = self.dic[@"wallpaper"][@"pictures"][2][@"topic_title"];
        cell.dateLabel3.text = [self formatFromTS:[self.dic[@"wallpaper"][@"pictures"][2][@"publish_at"] integerValue]];
        
        [cell.imageView4 yy_setImageWithURL:[NSURL URLWithString:self.dic[@"wallpaper"][@"pictures"][3][@"pic"]] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
        cell.label4.text = self.dic[@"wallpaper"][@"pictures"][3][@"topic_title"];
        cell.dateLabel4.text = [self formatFromTS:[self.dic[@"wallpaper"][@"pictures"][3][@"publish_at"] integerValue]];
        
        [cell.imageView5 yy_setImageWithURL:[NSURL URLWithString:self.dic[@"wallpaper"][@"pictures"][4][@"pic"]] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
        cell.label5.text = self.dic[@"wallpaper"][@"pictures"][4][@"topic_title"];
        cell.dateLabel5.text = [self formatFromTS:[self.dic[@"wallpaper"][@"pictures"][4][@"publish_at"] integerValue]];
        
        [cell.imageView6 yy_setImageWithURL:[NSURL URLWithString:self.dic[@"wallpaper"][@"pictures"][5][@"pic"]] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
        cell.label6.text = self.dic[@"wallpaper"][@"pictures"][5][@"topic_title"];
        cell.dateLabel6.text = [self formatFromTS:[self.dic[@"wallpaper"][@"pictures"][5][@"publish_at"] integerValue]];
        return cell;
    }
    
    
    ZDDTabFour2TableViewCell *cell = [[ZDDTabFour2TableViewCell alloc] init];
    [cell.txImageView yy_setImageWithURL:[NSURL URLWithString:self.dic[@"avatar"][@"pic"]] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    cell.txLabel.text = self.dic[@"avatar"][@"title"];
    [cell.imageView1 yy_setImageWithURL:[NSURL URLWithString:self.dic[@"avatar"][@"pictures"][0][@"pic"]] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    cell.label1.text = self.dic[@"avatar"][@"pictures"][0][@"topic_title"];
    cell.dateLabel.text = [self formatFromTS:[self.dic[@"avatar"][@"pictures"][0][@"publish_at"] integerValue]];
    cell.label2.text = self.dic[@"avatar"][@"pictures"][0][@"topic_description"];
    
    [cell.imageView2 yy_setImageWithURL:[NSURL URLWithString:self.dic[@"avatar"][@"pictures"][1][@"pic"]] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    
    
    [cell.imageView3 yy_setImageWithURL:[NSURL URLWithString:self.dic[@"avatar"][@"pictures"][2][@"pic"]] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    
    
    [cell.imageView4 yy_setImageWithURL:[NSURL URLWithString:self.dic[@"avatar"][@"pictures"][3][@"pic"]] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat bzImageHeight = ((ScreenWidth - 60)/3)*16/9;
    if (!indexPath.row) {
        return (bzImageHeight + 55) * 2 + 60 + 10;
    }
    
    CGFloat smallimageWidth = (ScreenWidth - 60) / 3;
    return (smallimageWidth + 10) * 3 + 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.row) {
        ZDDTabFourDetail1ViewController *detail1 = [[ZDDTabFourDetail1ViewController alloc] init];
        [self.navigationController pushViewController:detail1 animated:YES];
    }
    else {
        ZDDTabFourDetail2ViewController *detail2 = [[ZDDTabFourDetail2ViewController alloc] init];
        [self.navigationController pushViewController:detail2 animated:YES];
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
