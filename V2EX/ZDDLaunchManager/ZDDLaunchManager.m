//
//  ZDDLaunchManager.m
//  V2EX
//
//  Created by pipelining on 2019/1/26.
//  Copyright © 2019年 binary. All rights reserved.
//

#import "ZDDLaunchManager.h"
#import "UIColor+ZDDColor.h"
#import <MFHUDManager.h>


#import "ZDDTabOneViewController.h"
#import "ZDDTabTwoViewController.h"
#import "ZDDNavController.h"

@implementation ZDDLaunchManager
+ (instancetype)sharedInstance {
    static ZDDLaunchManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)launchInWindow:(UIWindow *)window {
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor themeColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor themeColor]];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    ZDDTabOneViewController *one = [[ZDDTabOneViewController alloc] initWithImageName:@"tab_now_nor" selectedImageName:@"tab_now_press" title:@"漫画"];
    ZDDTabTwoViewController *two = [[ZDDTabTwoViewController alloc] initWithImageName:@"tab_see_nor" selectedImageName:@"tab_see_press" title:@"诗词"];
    
    ZDDNavController *oneNavi = [[ZDDNavController alloc] initWithRootViewController:one];
    ZDDNavController *twoNavi = [[ZDDNavController alloc] initWithRootViewController:two];
//    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[
                                         oneNavi,
                                         twoNavi,
                                         ];
    window.rootViewController = tabBarController;
    
    window.backgroundColor = [UIColor whiteColor];
    [window makeKeyAndVisible];
}
@end
