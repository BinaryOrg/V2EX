//
//  ZDDCommentCellNode.m
//  V2EX
//
//  Created by Maker on 2019/2/26.
//  Copyright © 2019 binary. All rights reserved.
//

#import "ZDDCommentCellNode.h"

@interface ZDDCommentCellNode ()


@property (nonatomic, strong) ASNetworkImageNode *iconNode;
@property (nonatomic, strong) ASTextNode *nameNode;
@property (nonatomic, strong) ASTextNode *contentNode;
@property (nonatomic, strong) ASDisplayNode *lineNode;

@end


@implementation ZDDCommentCellNode


- (instancetype)initWithModel:(ZDDPoertryCommentModel *)model {

    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addIconNode];
        [self addNameNode];
        [self addContentNode];
        [self addLinetNode];
        
        self.iconNode.defaultImage = [UIImage imageNamed:@"aaa_9"];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BASE_AVATAR_URL, model.user.avatar]];
        self.iconNode.URL = url;
        
        self.nameNode.attributedText = [NSMutableAttributedString lh_makeAttributedString:model.user.username attributes:^(NSMutableDictionary *make) {
            make.lh_font([UIFont systemFontOfSize:15]);
        }];
        
        self.contentNode.attributedText = [NSMutableAttributedString lh_makeAttributedString:model.comment attributes:^(NSMutableDictionary *make) {
            make.lh_font([UIFont systemFontOfSize:15]);
        }];
    }
    return self;
    
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    
    ASStackLayoutSpec *verLay = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:10 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart children:@[self.nameNode, self.contentNode]];
    
    ASStackLayoutSpec *allverLay = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:20 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart children:@[verLay, self.lineNode]];
    
    ASStackLayoutSpec *horLay = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:12 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart children:@[self.iconNode, allverLay]];
    
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(20, 20, 0, -20) child:horLay];
    
}


- (void)addIconNode {
    self.iconNode = [[ASNetworkImageNode alloc] init];
    self.iconNode.style.preferredSize = CGSizeMake(40, 40);
    self.iconNode.cornerRadius = 20;
    [self addSubnode:self.iconNode];
}

- (void)addNameNode {
    self.nameNode = [[ASTextNode alloc] init];
    [self addSubnode:self.nameNode];
}

- (void)addContentNode {
    self.contentNode = [[ASTextNode alloc] init];
    [self addSubnode:self.contentNode];
}

- (void)addLinetNode {
    self.lineNode = [[ASDisplayNode alloc] init];
    self.lineNode.backgroundColor = color(237, 237, 237, 1);
    self.lineNode.style.preferredSize = CGSizeMake(ScreenWidth - 90, 1);
    [self addSubnode:self.lineNode];
}

@end
