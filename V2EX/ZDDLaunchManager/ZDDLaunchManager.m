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
    
    
    

    
    [[UITabBar appearance] setTintColor:[UIColor customBlueColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    ZDDTabOneViewController *one = [[ZDDTabOneViewController alloc] initWithImageName:@"tab_now_book_unSelected" selectedImageName:@"tab_now_book_selected" title:@""];

    LHMinController *three = [[LHMinController alloc] initWithImageName:@"tab_mine_unSelected" selectedImageName:@"tab_mine_selected" title:@""];
    
    
    
    ZDDTabFourViewController *four = [[ZDDTabFourViewController alloc] initWithImageName:@"tab_tu_selected" selectedImageName:@"tab_tu_unSelected" title:@""];
    
    ZDDNavController *oneNavi = [[ZDDNavController alloc] initWithRootViewController:one];
    ZDDNavController *threeNavi = [[ZDDNavController alloc] initWithRootViewController:three];
    ZDDNavController *fourNavi = [[ZDDNavController alloc] initWithRootViewController:four];
   
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[
                                         oneNavi,
                                         fourNavi,
                                         threeNavi,
                                         ];
    

    
    window.rootViewController = tabBarController;
    window.backgroundColor = [UIColor whiteColor];
    [window makeKeyAndVisible];
}
@end
