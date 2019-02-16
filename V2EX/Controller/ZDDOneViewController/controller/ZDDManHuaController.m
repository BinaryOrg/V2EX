//
//  ZDDManHuaController.m
//  V2EX
//
//  Created by Maker on 2019/2/14.
//  Copyright © 2019 binary. All rights reserved.
//

#import "ZDDManHuaController.h"
#import <YYAnimatedImageView.h>
#import <YYImage.h>

@interface ZDDManHuaController ()

@property (nonatomic, strong) YYAnimatedImageView *iv;

@end

@implementation ZDDManHuaController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
   
    
}

- (void)setImg_url:(NSString *)img_url {
    
    _img_url = img_url;
    
    self.iv = [[YYAnimatedImageView alloc] init];
    [self.view addSubview:self.iv];
    [self.iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NavBarHeight);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(SafeAreaBottomHeight);
    }];
    self.iv.contentMode = UIViewContentModeScaleAspectFit;
    
    self.iv.yy_imageURL = [NSURL URLWithString:img_url];
    self.iv.backgroundColor = [UIColor redColor];
    NSLog(@"===%@", img_url);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
