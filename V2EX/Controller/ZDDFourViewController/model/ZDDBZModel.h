//
//  ZDDBZModel.h
//  V2EX
//
//  Created by pipelining on 2019/2/17.
//  Copyright © 2019年 binary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
#import "Meta.h"
#import "Topics.h"
@interface ZDDBZModel : NSObject
@property(nonatomic, strong) Meta *meta;
@property(nonatomic, strong) Topics *topics;
@end
