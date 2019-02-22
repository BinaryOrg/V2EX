//
//  ZDDTXTableViewCell.m
//  V2EX
//
//  Created by 张冬冬 on 2019/2/22.
//  Copyright © 2019 binary. All rights reserved.
//

#import "ZDDTXTableViewCell.h"
#import "UIColor+ZDDColor.h"
#import "GODDefine.h"
@implementation ZDDTXTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(27, 20, 1.5, 20)];
        lineLabel.backgroundColor = [UIColor customYellowColor];
        [self.contentView addSubview:lineLabel];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 10, 300, 40)];
        [self.contentView addSubview:self.dateLabel];
        self.dateLabel.font = [UIFont systemFontOfSize:17];
        self.dateLabel.textColor = [UIColor customGrayColor];
        
        self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(self.dateLabel.frame), (ScreenWidth - 80)/2, ((ScreenWidth - 80)/2))];
        self.imageView1.layer.cornerRadius = 7;
        self.imageView1.layer.masksToBounds = YES;
        self.imageView1.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.imageView1];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(self.imageView1.frame) + 5, 300, 30)];
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        
        self.summaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(self.titleLabel.frame), ScreenWidth - 60, 50)];
        self.summaryLabel.numberOfLines = 0;
        self.summaryLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        [self.contentView addSubview:self.summaryLabel];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.imageView1.userInteractionEnabled = YES;
        
        self.button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button1.frame = self.imageView1.bounds;
        [self.imageView1 addSubview:self.button1];
        
    }
    return self;
}

@end
