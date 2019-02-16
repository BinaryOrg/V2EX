//
//  ZDDTool.h
//  V2EX
//
//  Created by Maker on 2019/2/14.
//  Copyright © 2019 binary. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZDDTool : NSObject
/**
 获取当前时间
 
 @return yyyyMMddHHmmss 格式 -- 时间字符串
 */
+ (NSString *)getCurrentTime;
@end

NS_ASSUME_NONNULL_END
