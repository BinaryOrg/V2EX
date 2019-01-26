//
//  ZDDLaunchManager.m
//  V2EX
//
//  Created by pipelining on 2019/1/26.
//  Copyright © 2019年 binary. All rights reserved.
//

#import "ZDDLaunchManager.h"

#import <MFHUDManager.h>
#import "UIColor+CustomColors.h"
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
    
//    GODMainViewController *main = [[GODMainViewController alloc] init];
//    GODMusicViewController *music = [[GODMusicViewController alloc] init];
//    GODPersonViewController *person = [[GODPersonViewController alloc] init];
//    GODDynamicController *dynamic = [[GODDynamicController alloc] init];
//    UINavigationController *mainNavi = [[UINavigationController alloc] initWithRootViewController:main];
//    UINavigationController *personNavi = [[UINavigationController alloc] initWithRootViewController:person];
//    UINavigationController *musicNavi = [[UINavigationController alloc] initWithRootViewController:music];
//    UINavigationController *dynamicNavi = [[UINavigationController alloc] initWithRootViewController:dynamic];
//    
//    UITabBarController *tabBarController = [[UITabBarController alloc] init];
//    tabBarController.viewControllers = @[
//                                         mainNavi,
//                                         musicNavi,
//                                         dynamicNavi,
//                                         personNavi
//                                         ];
//    window.rootViewController = tabBarController;
    
    window.backgroundColor = [UIColor whiteColor];
    [window makeKeyAndVisible];
}
@end
