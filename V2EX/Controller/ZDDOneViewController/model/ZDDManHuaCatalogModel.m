//
//  ZDDManHuaCatalogModel.m
//  V2EX
//
//  Created by Maker on 2019/2/16.
//  Copyright © 2019 binary. All rights reserved.
//

#import "ZDDManHuaCatalogModel.h"

@implementation ZDDManHuaCatalogModel

// 声明模型中的数组中的元素是模型
+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{
             @"comic_chapter" : [ZDDManHuaCapterModel class],
             };
}
@end

@implementation ZDDManHuaCapterModel

@end


@implementation ZDDManHuaImageQualityModel

@end
