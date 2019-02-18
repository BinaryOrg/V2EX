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
#define AUTO_TAIL_LOADING_NUM_SCREENFULS  2.5

@interface ZDDPoetryDetailController ()

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
    
    [self.view addSubview:self.imgView];
    [self.view addSubview:self.coverView];
    [self.view addSubview:self.nameLb];
    [self.view addSubview:self.personLb];
    [self.view addSubview:self.contentLb];
    [self.contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(NavBarHeight + 150);
    }];
    
    self.imgView.yy_imageURL = [NSURL URLWithString:@"https://source.unsplash.com/random"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.nameLb shine];
    [self.personLb shine];
    [self.contentLb shine];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

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
