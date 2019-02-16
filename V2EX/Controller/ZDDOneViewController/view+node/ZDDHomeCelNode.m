//
//  ZDDHomeCelNode.m
//  V2EX
//
//  Created by Maker on 2019/2/16.
//  Copyright © 2019 binary. All rights reserved.
//

#import "ZDDHomeCelNode.h"

@interface ZDDHomeCelNode ()

@property (nonatomic, strong) ASTextNode *titleNode;
@property (nonatomic, strong) ASNetworkImageNode *imageNode;
@property (nonatomic, strong) ASDisplayNode *backgroudNode;


@end
@implementation ZDDHomeCelNode

- (instancetype)initWithModel:(ZDDBookListModel *)model {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.neverShowPlaceholders = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
   
    [self addImageNode];
    [self addBackgroudNode];
    [self addTitleNode];
    
    _titleNode.attributedText = [[NSMutableAttributedString alloc] initWithString:model.comic_name attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor] }];
    _imageNode.URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://image.samanlehua.com/%@", model.img_url]];
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    
    ASInsetLayoutSpec *contentLay = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 0, 0) child:_titleNode];
    
    ASOverlayLayoutSpec *coverLayout = [ASOverlayLayoutSpec overlayLayoutSpecWithChild:_backgroudNode overlay:contentLay];
    
    
    ASInsetLayoutSpec *backgroudLay = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(INFINITY, 0, 0, 0) child:coverLayout];
    
    ASOverlayLayoutSpec *allLay = [ASOverlayLayoutSpec overlayLayoutSpecWithChild:_imageNode overlay:backgroudLay];
    
    
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 0, 10) child:allLay];
}

- (void)addTitleNode {
    _titleNode = [ASTextNode new];
    [_titleNode setLayerBacked:YES];
    _titleNode.maximumNumberOfLines = 1;
    [self addSubnode:_titleNode];
}

- (void)addImageNode {
    _imageNode = [[ASNetworkImageNode alloc] init];
    _imageNode.contentMode = UIViewContentModeScaleAspectFill;
    _imageNode.style.preferredSize = CGSizeMake(ScreenWidth, AUTO_FIT(200));
    _imageNode.cornerRadius = 4;
    [self addSubnode:_imageNode];
}

- (void)addBackgroudNode {
    _backgroudNode = [[ASDisplayNode alloc] init];
    _backgroudNode.style.preferredSize = CGSizeMake(ScreenWidth, 40);
    _backgroudNode.cornerRadius = 4;
    _backgroudNode.backgroundColor = color(176, 176, 176, 0.5);
    [self addSubnode:_backgroudNode];
}
@end
