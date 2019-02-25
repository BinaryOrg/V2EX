//
//  ZDDTabFour1TableViewCell.m
//  V2EX
//
//  Created by 张冬冬 on 2019/2/22.
//  Copyright © 2019 binary. All rights reserved.
//

#import "ZDDTabFour1TableViewCell.h"
#import "GODDefine.h"
#import "UIColor+ZDDColor.h"
@implementation ZDDTabFour1TableViewCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bzImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 30, 30)];
        [self.contentView addSubview:self.bzImageView];
        
        self.bzLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, 60, 30)];
        [self.contentView addSubview:self.bzLabel];
        
        CGFloat imageWidth = (ScreenWidth - 60)/3;
        CGFloat imageHeight = ((ScreenWidth - 60)/3)*16/9;
        
        self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 60, imageWidth, imageHeight)];
        [self.contentView addSubview:self.imageView1];
        self.imageView1.layer.cornerRadius = 7;
        self.imageView1.layer.masksToBounds = YES;
        
        self.label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.imageView1.frame) + 5, imageWidth, 20)];
        [self.contentView addSubview:self.label1];
        self.label1.font = [UIFont systemFontOfSize:15];
        
        
        self.dateLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.label1.frame) + 5, imageWidth, 20)];
        self.dateLabel1.textColor = [UIColor customGrayColor];
        self.dateLabel1.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.dateLabel1];
        
        self.imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView1.frame) + 10, 60, imageWidth, imageHeight)];
        [self.contentView addSubview:self.imageView2];
        self.imageView2.layer.cornerRadius = 7;
        self.imageView2.layer.masksToBounds = YES;
        
        self.label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView1.frame) + 10, CGRectGetMaxY(self.imageView1.frame) + 5, imageWidth, 20)];
        [self.contentView addSubview:self.label2];
        self.label2.font = [UIFont systemFontOfSize:15];
        
        
        self.dateLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView1.frame) + 10, CGRectGetMaxY(self.label1.frame) + 5, imageWidth, 20)];
        self.dateLabel2.textColor = [UIColor customGrayColor];
        self.dateLabel2.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.dateLabel2];
        
        self.imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView2.frame) + 10, 60, imageWidth, imageHeight)];
        [self.contentView addSubview:self.imageView3];
        self.imageView3.layer.cornerRadius = 7;
        self.imageView3.layer.masksToBounds = YES;
        
        self.label3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView2.frame) + 10, CGRectGetMaxY(self.imageView1.frame) + 5, imageWidth, 20)];
        [self.contentView addSubview:self.label3];
        self.label3.font = [UIFont systemFontOfSize:15];
        
        
        self.dateLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView2.frame) + 10, CGRectGetMaxY(self.label1.frame) + 5, imageWidth, 20)];
        self.dateLabel3.textColor = [UIColor customGrayColor];
        self.dateLabel3.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.dateLabel3];
        
        
        
        
        
        
        self.imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.dateLabel1.frame) + 5, imageWidth, imageHeight)];
        [self.contentView addSubview:self.imageView4];
        self.imageView4.layer.cornerRadius = 7;
        self.imageView4.layer.masksToBounds = YES;
        
        self.label4 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.imageView4.frame) + 5, imageWidth, 20)];
        [self.contentView addSubview:self.label4];
        self.label4.font = [UIFont systemFontOfSize:15];
        
        
        self.dateLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.label4.frame) + 5, imageWidth, 20)];
        self.dateLabel4.textColor = [UIColor customGrayColor];
        self.dateLabel4.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.dateLabel4];
        
        self.imageView5 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView4.frame) + 10, CGRectGetMaxY(self.dateLabel2.frame) + 5, imageWidth, imageHeight)];
        [self.contentView addSubview:self.imageView5];
        self.imageView5.layer.cornerRadius = 7;
        self.imageView5.layer.masksToBounds = YES;
        
        self.label5 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView4.frame) + 10, CGRectGetMaxY(self.imageView5.frame) + 5, imageWidth, 20)];
        [self.contentView addSubview:self.label5];
        self.label5.font = [UIFont systemFontOfSize:15];
        
        
        self.dateLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView4.frame) + 10, CGRectGetMaxY(self.label5.frame) + 5, imageWidth, 20)];
        self.dateLabel5.textColor = [UIColor customGrayColor];
        self.dateLabel5.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.dateLabel5];
        
        self.imageView6 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView5.frame) + 10, CGRectGetMaxY(self.dateLabel3.frame) + 5, imageWidth, imageHeight)];
        [self.contentView addSubview:self.imageView6];
        self.imageView6.layer.cornerRadius = 7;
        self.imageView6.layer.masksToBounds = YES;
        
        self.label6 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView5.frame) + 10, CGRectGetMaxY(self.imageView6.frame) + 5, imageWidth, 20)];
        [self.contentView addSubview:self.label6];
        self.label6.font = [UIFont systemFontOfSize:15];
        
        
        self.dateLabel6 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView5.frame) + 10, CGRectGetMaxY(self.label6.frame) + 5, imageWidth, 20)];
        self.dateLabel6.textColor = [UIColor customGrayColor];
        self.dateLabel6.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.dateLabel6];
    
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end
