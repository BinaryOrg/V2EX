//
//  ZDDPoetryModel.h
//  V2EX
//
//  Created by Maker on 2019/2/16.
//  Copyright © 2019 binary. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZDDPoetryModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *authors;
@property (nonatomic, strong) NSString *id;
/** 是否收藏 */
@property (nonatomic, assign) BOOL isCollected;
@end

NS_ASSUME_NONNULL_END
