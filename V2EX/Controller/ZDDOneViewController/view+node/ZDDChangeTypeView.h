//
//  ZDDChangeTypeView.h
//  V2EX
//
//  Created by Maker on 2019/2/12.
//  Copyright © 2019 binary. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZDDChangeTypeViewDelegate <NSObject>

- (void)clickButtonAtIndex:(NSInteger)index;

@end
@interface ZDDChangeTypeView : UIView
@property (nonatomic, weak) id <ZDDChangeTypeViewDelegate> delegate;
- (instancetype)initWithTitles:(NSArray *)titles;
- (void)setSelectedIndex:(NSInteger)index;
@end
