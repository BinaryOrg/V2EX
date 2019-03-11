//
//  LHMinController.m
//  V2EX
//
//  Created by Maker on 2019/3/8.
//  Copyright © 2019 binary. All rights reserved.
//

#import "LHMinController.h"
#import <YYCache.h>
#import "UIWindow+Tools.h"
#import "ZDDLogController.h"
#import <QMUIKit.h>
#import "UIColor+ZDDColor.h"


#define whiteBgvW  ScreenWidth

@interface LHMinController ()<
UIImagePickerControllerDelegate,
UINavigationControllerDelegate>

@property (nonatomic, strong) UIView *whiteBgv;
@property (nonatomic, strong) UIImageView *iconIV;
@property (nonatomic, strong) UITextField *nameTV;
@property (nonatomic, strong) UIButton *clearBtn;
@property (nonatomic, strong) UIButton *reportBtn;
@property (nonatomic, strong) UIButton *connectBtn;
@property (nonatomic, strong) UIButton *fuckBtn;

@property (nonatomic, strong) UIButton *logoutBtn;
@property (nonatomic, strong) UIView *lineView1;
@property (nonatomic, strong) UIView *lineView2;
@property (nonatomic, strong) UIView *lineView3;
@property (nonatomic, strong) UIView *lineView4;
@end

@implementation LHMinController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self setupUI];
    self.view.backgroundColor = [UIColor clearColor];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadSubView];

}

//意见反馈
- (void)reportToUs {
    QMUIAlertController *alert = [QMUIAlertController alertControllerWithTitle:nil message:@"请输入您的意见或建议" preferredStyle:QMUIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(QMUITextField *textField) {
        textField.placeholder = @"这是一条有内涵的建议~";
    }];
    
    QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"确定" style:QMUIAlertActionStyleDefault handler:^(__kindof QMUIAlertController *aAlertController, QMUIAlertAction *action) {
        NSString *userName = aAlertController.textFields.firstObject.text;
        if (!userName) {
            [MFHUDManager showError:[NSString stringWithFormat:@"请输入建议内容"]];
            return;
        }
        
        [MFHUDManager showSuccess:@"谢谢您的宝贵建议"];
    }];
    
    QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:nil];
    
    [alert addAction:action1];
    [alert addAction:action2];
    [alert showWithAnimated:YES];
    
}


//清楚缓存
- (void)clearMemory {
    
    [[YYImageCache sharedCache].diskCache removeAllObjects];
    [[YYImageCache sharedCache].memoryCache removeAllObjects];
    
    [MFHUDManager showLoading:@"正在清除..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MFHUDManager showSuccess:@"清除成功!"];
    });
    
}

//联系我们
- (void)connectUs {
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"Shmily_liuyy";
    [MFHUDManager showSuccess:@"作者微信号已成功复制到剪切板！"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSURL * url = [NSURL URLWithString:@"weixin://"];
        BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
        if (canOpen) {
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            }
        }
    });
}

//登入、登出
- (void)loginOrLogut {
    if ([GODUserTool isLogin]) {
        //退出登录
        [[GODUserTool shared] clearUserInfo];
        [self reloadSubView];
    }else {
        //登录
        [[UIWindow topViewController] presentViewController:[ZDDLogController new] animated:YES completion:nil];
    }
}

//点击头像
- (void)changeIcon {
    if (![GODUserTool isLogin]) {
        return;
    }
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker.delegate = self;
    [[UIWindow topViewController] presentViewController:picker animated:YES completion:nil];
    
}

//保存用户信息
- (void)saveUserInfo {
    
    MFNETWROK.requestSerialization = MFJSONRequestSerialization;
    [MFNETWROK post:@"https://api.godzzzzz.club/api/user/username" params:@{
                                                                            @"phone":[GODUserTool shared].phone,
                                                                            @"username": self.nameTV.text
                                                                            } success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
                                                                                if (![result[@"code"] integerValue]) {
                                                                                    GODUserModel *newUser = [GODUserModel yy_modelWithJSON:result[@"user"]];
                                                                                    [GODUserTool shared].user = newUser;
                                                                                }
                                                                            } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
                                                                            }];
    
}

//刷新
- (void)reloadSubView {
    GODUserModel *user = [GODUserTool shared].user;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BASE_AVATAR_URL, user.avatar]];
    [self.iconIV yy_setImageWithURL:url placeholder:[UIImage imageNamed:@"tab_buddy_press"]];
    self.nameTV.text = user.username.length ? user.username : @"尚未登录";
    if (user.id.length) {
        [_logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logoutBtn setTitleColor:GODColor(137, 137, 137) forState:UIControlStateNormal];
        _logoutBtn.backgroundColor = [UIColor whiteColor];
        
        self.nameTV.userInteractionEnabled = YES;
    }else {
        [_logoutBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _logoutBtn.backgroundColor = [UIColor customBlueColor];
        
        self.nameTV.userInteractionEnabled = NO;
    }
}

#pragma mark - 照片选择
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [[UIWindow topViewController] dismissViewControllerAnimated:YES completion:^{
        //上传
        NSString *phone = [GODUserTool shared].phone;
        [MFNETWROK upload:[NSString stringWithFormat:@"https://api.godzzzzz.club/api/user/avatar?phone=%@", phone] params:nil name:@"avatar" images:@[image] imageScale:0.8 imageType:MFImageTypePNG progress:^(NSProgress *progress) {
            
        } success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
            if (![result[@"code"] integerValue]) {
                GODUserModel *newUser = [GODUserModel yy_modelWithJSON:result[@"user"]];
                [GODUserTool shared].user = newUser;
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BASE_AVATAR_URL, newUser.avatar]];
                [self.iconIV yy_setImageWithURL:url placeholder:[UIImage imageNamed:@""]];
            }
        } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [[UIWindow topViewController] dismissViewControllerAnimated:YES completion:nil];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.nameTV resignFirstResponder];
}


- (void)setupUI {
    
    self.title = @"我的";
    
    [self.view addSubview:self.whiteBgv];
    self.whiteBgv.frame = self.view.frame;
    
    
    [self.whiteBgv addSubview:self.iconIV];
    [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(80);
        make.width.height.mas_equalTo(60);
    }];
    
    [self.whiteBgv addSubview:self.nameTV];
    [self.nameTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(whiteBgvW - 40);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self.iconIV.mas_bottom).mas_equalTo(15);
    }];
    
    
    [self.whiteBgv addSubview:self.fuckBtn];
    [self.fuckBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(self.nameTV.mas_bottom).mas_equalTo(LHAutoLayoutValue(90));

    }];
    
    [self.whiteBgv addSubview:self.lineView4];
    [self.lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.fuckBtn.mas_bottom).mas_equalTo(8);
        make.height.mas_equalTo(1);
    }];
//
    [self.whiteBgv addSubview:self.reportBtn];
    [self.reportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(self.lineView4.mas_bottom).mas_equalTo(8);
    }];

    [self.whiteBgv addSubview:self.lineView1];
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.reportBtn.mas_bottom).mas_equalTo(8);
        make.height.mas_equalTo(1);
    }];

    [self.whiteBgv addSubview:self.clearBtn];
    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(self.lineView1.mas_bottom).mas_equalTo(8);
    }];

    [self.whiteBgv addSubview:self.lineView2];
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.clearBtn.mas_bottom).mas_equalTo(8);
        make.height.mas_equalTo(1);
    }];

    [self.whiteBgv addSubview:self.connectBtn];
    [self.connectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(self.lineView2.mas_bottom).mas_equalTo(8);
    }];

    [self.whiteBgv addSubview:self.lineView3];
    [self.lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.connectBtn.mas_bottom).mas_equalTo(8);
        make.height.mas_equalTo(1);
    }];

    [self.whiteBgv addSubview:self.logoutBtn];
    [self.logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(whiteBgvW -100);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.lineView3.mas_bottom).mas_equalTo(50);
    }];

    
}

- (UIView *)whiteBgv {
    if (!_whiteBgv) {
        _whiteBgv = [UIView new];
        _whiteBgv.backgroundColor = [UIColor clearColor];
        _whiteBgv.layer.shadowColor = [UIColor customGrayColor].CGColor;//shadowColor阴影颜色
        _whiteBgv.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    }
    return _whiteBgv;
}

- (UIImageView *)iconIV {
    if (!_iconIV) {
        _iconIV = [[UIImageView alloc] init];
        _iconIV.contentMode = UIViewContentModeScaleAspectFill;
        _iconIV.layer.masksToBounds = YES;
        _iconIV.layer.cornerRadius = 30;
        _iconIV.userInteractionEnabled = YES;
        [_iconIV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeIcon)]];
    }
    return _iconIV;
}

- (UITextField *)nameTV {
    if (!_nameTV) {
        _nameTV = [UITextField new];
        _nameTV.textAlignment = NSTextAlignmentCenter;
        _nameTV.font = [UIFont systemFontOfSize:16];
    }
    return _nameTV;
}

-(UIButton *)fuckBtn {
    if (!_fuckBtn) {
        _fuckBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fuckBtn setTitle:@"我的收藏" forState:UIControlStateNormal];
        [_fuckBtn setTitleColor:GODColor(215, 171, 112) forState:UIControlStateNormal];
        _fuckBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_fuckBtn setShowsTouchWhenHighlighted:NO];
        [_fuckBtn addTarget:self action:@selector(reportToUs) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fuckBtn;
}

-(UIButton *)reportBtn {
    if (!_reportBtn) {
        _reportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reportBtn setTitle:@"意见反馈" forState:UIControlStateNormal];
        [_reportBtn setTitleColor:GODColor(215, 171, 112) forState:UIControlStateNormal];
        _reportBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_reportBtn setShowsTouchWhenHighlighted:NO];
        [_reportBtn addTarget:self action:@selector(reportToUs) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reportBtn;
}

-(UIButton *)clearBtn {
    if (!_clearBtn) {
        _clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clearBtn setTitle:@"清除缓存" forState:UIControlStateNormal];
        [_clearBtn setTitleColor:GODColor(215, 171, 112) forState:UIControlStateNormal];
        _clearBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_clearBtn setShowsTouchWhenHighlighted:NO];
        [_clearBtn addTarget:self action:@selector(clearMemory) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearBtn;
}

-(UIButton *)connectBtn {
    if (!_connectBtn) {
        _connectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_connectBtn setTitle:@"联系我们" forState:UIControlStateNormal];
        [_connectBtn setTitleColor:GODColor(215, 171, 112) forState:UIControlStateNormal];
        _connectBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_connectBtn setShowsTouchWhenHighlighted:NO];
        [_connectBtn addTarget:self action:@selector(connectUs) forControlEvents:UIControlEventTouchUpInside];
    }
    return _connectBtn;
}


-(UIButton *)logoutBtn {
    if (!_logoutBtn) {
        _logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        _logoutBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_logoutBtn setShowsTouchWhenHighlighted:NO];
        _logoutBtn.layer.cornerRadius = 6;
        _logoutBtn.layer.masksToBounds = YES;
        _logoutBtn.layer.borderColor = GODColor(237, 237, 237).CGColor;
        _logoutBtn.layer.borderWidth = 1.0f;
        [_logoutBtn addTarget:self action:@selector(loginOrLogut) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutBtn;
}
- (UIView *)lineView4 {
    if (!_lineView4) {
        _lineView4 = [UIView new];
        _lineView4.backgroundColor = GODColor(237,237, 237);
    }
    return _lineView4;
}

- (UIView *)lineView1 {
    if (!_lineView1) {
        _lineView1 = [UIView new];
        _lineView1.backgroundColor = GODColor(237,237, 237);
    }
    return _lineView1;
}

- (UIView *)lineView2 {
    if (!_lineView2) {
        _lineView2 = [UIView new];
        _lineView2.backgroundColor = GODColor(237,237, 237);
    }
    return _lineView2;
}

- (UIView *)lineView3 {
    if (!_lineView3) {
        _lineView3 = [UIView new];
        _lineView3.backgroundColor = GODColor(237,237, 237);
    }
    return _lineView3;
}


@end
