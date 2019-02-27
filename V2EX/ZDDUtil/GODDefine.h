//
//  GODDefine.h
//  Blogger
//
//  Created by pipelining on 2019/1/15.
//  Copyright © 2019年 GodzzZZZ. All rights reserved.
//

#ifndef GODDefine_h
#define GODDefine_h

#define NSLog(format, ...) do {                                                                          \
fprintf(stderr, "<%s : %d> %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "-------\n");                                               \
} while (0)

//系统版本
#define iOSVerson                         [[UIDevice currentDevice] systemVersion].floatValue

// 宽度
#define  ScreenWidth                             [UIScreen mainScreen].bounds.size.width

// 高度
#define  ScreenHeight                            [UIScreen mainScreen].bounds.size.height

/** 顶部导航栏高度 */
#define NavBarHeight (ScreenHeight >= 812.0 ? 88 : 64)
/** 顶部电源栏高度 */
#define StatusBarHeight (ScreenHeight >= 812.0 ? 44 : 20)
/** 底部安全距离高度[适配PhoneX底部] */
#define SafeAreaBottomHeight (ScreenHeight >= 812.0 ? 34 : 0)
/** 顶部安全距离高度[适配PhoneX底部] */
#define SafeAreaTopHeight (ScreenHeight >= 812.0 ? 24 : 0)
// 手机屏幕自动适配
#define AUTO_FIT(float) ((ScreenHeight < ScreenWidth ? ScreenHeight : ScreenWidth) / 375.0f * float)

#define color(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define GODColor(r, g, b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]

#define SafeTabBarHeight (CGFloat)(ScreenHeight >= 812.0?(49.0 + 34.0):(49.0))


// 安全执行Block
#define SAFE_BLOCK(BlockName, ...) ({ !BlockName ? nil : BlockName(__VA_ARGS__); })


#define LHScreenWidthRatio ((ScreenWidth) / 375.0)
#define LHAutoLayoutValue(value) ((value) * LHScreenWidthRatio)

#define yiyuanSign @"3e62dcb055264fd3b9d15db3e366d4e7"
#define yiyuanId @"87106"

#define BASE_AVATAR_URL   @"https://api.godzzzzz.club/"
#define BASE_URL          @"https://api.godzzzzz.club/api/"


#endif /* GODDefine_h */
