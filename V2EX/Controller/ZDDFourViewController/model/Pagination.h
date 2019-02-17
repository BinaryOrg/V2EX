//
//  Pagination.h
//  V2EX
//
//  Created by pipelining on 2019/2/17.
//  Copyright © 2019年 binary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
@interface Pagination : NSObject

@property(nonatomic, assign) NSInteger last_key;
@property(nonatomic, assign) BOOL has_more;
@end
