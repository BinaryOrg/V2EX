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
@property (nonatomic, strong) ASTextNode *commentAndCollectLb;

@end

@implementation ZDDPoetryListCellNode
- (instancetype)initWithModel:(ZDDPoetryModel *)model{
    self = [super init];
    if (!self) {
        return nil;
    }
   
    NSString *contemt = [model.content stringByReplacingOccurrencesOfString:@"|" withString:@"\n"];
    contemt = [contemt stringByReplacingOccurrencesOfString:@"。" withString:@""];
    contemt = [contemt stringByReplacingOccurrencesOfString:@"，" withString:@"\n"];
    contemt = [contemt stringByReplacingOccurrencesOfString:@"？" withString:@"\n"];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupUI];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc ] init];
    //文字对齐方式
    paragraphStyle.alignment =NSTextAlignmentCenter;
    paragraphStyle.lineSpacing = 2;

    self.titleLb.attributedText = [NSMutableAttributedString lh_makeAttributedString:model.title attributes:^(NSMutableDictionary *make) {
        make.lh_font([UIFont fontWithName:@"PingFangSC-Medium" size:16]).lh_color([UIColor blackColor]).lh_paraStyle(paragraphStyle);
    }];
    
    self.authorLb.attributedText = [NSMutableAttributedString lh_makeAttributedString:model.authors attributes:^(NSMutableDictionary *make) {
        make.lh_font([UIFont fontWithName:@"PingFangSC-Medium" size:12]).lh_color([UIColor blackColor]).lh_paraStyle(paragraphStyle);
    }];
    
    self.contentLb.attributedText = [NSMutableAttributedString lh_makeAttributedString:contemt attributes:^(NSMutableDictionary *make) {
        make.lh_font([UIFont fontWithName:@"PingFangSC-Light" size:24]).lh_color([UIColor blackColor]).lh_paraStyle(paragraphStyle);
    }];
    
    self.commentAndCollectLb.attributedText = [NSMutableAttributedString lh_makeAttributedString:@"1314收藏 * 2021评论" attributes:^(NSMutableDictionary *make) {
        NSMutableParagraphStyle *aa = [[NSMutableParagraphStyle alloc ] init];
        //文字对齐方式
        aa.alignment =NSTextAlignmentRight;
        make.lh_font([UIFont fontWithName:@"PingFangSC-Light" size:12]).lh_color([UIColor blackColor]).lh_paraStyle(aa);
    }];
    
    return self;
}


- (void)setupUI {
    
    [self addSubnode:self.bgv];
    
    [self addSubnode:self.authorLb];
    
    [self addSubnode:self.titleLb];
    
    [self addSubnode:self.contentLb];
    
    [self addSubnode:self.commentAndCollectLb];
    
}


- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    
    ASStackLayoutSpec *horLay = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:10.0f justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[self.titleLb, self.authorLb]];

    ASStackLayoutSpec *contentLay = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:15.0f justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[horLay, self.contentLb]];
    
    ASInsetLayoutSpec *insertLay = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(20.0f, 0, 40, -10) child:contentLay];

    ASOverlayLayoutSpec *coverLayout = [ASOverlayLayoutSpec overlayLayoutSpecWithChild:insertLay overlay:self.bgv];
    
    
    ASInsetLayoutSpec *commentCoverLay = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(INFINITY, INFINITY, 20, 30) child:self.commentAndCollectLb];
    
    ASOverlayLayoutSpec *commentLay = [ASOverlayLayoutSpec overlayLayoutSpecWithChild:coverLayout overlay:commentCoverLay];
    

    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 0, 10) child:
            commentLay];
    

}

-(ASDisplayNode *)bgv {
    if (!_bgv) {
        _bgv = [ASDisplayNode new];
        _bgv.backgroundColor = color(0, 0, 0, 0.15);
        _bgv.cornerRadius = 6;
    }
    return _bgv;
}

- (ASTextNode *)titleLb {
    if (!_titleLb) {
        _titleLb = [[ASTextNode alloc] init];
        _titleLb.maximumNumberOfLines = 0;
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

- (ASTextNode *)commentAndCollectLb {
    if (!_commentAndCollectLb) {
        _commentAndCollectLb = [[ASTextNode alloc] init];
    }
    return _commentAndCollectLb;
}

@end
