//
//  ZDDGXModel.h
//  V2EX
//
//  Created by pipelining on 2019/2/16.
//  Copyright © 2019年 binary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
@interface ZDDGXModel : NSObject
@property(nonatomic, strong) NSString *title;
@property(nonatomic, assign) NSInteger id;
@property(nonatomic, strong) NSString *pic;
@property(nonatomic, strong) NSString *url;
@property(nonatomic, strong) NSString *cTime;
@property(nonatomic, assign) NSInteger zan_num;
@end
