//
//  ZDDTXTableViewCell.h
//  V2EX
//
//  Created by 张冬冬 on 2019/2/22.
//  Copyright © 2019 binary. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZDDTXTableViewCell : UITableViewCell
@property (nonatomic ,strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic ,strong) UILabel *summaryLabel;
@property (nonatomic, strong) UIImageView *imageView1;
@property (nonatomic, strong) UIButton *button1;
@end

NS_ASSUME_NONNULL_END
