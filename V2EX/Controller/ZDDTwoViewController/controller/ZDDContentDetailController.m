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

@property (nonatomic, strong) NSArray *dataArrray;
@property (nonatomic, strong) ASTableNode *tableNode;
@property (nonatomic, strong) ZDDInputView *inputView;
@property (nonatomic, assign) BOOL isForgiveFirstResponse;
@property (nonatomic, strong) UIButton *collectBtn;
@end

@implementation ZDDContentDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"评论列表";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.collectBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.collectBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [self.collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [self.collectBtn addTarget:self action:@selector(touchCollect:) forControlEvents:UIControlEventTouchUpInside];
    [self.collectBtn sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.collectBtn];
    
    
    [self addTableNode];
    [self addInputView];
}

- (void)touchCollect:(UIButton *)btn {
    
    self.topModel.isCollected = !self.topModel.isCollected;
    [self reloadCollectWithMode:self.topModel];
    
}

- (void)reloadCollectWithMode:(ZDDPoetryModel *)model {
    
  
    if (model.isCollected) {
        [self.collectBtn setTitle:@"已收藏" forState:UIControlStateNormal];
        [self.collectBtn setTitleColor:color(137, 137, 137, 1) forState:UIControlStateNormal];
    }else {
        [self.collectBtn setTitleColor:[UIColor colorWithRed:215/255.0 green:171/255.0 blue:112/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self.collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
    }
    [self.collectBtn sizeToFit];
    
}

- (void)setTopModel:(ZDDPoetryModel *)topModel {
    _topModel = topModel;
    
    
    
    [self loadData];
}

- (void)loadData {
    
    [MFHUDManager showLoading:@"请求中..."];
    NSDictionary *paragmras = @{
                                @"pid" : self.topModel.id.length ? self.topModel.id : @""
                                };
    MFNETWROK.requestSerialization = MFJSONRequestSerialization;
    [MFNETWROK get:@"getComments" params:paragmras success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
        [MFHUDManager dismiss];
        if (statusCode == 200) {
            self.dataArrray = [NSArray yy_modelArrayWithClass:ZDDPoertryCommentModel.class json:result];
            [self.tableNode reloadData];
        }else {
            [MFHUDManager showError:@"请求失败"];
        }
    } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
        
        [MFHUDManager dismiss];
        [MFHUDManager showError:@"请求失败"];
    }];
    
    
    
}
#pragma mark - 发送评论
- (void)sendComment {
    
    [MFHUDManager showLoading:@"评论..."];
    NSDictionary *paragmras = @{
                                @"pid" : self.topModel.id.length ? self.topModel.id : @"",
                                @"uid" : [GODUserTool shared].user.id,
                                @"content" : self.inputView.textView.text
                                };
    NSLog(@"%@", paragmras);
    MFNETWROK.requestSerialization = MFJSONRequestSerialization;
    [MFNETWROK post:@"comment" params:paragmras success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
        NSLog(@"%@", result);
        [MFHUDManager dismiss];
        [self loadData];

    } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
        
        [MFHUDManager dismiss];
        [MFHUDManager showError:@"评论失败"];
    }];
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
    return self.dataArrray.count;
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
                ZDDCommentCountNode *node = [[ZDDCommentCountNode alloc] initWithCount:self.dataArrray.count];
                return node;
            }
        }else {
            ZDDCommentCellNode *node = [[ZDDCommentCellNode alloc] initWithModel:self.dataArrray[indexPath.row]];
            
            return node;
        }
        
    };
}

- (void)addTableNode {
    _tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];
    _tableNode.view.separatorStyle = UITableViewCellSeparatorStyleNone;
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
