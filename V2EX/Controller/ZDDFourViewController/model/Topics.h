//
//  Topics.h
//  V2EX
//
//  Created by pipelining on 2019/2/17.
//  Copyright © 2019年 binary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
#import "Pictures.h"
@interface Topics : NSObject
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *description1;
@property(nonatomic, assign) NSInteger publish_at;
@property(nonatomic, strong) NSArray<Pictures *> *pictures;
@end
