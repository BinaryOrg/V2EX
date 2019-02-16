//
//  ZDDChangeTypeView.m
//  V2EX
//
//  Created by Maker on 2019/2/12.
//  Copyright © 2019 binary. All rights reserved.
//

#import "ZDDChangeTypeView.h"

#define btnW  40
#define  centerSpacing  44
#define  leftSpacing  (Width - self.titles.count * btnW - centerSpacing * (self.titles.count -1))/2.0


@interface ZDDChangeTypeView ()
/** 装button的数组 */
@property (nonatomic, strong) NSArray *buttons;
/** titles */
@property (nonatomic, strong) NSArray *titles;
/** 选中的tag */
@property (nonatomic, assign) NSInteger selectedTag;

@property (nonatomic, strong) UIView *scrollLine;

/** line */
@property (nonatomic, strong) UIView *lineView;
@end
@implementation ZDDChangeTypeView
- (instancetype)initWithTitles:(NSArray *)titles {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        _titles = titles;
        _selectedTag = 1;
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:self.titles.count];
    for (int i = 0; i < self.titles.count; i++) {
        NSString *title = self.titles[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        [btn setTitle:title forState:UIControlStateNormal];
        if (i == self.selectedTag) {
            [btn setTitleColor:GODColor(53, 64,72) forState:UIControlStateNormal];
        }else {
            [btn setTitleColor:GODColor(146, 146, 146) forState:UIControlStateNormal];
        }
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftSpacing + btnW * (i ) + centerSpacing * (i));
            make.bottom.mas_equalTo(-6);
            make.width.mas_equalTo(btnW);
        }];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [tempArr addObject:btn];
    }
    self.buttons = [tempArr copy];
    
    self.scrollLine = [[UIView alloc] init];
    [self addSubview:self.scrollLine];
    self.scrollLine.frame = CGRectMake(leftSpacing + btnW * (self.selectedTag) + centerSpacing * (self.selectedTag) + 3, 46, btnW - 8, 3);
    self.scrollLine.backgroundColor = GODColor(255,226,102);
    self.scrollLine.layer.cornerRadius = 1.5;
    self.scrollLine.layer.masksToBounds = YES;
    
    self.lineView = [UIView new];
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}

- (void)clickBtn:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(clickButtonAtIndex:)]) {
        [self.delegate clickButtonAtIndex:btn.tag];
    }
}
//此方法仅供外界调用
- (void)setSelectedIndex:(NSInteger)index {
    self.selectedTag = index;
    for (int i = 0; i < self.buttons.count; i++) {
        UIButton *btn = self.buttons[i];
        if (i == self.selectedTag) {
            [btn setTitleColor:GODColor(53, 64, 72) forState:UIControlStateNormal];
        }else {
            [btn setTitleColor:GODColor(146, 146, 146) forState:UIControlStateNormal];
        }
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.scrollLine.frame = CGRectMake(leftSpacing + btnW * (index) + centerSpacing * (index) + 3, 46, btnW- 8, 3);
    }];
}
-(void)dealloc {
    self.delegate = nil;
}

@end
