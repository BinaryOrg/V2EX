//
//  ZDDManHuaListModel.m
//  V2EX
//
//  Created by Maker on 2019/2/16.
//  Copyright © 2019 binary. All rights reserved.
//

#import "ZDDManHuaListModel.h"

@implementation ZDDManHuaListModel

// 声明模型中的数组中的元素是模型
+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{
             @"comic_info" : [ZDDBookListModel class],
             };
}

@end

@implementation ZDDBookConfigModel

@end

@implementation ZDDBookListModel

@end


