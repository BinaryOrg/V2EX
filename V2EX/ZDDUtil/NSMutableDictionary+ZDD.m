//
//  NSMutableDictionary+ZDD.m
//  V2EX
//
//  Created by Maker on 2019/2/16.
//  Copyright © 2019 binary. All rights reserved.
//

#import "NSMutableDictionary+ZDD.h"

@implementation NSMutableDictionary (ZDD)


- (NSMutableDictionary *(^)(UIColor *))lh_color {
    return ^id (UIColor *Color) {
        [self setObject:Color forKey:NSForegroundColorAttributeName];
        return self;
    };
}

- (NSMutableDictionary *(^)(UIFont *))lh_font {
    return ^id (UIFont *Font) {
        [self setObject:Font forKey:NSFontAttributeName];
        return self;
    };
}

- (NSMutableDictionary *(^)(NSMutableParagraphStyle *))lh_paraStyle {
    return ^id (NSMutableParagraphStyle *ParaStyle) {
        [self setObject:ParaStyle forKey:NSParagraphStyleAttributeName];
        return self;
    };
}

@end
