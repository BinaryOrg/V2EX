//
//  Topics.m
//  V2EX
//
//  Created by pipelining on 2019/2/17.
//  Copyright © 2019年 binary. All rights reserved.
//

#import "Topics.h"

@implementation Topics
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"description1" : @"description"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"pictures" : [Pictures class]};
}
@end
