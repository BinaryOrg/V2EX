//
//  ZDDSDKManager.m
//  V2EX
//
//  Created by pipelining on 2019/1/26.
//  Copyright © 2019年 binary. All rights reserved.
//

#import "ZDDSDKManager.h"
#import <MFNetworkManager/MFNetworkManager.h>
#import <MFHUDManager/MFHUDManager.h>
#import "ZDDSDKConfigKey.h"

@interface ZDDSDKManager()
<
MFNetworkManagerDelegate
>
@end

@implementation ZDDSDKManager
+ (instancetype)sharedInstance {
    static ZDDSDKManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

/**
 *  启动，初始化
 */
- (void)launchInWindow:(UIWindow *)window {
    
    [MFHUDManager setHUDType:MFHUDTypeNormal];
    [MFNETWROK startMonitorNetworkType];
    MFNETWROK.baseURL = BASE_URL;
    MFNETWROK.delegate = self;
}

- (void)networkManager:(MFNetworkManager *)manager didConnectedWithPrompt:(NSString *)prompt {
    if (![MFHUDManager isShowing]) {
        [MFHUDManager showWarning:prompt];
    }
}
- (void)networkManager:(MFNetworkManager *)manager disDisConnectedWithPrompt:(NSString *)prompt {
    if (![MFHUDManager isShowing]) {
        [MFHUDManager showError:prompt];
    }
}
@end
