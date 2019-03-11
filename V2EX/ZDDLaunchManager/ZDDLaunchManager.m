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
#import "ZDDTabTrheeViewController.h"
#import "ZDDTabFourViewController.h"
#import "ZDDNavController.h"
#import "LHMinController.h"

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
//    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    [[UINavigationBar appearance] setBarTintColor:[UIColor customBlueColor]];
//    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setTintColor:[UIColor customBlueColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    ZDDTabOneViewController *one = [[ZDDTabOneViewController alloc] initWithImageName:@"tab_now_book_unSelected" selectedImageName:@"tab_now_book_selected" title:@""];
//    ZDDTabTwoViewController *two = [[ZDDTabTwoViewController alloc] initWithImageName:@"tab_see_nor" selectedImageName:@"tab_see_press" title:@""];
    
//    ZDDTabTrheeViewController *three = [[ZDDTabTrheeViewController alloc] initWithImageName:@"tab_qworld_nor" selectedImageName:@"tab_qworld_press" title:@""];

    LHMinController *three = [[LHMinController alloc] initWithImageName:@"tab_mine_unSelected" selectedImageName:@"tab_mine_selected" title:@""];
    
    
    
    ZDDTabFourViewController *four = [[ZDDTabFourViewController alloc] initWithImageName:@"tab_tu_selected" selectedImageName:@"tab_tu_unSelected" title:@""];
    
    ZDDNavController *oneNavi = [[ZDDNavController alloc] initWithRootViewController:one];
//    ZDDNavController *twoNavi = [[ZDDNavController alloc] initWithRootViewController:two];
    ZDDNavController *threeNavi = [[ZDDNavController alloc] initWithRootViewController:three];
    ZDDNavController *fourNavi = [[ZDDNavController alloc] initWithRootViewController:four];
   
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[
                                         oneNavi,
                                         fourNavi,
//                                         twoNavi,
                                         threeNavi,
//                                         fourNavi
                                         ];
    

    
    window.rootViewController = tabBarController;
    
    window.backgroundColor = [UIColor whiteColor];
    [window makeKeyAndVisible];
}
@end
