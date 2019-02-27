//
//  ZDDCommentCountNode.m
//  V2EX
//
//  Created by Maker on 2019/2/26.
//  Copyright © 2019 binary. All rights reserved.
//

#import "ZDDCommentCountNode.h"

@interface ZDDCommentCountNode ()

@property (nonatomic, strong) ASTextNode *countNode;
@property (nonatomic, strong) ASDisplayNode *lineNode;

@end

@implementation ZDDCommentCountNode

- (instancetype)initWithCount:(NSInteger)count {
    if (self = [super init]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addContNode];
        [self addLineNode];
        
        self.countNode.attributedText = [NSMutableAttributedString lh_makeAttributedString:[NSString stringWithFormat:@"评论 （%ld）", count] attributes:^(NSMutableDictionary *make) {
            make.lh_font([UIFont systemFontOfSize:18]);
        }];
    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    
    ASInsetLayoutSpec *inser = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(20, 20, 0, -20) child:self.countNode];
    ASStackLayoutSpec *verLay = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:15 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart children:@[inser, self.lineNode]];
    return verLay;
}

- (void)addContNode {
    self.countNode = [ASTextNode new];
    [self addSubnode:self.countNode];
}

- (void)addLineNode {
    self.lineNode = [[ASDisplayNode alloc] init];
    self.lineNode.backgroundColor = color(237, 237, 237, 1);
    self.lineNode.style.preferredSize = CGSizeMake(ScreenWidth, 1);
    [self addSubnode:self.lineNode];
}

@end
