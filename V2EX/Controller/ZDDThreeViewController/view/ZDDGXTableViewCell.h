//
//  ZDDGXTableViewCell.h
//  V2EX
//
//  Created by pipelining on 2019/2/16.
//  Copyright © 2019年 binary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDDGXTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *gxImageView;
@property (nonatomic ,strong) UILabel *dateLabel;
@property (nonatomic ,strong) UILabel *summaryLabel;
@property (nonatomic ,strong) UILabel *yearLabel;
@property (nonatomic, strong) UIImageView *zanImageView;
@property (nonatomic, strong) UILabel *zanLabel;
@end
