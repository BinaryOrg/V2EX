//
//  ZDDPoertryCommentModel.h
//  V2EX
//
//  Created by Maker on 2019/2/28.
//  Copyright © 2019 binary. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZDDPoertryCommentModel : NSObject

/** <#class#> */
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) GODUserModel *user;


@end

NS_ASSUME_NONNULL_END
