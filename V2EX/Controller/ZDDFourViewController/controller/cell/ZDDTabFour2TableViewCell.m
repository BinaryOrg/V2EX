//
//  ZDDTabFour2TableViewCell.m
//  V2EX
//
//  Created by 张冬冬 on 2019/2/22.
//  Copyright © 2019 binary. All rights reserved.
//

#import "ZDDTabFour2TableViewCell.h"
#import "GODDefine.h"
#import "UIColor+ZDDColor.h"
@implementation ZDDTabFour2TableViewCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.txImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 30, 30)];
        [self.contentView addSubview:self.txImageView];
        
        self.txLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, 60, 30)];
        [self.contentView addSubview:self.txLabel];
        
        CGFloat largeimageWidth = (ScreenWidth - 60) * 2 / 3;
        CGFloat smallimageWidth = (ScreenWidth - 60) / 3;
        
        self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 60, largeimageWidth, largeimageWidth)];
        [self.contentView addSubview:self.imageView1];
        self.imageView1.layer.cornerRadius = 7;
        self.imageView1.layer.masksToBounds = YES;
        
        self.label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.imageView1.frame) + 5, largeimageWidth, 20)];
        [self.contentView addSubview:self.label1];
        self.label1.font = [UIFont systemFontOfSize:15];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.label1.frame) + 5, largeimageWidth, 20)];
        self.dateLabel.textColor = [UIColor customGrayColor];
        self.dateLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.dateLabel];
        
        self.label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.dateLabel.frame), largeimageWidth, 50)];
        self.label2.numberOfLines = 0;
        [self.contentView addSubview:self.label2];
        self.label2.font = [UIFont systemFontOfSize:16];
        
        
        
        self.imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView1.frame) + 10, 60, smallimageWidth, smallimageWidth)];
        [self.contentView addSubview:self.imageView2];
        self.imageView2.layer.cornerRadius = 7;
        self.imageView2.layer.masksToBounds = YES;
        
        
        
        self.imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView1.frame) + 10, CGRectGetMaxY(self.imageView2.frame) + 10, smallimageWidth, smallimageWidth)];
        [self.contentView addSubview:self.imageView3];
        self.imageView3.layer.cornerRadius = 7;
        self.imageView3.layer.masksToBounds = YES;
        
        
        self.imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView1.frame) + 10, CGRectGetMaxY(self.imageView3.frame) + 10, smallimageWidth, smallimageWidth)];
        [self.contentView addSubview:self.imageView4];
        self.imageView4.layer.cornerRadius = 7;
        self.imageView4.layer.masksToBounds = YES;
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end
