//
//  ZDDPoetryListCellNode.m
//  V2EX
//
//  Created by Maker on 2019/2/16.
//  Copyright © 2019 binary. All rights reserved.
//

#import "ZDDPoetryListCellNode.h"

@interface ZDDPoetryListCellNode ()

@property (nonatomic, strong) ASDisplayNode *bgv;
@property (nonatomic, strong) ASTextNode *titleLb;
@property (nonatomic, strong) ASTextNode *authorLb;
@property (nonatomic, strong) ASTextNode *contentLb;


@end

@implementation ZDDPoetryListCellNode
- (instancetype)initWithModel:(ZDDPoetryModel *)model{
    self = [super init];
    if (!self) {
        return nil;
    }
   
    NSString *contemt = [model.content stringByReplacingOccurrencesOfString:@"|" withString:@"\n"];
    contemt = [contemt stringByReplacingOccurrencesOfString:@"。" withString:@""];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupUI];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc ] init];
    //文字对齐方式
    paragraphStyle.alignment =NSTextAlignmentCenter;
    paragraphStyle.lineSpacing = 2;

    self.titleLb.attributedText = [NSMutableAttributedString lh_makeAttributedString:model.title attributes:^(NSMutableDictionary *make) {
        make.lh_font([UIFont systemFontOfSize:16]).lh_color([UIColor whiteColor]).lh_paraStyle(paragraphStyle);
    }];
    
    self.authorLb.attributedText = [NSMutableAttributedString lh_makeAttributedString:model.authors attributes:^(NSMutableDictionary *make) {
        make.lh_font([UIFont systemFontOfSize:12]).lh_color([UIColor whiteColor]).lh_paraStyle(paragraphStyle);
    }];
    
    self.contentLb.attributedText = [NSMutableAttributedString lh_makeAttributedString:contemt attributes:^(NSMutableDictionary *make) {
        make.lh_font([UIFont systemFontOfSize:14]).lh_color([UIColor whiteColor]).lh_paraStyle(paragraphStyle);
    }];
    
    
    return self;
}


- (void)setupUI {
    
    [self addSubnode:self.bgv];
    
    [self addSubnode:self.authorLb];
    
    [self addSubnode:self.titleLb];
    
    [self addSubnode:self.contentLb];
    
}


- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    
    ASStackLayoutSpec *horLay = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:10.0f justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[self.titleLb, self.authorLb]];
    
    ASStackLayoutSpec *contentLay = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:15.0f justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[horLay, self.contentLb]];

    ASInsetLayoutSpec *insertLay = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(20.0f, 0, 20, -10) child:contentLay];
    
    ASOverlayLayoutSpec *coverLayout = [ASOverlayLayoutSpec overlayLayoutSpecWithChild:insertLay overlay:self.bgv];
    
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 0, 10) child:
            coverLayout];
    
    //return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 0, 10) child:
            //self.bgv];

}

-(ASDisplayNode *)bgv {
    if (!_bgv) {
        _bgv = [ASDisplayNode new];
        _bgv.backgroundColor = [UIColor purpleColor];//color(176, 176, 176, 1);
        _bgv.cornerRadius = 6;
//        _bgv.style.preferredSize = CGSizeMake(ScreenWidth - 40, 200);
    }
    return _bgv;
}

- (ASTextNode *)titleLb {
    if (!_titleLb) {
        _titleLb = [[ASTextNode alloc] init];
    }
    return _titleLb;
}
- (ASTextNode *)authorLb {
    if (!_authorLb) {
        _authorLb = [[ASTextNode alloc] init];
    }
    return _authorLb;
}
- (ASTextNode *)contentLb {
    if (!_contentLb) {
        _contentLb = [[ASTextNode alloc] init];
    }
    return _contentLb;
}

@end
