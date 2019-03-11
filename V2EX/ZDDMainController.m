//
//  ZDDMainController.m
//  V2EX
//
//  Created by Maker on 2019/3/11.
//  Copyright © 2019 binary. All rights reserved.
//

#import "ZDDMainController.h"

#import "UIColor+ZDDColor.h"


#import "ZDDTabOneViewController.h"
#import "ZDDTabTwoViewController.h"
#import "ZDDTabTrheeViewController.h"
#import "ZDDTabFourViewController.h"
#import "ZDDNavController.h"
#import "LHMinController.h"

#import "WHWeatherView.h"
#import "WHWeatherHeader.h"

@interface ZDDMainController ()

@property (nonatomic, strong) WHWeatherView *weatherView;


@end

@implementation ZDDMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITabBar appearance] setTintColor:[UIColor customBlueColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    self.weatherView.weatherBackImageView.frame = self.view.bounds;
    [self.view addSubview:self.weatherView.weatherBackImageView];
    
    ZDDTabOneViewController *one = [[ZDDTabOneViewController alloc] initWithImageName:@"tab_now_book_unSelected" selectedImageName:@"tab_now_book_selected" title:@""];
    
    
    LHMinController *three = [[LHMinController alloc] initWithImageName:@"tab_qworld_nor" selectedImageName:@"tab_qworld_press" title:@""];
    
    
    
    ZDDTabFourViewController *four = [[ZDDTabFourViewController alloc] initWithImageName:@"tab_tu_selected" selectedImageName:@"tab_tu_unSelected" title:@""];
    
    ZDDNavController *oneNavi = [[ZDDNavController alloc] initWithRootViewController:one];
    //    ZDDNavController *twoNavi = [[ZDDNavController alloc] initWithRootViewController:two];
    ZDDNavController *threeNavi = [[ZDDNavController alloc] initWithRootViewController:three];
    ZDDNavController *fourNavi = [[ZDDNavController alloc] initWithRootViewController:four];
    
    self.viewControllers = @[
                                         oneNavi,
                                         fourNavi,
                                         //                                         twoNavi,
                                         threeNavi,
                                         //                                         fourNavi
                                         ];
    
    
    self.weatherView.frame = self.view.bounds;
    [self.view addSubview:self.weatherView];
    
    self.weatherView.userInteractionEnabled = NO;
    
    
//    for (UITabBarItem * i in self.tabBarController.tabBar.items) {
//        i.imageInsets = UIEdgeInsetsMake(10, 0, 0, 0);
//    }
    
}



- (WHWeatherView *)weatherView {
    if (!_weatherView) {
        _weatherView = [[WHWeatherView alloc] init];
    }
    return _weatherView;
}

@end
