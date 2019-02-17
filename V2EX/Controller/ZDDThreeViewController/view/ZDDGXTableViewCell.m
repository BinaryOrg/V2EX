//
//  ZDDGXTableViewCell.m
//  V2EX
//
//  Created by pipelining on 2019/2/16.
//  Copyright © 2019年 binary. All rights reserved.
//

#import "ZDDGXTableViewCell.h"
#import "GODTableCard.h"
#import "GODDefine.h"
#import "UIColor+ZDDColor.h"
@interface ZDDGXTableViewCell()
@property (nonatomic ,strong) GODTableCard *containerView;
@end
@implementation ZDDGXTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        
        self.containerView = [[GODTableCard alloc] initWithFrame:CGRectMake(10, 5, ScreenWidth-20, 120)];
        [self.contentView addSubview:self.containerView];
        
        self.gxImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 110, 110)];
        self.gxImageView.layer.cornerRadius = 3;
        self.gxImageView.layer.masksToBounds = YES;
        self.gxImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.containerView addSubview:self.gxImageView];
        
        self.summaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.gxImageView.frame) + 5, 5, ScreenWidth - 20 - 110 - 10 - 5, 90)];
        [self.containerView addSubview:self.summaryLabel];
        self.summaryLabel.font = [UIFont systemFontOfSize:17];
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.gxImageView.frame) + 5, 95, 100, 20)];
        [self.containerView addSubview:self.dateLabel];
        self.dateLabel.font = [UIFont systemFontOfSize:13];
        self.dateLabel.textColor = [UIColor customGrayColor];
        
        self.summaryLabel.numberOfLines = 4;
        self.summaryLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        self.zanImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - 20 - 50, 95, 18, 18)];
        self.zanImageView.image = [UIImage imageNamed:@"ic_messages_like_selected_20x20_"];
        [self.containerView addSubview:self.zanImageView];
        
        self.zanLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.zanImageView.frame), 95, 30, 20)];
        self.zanLabel.font = [UIFont systemFontOfSize:12];
        self.zanLabel.textColor = [UIColor customGrayColor];
        [self.containerView addSubview:self.zanLabel];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end
