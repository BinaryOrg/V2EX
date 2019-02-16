//
//  NSMutableDictionary+ZDD.h
//  V2EX
//
//  Created by Maker on 2019/2/16.
//  Copyright © 2019 binary. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary (ZDD)
- (NSMutableDictionary *(^)(UIColor *))lh_color;
- (NSMutableDictionary *(^)(UIFont *))lh_font;
- (NSMutableDictionary *(^)(NSMutableParagraphStyle *))lh_paraStyle;
@end

NS_ASSUME_NONNULL_END
