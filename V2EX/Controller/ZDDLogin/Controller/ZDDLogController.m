//
//  ZDDLogController.m
//  V2EX
//
//  Created by Maker on 2019/2/25.
//  Copyright © 2019 binary. All rights reserved.
//

#import "ZDDLogController.h"

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

    [self setupUI];
}



- (void)clickBackBtn {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickLogin {
    
}

- (void)getCodeBtnDidClick {
    
}

- (void)setupUI {
    
    [self.view addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.width.height.mas_equalTo(120);
        make.top.mas_equalTo(LHAutoLayoutValue(160));
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
        make.top.mas_equalTo(self.imgView.mas_bottom).mas_equalTo(50);
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
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(50);
        make.right.mas_equalTo(self.codeTf.mas_right).mas_equalTo(-2);
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
        [getCodeBtn addTarget:self action:@selector(getCodeBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _getCodeBtn = getCodeBtn;
    }
    return _getCodeBtn;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.layer.masksToBounds = YES;
        _imgView.layer.cornerRadius = 60;
        _imgView.backgroundColor = [UIColor yellowColor];
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
