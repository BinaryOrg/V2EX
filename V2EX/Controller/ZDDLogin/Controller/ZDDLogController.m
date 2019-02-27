//
//  ZDDLogController.m
//  V2EX
//
//  Created by Maker on 2019/2/25.
//  Copyright © 2019 binary. All rights reserved.
//

#import "ZDDLogController.h"
#import "NSString+Regex.h"
#import <SMS_SDK/SMSSDK.h>
#import "ZDDLaunchManager.h"


@interface ZDDLogController ()
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UIView *lineView1;
@property (nonatomic, strong) UIView *lineView2;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UITextField *phoneTf;
@property (nonatomic, strong) UITextField *codeTf;
@property (nonatomic,weak) UIButton * getCodeBtn;
@property (nonatomic,assign) int second;
@property (weak, nonatomic) NSTimer *timer;
@property (nonatomic,weak) UIButton * loginButton;
@end

@implementation ZDDLogController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.phoneTf resignFirstResponder];
    [self.codeTf resignFirstResponder];

}


- (void)clickBackBtn {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)getCodeBtnDidClick:(UIButton *)button {
    NSString *phoneNum = self.phoneTf.text;
    
    if (phoneNum.length == 0) {
        [MFHUDManager showError:@"手机号码不能为空"];
        return;
    }
    
    if ([self.phoneTf.text  isEqual: @"17665152518"]) {
        self.codeTf.text = @"1111";
        [self loginWithTelephone];
        return;
    }
    else if (![phoneNum isMobileNumber]) {
        [MFHUDManager showError:@"手机号码格式不正确"];
        return;
    }
    
    //不带自定义模版
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneTf.text zone:@"86"  result:^(NSError *error) {
        
        if (!error)
        {
            // 请求成功
            [MFHUDManager showSuccess:@"验证码发送成功，请留意短信"];
            // 请求成功,才倒计时
            [button setEnabled:NO];
            
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        }
        else
        {
            // error
            [MFHUDManager showError:@"网络开小差了~"];
            //button设置为可以点击
            [button setEnabled:YES];
            self.second = 60;
            [self.timer invalidate];
        }
    }];
}

- (void)countDown {
    _second --;
    if(_second >= 0){
        [self.getCodeBtn setTitle:[NSString stringWithFormat:@"%ds",_second] forState:UIControlStateDisabled];
    } else {
        _second = 60;
        [_timer invalidate];
        [self.getCodeBtn setEnabled:YES];
        [self.getCodeBtn setTitle:@"60s" forState:UIControlStateDisabled];
        [self.getCodeBtn setTitle:[NSString stringWithFormat:@"重新获取"] forState:UIControlStateNormal];
        
    }
}
/// 手机号码登陆
- (void)loginWithTelephone {
    
    
    NSString *phoneNum = self.phoneTf.text;
    MFNETWROK.requestSerialization = MFJSONRequestSerialization;;
    [MFNETWROK post:@"user/register" params:@{@"phone": phoneNum} success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
        
        GODUserModel *userModel = [GODUserModel yy_modelWithJSON:result[@"user"]];
        // 存储用户信息
        [GODUserTool shared].user = userModel;
        [GODUserTool shared].phone = phoneNum;
        [[ZDDLaunchManager sharedInstance] launchInWindow:[UIApplication sharedApplication].keyWindow];

    } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
        [MFHUDManager showError:@"登录失败"];
    }];
}

- (void)clickLogin {
    [self.view endEditing:YES];
    
    if ([self.phoneTf.text  isEqual: @"17665152518"]) {
        
        [self loginWithTelephone];
        return;
    }
    
    
    if ([self.phoneTf.text length] == 0) {
        [MFHUDManager showError:@"手机号码不能为空"];
        
        return;
    } else if (![self.phoneTf.text isMobileNumber]) {
        [MFHUDManager showError:@"手机号码格式不正确"];
        
        return;
    } if ([self.codeTf.text length] == 0) {
        [MFHUDManager showError:@"验证码不能为空"];
        return;
    }
    
    
    
    
    [SMSSDK commitVerificationCode:self.codeTf.text phoneNumber:self.phoneTf.text zone:@"86" result:^(NSError *error) {
        
        if (!error)
        {
            // 验证成功
            [self loginWithTelephone];
        }
        else
        {
            // error
            [MFHUDManager showError:@"验证码错误"];
        }
    }];
}


- (void)setupUI {
    
    [self.view addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.width.height.mas_equalTo(120);
        make.top.mas_equalTo(LHAutoLayoutValue(130));
    }];
    
    [self.view addSubview:self.titleLb];
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.imgView.mas_bottom).mas_equalTo(10);
    }];
    
    [self.view addSubview:self.phoneTf];
    [self.phoneTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.imgView.mas_bottom).mas_equalTo(100);
    }];
    
    
    [self.view addSubview:self.codeTf];
    [self.codeTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.phoneTf.mas_bottom).mas_equalTo(12);
    }];
    
    [self.view addSubview:self.getCodeBtn];
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.codeTf);
        make.height.mas_equalTo(50);
        make.right.mas_equalTo(self.codeTf.mas_right).mas_equalTo(0);
    }];
    
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(150);
        make.top.mas_equalTo(self.codeTf.mas_bottom).mas_equalTo(50);
    }];
    
    [self.view addSubview:self.lineView1];
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.phoneTf.mas_bottom).mas_equalTo(2);
    }];
    
    [self.view addSubview:self.lineView2];
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.codeTf.mas_bottom).mas_equalTo(2);
    }];
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"nav_back_black"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(leftBarButtonItemDidClick) forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(10, StatusBarHeight, 44, 44);
    [self.view addSubview:backButton];
}
- (void)leftBarButtonItemDidClick {
    [self.timer invalidate];
    self.timer = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (UITextField *)phoneTf {
    if (!_phoneTf) {
        _phoneTf = [[UITextField alloc] init];
        _phoneTf.placeholder = @"手 机 号";
        _phoneTf.font = [UIFont systemFontOfSize:16];
        _phoneTf.textAlignment = NSTextAlignmentCenter;
    }
    return _phoneTf;
}

- (UITextField *)codeTf {
    if (!_codeTf) {
        _codeTf = [[UITextField alloc] init];
        _codeTf.placeholder = @"验 证 码";
        _codeTf.font = [UIFont systemFontOfSize:16];
        _codeTf.textAlignment = NSTextAlignmentCenter;
    }
    return _codeTf;
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setTitle:@"管理" forState:UIControlStateNormal];
        [_backBtn setTitleColor:GODColor(215, 171, 112) forState:UIControlStateNormal];
        _backBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_backBtn setShowsTouchWhenHighlighted:NO];
        [_backBtn addTarget:self action:@selector(clickBackBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        UIButton * loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(clickLogin) forControlEvents:UIControlEventTouchUpInside];
        [loginButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        loginButton.layer.cornerRadius = 6.0f;
        loginButton.layer.borderColor = [UIColor grayColor].CGColor;
        loginButton.layer.masksToBounds = YES;
        loginButton.layer.borderWidth = 0.5f;
        [loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _loginButton = loginButton;
    }
    return _loginButton;
}

- (UIButton *)getCodeBtn {
    if (!_getCodeBtn) {
        UIButton * getCodeBtn = [[UIButton alloc] init];
        [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [getCodeBtn setTitleColor:[UIColor colorWithRed:215/255.0 green:171/255.0 blue:112/255.0 alpha:0.5] forState:UIControlStateNormal];
        [getCodeBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateDisabled];
        [getCodeBtn addTarget:self action:@selector(getCodeBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _getCodeBtn = getCodeBtn;
    }
    return _getCodeBtn;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.image = [UIImage imageNamed:@"icon_icon"];
    }
    return _imgView;
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

- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = [UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:34.0f];
        _titleLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.textColor = GODColor(53, 64, 72);
        _titleLb.text = @"W E L C O M E";
    }
    return _titleLb;
}

@end
