//
//  ZDDTX3TableViewCell.m
//  V2EX
//
//  Created by 张冬冬 on 2019/2/22.
//  Copyright © 2019 binary. All rights reserved.
//

#import "ZDDTX3TableViewCell.h"
#import "UIColor+ZDDColor.h"
#import "GODDefine.h"
@implementation ZDDTX3TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(27, 20, 1.5, 20)];
        lineLabel.backgroundColor = [UIColor customYellowColor];
        [self.contentView addSubview:lineLabel];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 10, 300, 40)];
        [self.contentView addSubview:self.dateLabel];
        self.dateLabel.font = [UIFont systemFontOfSize:20];
        self.dateLabel.textColor = [UIColor customGrayColor];
        
        self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(self.dateLabel.frame), (ScreenWidth - 80)/2, ((ScreenWidth - 80)/2))];
        self.imageView1.layer.cornerRadius = 7;
        self.imageView1.layer.masksToBounds = YES;
        self.imageView1.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.imageView1];
        
        self.imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView1.frame) + 20, CGRectGetMaxY(self.dateLabel.frame), (ScreenWidth - 80)/2, ((ScreenWidth - 80)/2))];
        self.imageView2.layer.cornerRadius = 7;
        self.imageView2.layer.masksToBounds = YES;
        self.imageView2.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.imageView2];
        
        self.imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(self.imageView1.frame) + 10, (ScreenWidth - 80)/2, ((ScreenWidth - 80)/2))];
        self.imageView3.layer.cornerRadius = 7;
        self.imageView3.layer.masksToBounds = YES;
        self.imageView3.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.imageView3];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(self.imageView3.frame) + 5, 300, 30)];
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
        self.imageView2.userInteractionEnabled = YES;
        
        self.button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button2.frame = self.imageView2.bounds;
        [self.imageView2 addSubview:self.button2];
        
        self.imageView3.userInteractionEnabled = YES;
        
        self.button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button3.frame = self.imageView3.bounds;
        [self.imageView3 addSubview:self.button3];
    }
    return self;
}


@end
