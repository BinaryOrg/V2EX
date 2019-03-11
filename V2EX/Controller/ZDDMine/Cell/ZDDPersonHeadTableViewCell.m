//
//  ZDDPersonHeadTableViewCell.m
//  KDCP
//
//  Created by ZDD on 2019/3/9.
//  Copyright © 2019 binary. All rights reserved.
//

#import "ZDDPersonHeadTableViewCell.h"

@implementation ZDDPersonHeadTableViewCell

- (instancetype)init {
    self = [super init];
    if (self) {
        self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 60, 60)];
        [self.contentView addSubview:self.avatarImageView];
        self.avatarImageView.userInteractionEnabled = YES;
        self.avatarImageView.layer.cornerRadius = 30;
        self.avatarImageView.layer.masksToBounds = YES;
        self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.avatarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.avatarButton.frame = self.avatarImageView.bounds;
        [self.avatarImageView addSubview:self.avatarButton];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, 200, 30)];
        self.nameLabel.text = @"登录";
        self.nameLabel.font = [UIFont systemFontOfSize:16];
        self.nameLabel.textColor = color(140, 140, 140, 1);
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.nameLabel];
        self.nameLabel.userInteractionEnabled = YES;
        
        self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.loginButton.frame = self.nameLabel.bounds;
        [self.nameLabel addSubview:self.loginButton];
        
    }
    return self;
}


@end
