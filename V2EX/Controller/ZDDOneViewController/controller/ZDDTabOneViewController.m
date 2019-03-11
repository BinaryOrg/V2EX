//
//  ZDDTabOneViewController.m
//  V2EX
//
//  Created by pipelining on 2019/1/26.
//  Copyright © 2019年 binary. All rights reserved.
//

#import "ZDDTabOneViewController.h"
#import <GLYPageView.h>
#import "ZDDCenterController.h"
#import "ZDDTabTwoViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

#import "WHWeatherView.h"
#import "WHWeatherHeader.h"

@interface ZDDTabOneViewController ()<GLYPageViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) GLYPageView *pageView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) ZDDTabTwoViewController *firstVC;
@property (nonatomic, strong) ZDDCenterController *secondVC;

@property (nonatomic, strong) WHWeatherView *weatherView;

@end

@implementation ZDDTabOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}


- (void)setupUI {
    
    self.weatherView.weatherBackImageView.frame = self.view.bounds;
    [self.view addSubview:self.weatherView.weatherBackImageView];
    
    self.fd_prefersNavigationBarHidden = YES;
    
    [self.view addSubview:self.pageView];
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.firstVC.view];
    self.firstVC.view.frame = CGRectMake(0, 0, ScreenWidth, self.scrollView.height);
    
    [self.scrollView addSubview:self.secondVC.view];
    self.secondVC.view.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, self.scrollView.height);
    
    
    self.weatherView.frame = self.view.bounds;
    [[UIApplication sharedApplication].keyWindow  addSubview:self.weatherView];
    
    self.weatherView.userInteractionEnabled = NO;
    
    
//    for (UITabBarItem * i in self.tabBarController.tabBar.items) {
//        i.imageInsets = UIEdgeInsetsMake(10, 0, 0, 0);
//    }
    
}

- (void)pageViewSelectdIndex:(NSInteger)index {
    
    [self.scrollView setContentOffset:CGPointMake(ScreenWidth * index, 0) animated:YES];
    NSInteger x = arc4random()%50;
    NSInteger type = x % 6;
    [self.weatherView showWeatherAnimationWithType:type];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self.pageView externalScrollView:scrollView totalPage:2 startOffsetX:0];
    
}


- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.frame = CGRectMake(0, StatusBarHeight + 44, ScreenWidth, ScreenHeight - SafeTabBarHeight - StatusBarHeight - 44);
        _scrollView.contentSize = CGSizeMake(ScreenWidth * 2, ScreenHeight - SafeTabBarHeight - StatusBarHeight - 44);
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (GLYPageView *)pageView {
    if (!_pageView) {
        _pageView = [[GLYPageView alloc] initWithFrame:CGRectMake(0.f, StatusBarHeight, ScreenWidth, 44.f) titlesArray:@[@"诗",@"画"]];
        _pageView.delegate = self;
        _pageView.titleFont = [UIFont fontWithName:@"KohinoorDevanagari-Semibold" size:18];
        _pageView.selectTitleColor = [UIColor blackColor];
        _pageView.scrollViewBackgroundColor = [UIColor clearColor];
        _pageView.titleColor = color(137, 137, 137, 1);
        _pageView.backgroundColor = [UIColor clearColor];
        [_pageView initalUI];
    }
    return _pageView;
}

- (ZDDTabTwoViewController *)firstVC {
    if (!_firstVC) {
        _firstVC = [ZDDTabTwoViewController new];
        [self addChildViewController:_firstVC];
    }
    return _firstVC;
}

- (ZDDCenterController *)secondVC {
    if (!_secondVC) {
        _secondVC = [ZDDCenterController new];
        [self addChildViewController:_secondVC];
    }
    return _secondVC;
}



- (WHWeatherView *)weatherView {
    if (!_weatherView) {
        _weatherView = [[WHWeatherView alloc] init];
    }
    return _weatherView;
}

@end
