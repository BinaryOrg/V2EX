//
//  ZDDContentDetailController.m
//  V2EX
//
//  Created by Maker on 2019/2/26.
//  Copyright © 2019 binary. All rights reserved.
//

#import "ZDDContentDetailController.h"
#import "ZDDCommentCellNode.h"
#import "ZDDPoetryListCellNode.h"
#import "ZDDInputView.h"
#import "ZDDCommentCountNode.h"

@interface ZDDContentDetailController ()<ASTableDelegate, ASTableDataSource>

@property (nonatomic, strong) ASTableNode *tableNode;
@property (nonatomic, strong) ZDDInputView *inputView;
@property (nonatomic, assign) BOOL isForgiveFirstResponse;

@end

@implementation ZDDContentDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"评论列表";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self addTableNode];
    [self addInputView];
}


- (void)setTopModel:(ZDDPoetryModel *)topModel {
    _topModel = topModel;
    [self loadData];
}

- (void)loadData {
    
    
    [self.tableNode reloadData];
    
    
}
#pragma mark - 发送评论
- (void)sendComment {
    

    self.inputView.textView.text = @"";
    [self.inputView.textView resignFirstResponder];
    
    
}
#pragma mark - noti Action
- (void)kbWillShow:(NSNotification *)noti {
    // 动画的持续时间
    double duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 1.获取键盘的高度
    CGRect kbFrame =  [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat kbHeight = kbFrame.size.height;
    
    // 2.更改约束
    [self.inputView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-kbHeight);
        make.height.mas_equalTo(self.inputView.frame.size.height);
    }];
    
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
    self.isForgiveFirstResponse =  NO;
    
}

- (void)kbWillHide:(NSNotification *)noti {
    // 动画的持续时间
    double duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if (self.isForgiveFirstResponse) {
        return;
    }
    self.isForgiveFirstResponse =  YES;
    [self.inputView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(self.inputView.height);
    }];
    
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
    [self.inputView.textView resignFirstResponder];
}

#pragma mark - tableNodedelegate
- (NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode {
    return 2;
}

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.topModel ? 2 : 0;
    }
    return 20;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.inputView.textView resignFirstResponder];
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ^ASCellNode * {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                ZDDPoetryListCellNode *node = [[ZDDPoetryListCellNode alloc] initWithModel:self.topModel];
                return node;
            }else {
                ZDDCommentCountNode *node = [[ZDDCommentCountNode alloc] initWithCount:2000];
                return node;
            }
        }else {
            ZDDCommentCellNode *node = [[ZDDCommentCellNode alloc] init];
            
            return node;
        }
        
    };
}

- (void)addTableNode {
    _tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];
    _tableNode.view.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableNode.backgroundColor = [UIColor whiteColor];
    _tableNode.view.estimatedRowHeight = 0;
    _tableNode.leadingScreensForBatching = 1.0;
    _tableNode.delegate = self;
    _tableNode.dataSource = self;
    [self.view addSubnode:_tableNode];
    [_tableNode.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(- 51 - SafeAreaBottomHeight);
    }];
}

- (void)addInputView {
    if (!_inputView) {
        _inputView = [[ZDDInputView alloc] init];
        _inputView.textViewMaxLine = 4;
        __weak typeof(self)weakSelf = self;
        _inputView.sendBtnClickBlock = ^{
            [weakSelf sendComment];
        };
        _inputView.placeHolderString = @"评论~";
        [self.view addSubview:self.inputView];
        [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(- SafeAreaBottomHeight);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(51);
        }];
    }
}
@end
