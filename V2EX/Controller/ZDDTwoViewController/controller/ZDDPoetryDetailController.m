//
//  ZDDPoetryDetailController.m
//  V2EX
//
//  Created by Maker on 2019/2/17.
//  Copyright © 2019 binary. All rights reserved.
//

#import "ZDDPoetryDetailController.h"
#import <CoreText/CoreText.h>
#import <RQShineLabel.h>
#import <UIImageView+YYWebImage.h>
#import "UINavigationController+FDFullscreenPopGesture.h"
#define AUTO_TAIL_LOADING_NUM_SCREENFULS  2.5

@interface ZDDPoetryDetailController ()
@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) RQShineLabel *nameLb;
@property (nonatomic, strong) RQShineLabel *personLb;
@property (nonatomic, strong) RQShineLabel *contentLb;

@end

@implementation ZDDPoetryDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
    [self.view addSubview:self.imgView];
    [self.view addSubview:self.coverView];
    [self.view addSubview:self.nameLb];
    [self.view addSubview:self.personLb];
    [self.view addSubview:self.contentLb];
    [self.contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(NavBarHeight + 150);
    }];
    self.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"aaa_%u", arc4random()%11]];
    
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(clickBakc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(StatusBarHeight + 20);
    }];
}

- (void)clickBakc {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.nameLb shine];
    [self.personLb shine];
    [self.contentLb shine];

}
- (void)setName:(NSString *)name {
    
    
    _name = name;
    self.nameLb.text = name;


}

-(void)setPerson:(NSString *)person {
    
    _person = person;
    self.personLb.text = person;

}


- (void)setContent:(NSString *)content {
    
    _content = content;
    self.contentLb.text = content;
    [self.contentLb sizeToFit];
}

- (RQShineLabel *)nameLb {
    if (!_nameLb ) {
        _nameLb = [[RQShineLabel alloc] initWithFrame:CGRectMake(0, NavBarHeight + 80, ScreenWidth, 20)];
        _nameLb.numberOfLines = 0;
        _nameLb.font = [UIFont systemFontOfSize:20];
        _nameLb.textColor = [UIColor blackColor];
        _nameLb.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLb;
}

- (RQShineLabel *)personLb {
    if (!_personLb ) {
        _personLb = [[RQShineLabel alloc] initWithFrame:CGRectMake(0, NavBarHeight + 110, ScreenWidth, 17)];
        _personLb.numberOfLines = 0;
        _personLb.font = [UIFont systemFontOfSize:14];
        _personLb.textColor = [UIColor blackColor];
        _personLb.textAlignment = NSTextAlignmentCenter;
    }
    return _personLb;
}

- (RQShineLabel *)contentLb {
    if (!_contentLb ) {
        _contentLb = [[RQShineLabel alloc] init];
        _contentLb.numberOfLines = 0;
        _contentLb.font = [UIFont systemFontOfSize:18];
        _contentLb.textColor = [UIColor blackColor];
        _contentLb.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLb;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:self.view.frame];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.layer.masksToBounds = YES;
    }
    return _imgView;
}

- (UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:self.view.frame];
        _coverView.backgroundColor = color(176,176, 176, 0.5);
    }
    return _coverView;
}
@end
