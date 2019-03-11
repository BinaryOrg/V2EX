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

#import "ZDDPersonHeadTableViewCell.h"
#import "ZDDGODPersonSettingTableViewCell.h"
#import "ZDDFuckPersonLogoutTableViewCell.h"

#define whiteBgvW  ScreenWidth

@interface LHMinController ()
<
UITableViewDelegate,
UITableViewDataSource,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *funcList;
@property (nonatomic, strong) QMUITips *tips;
@end

@implementation LHMinController

- (NSArray *)funcList {
    if (!_funcList) {
        _funcList = @[
                      @"我的收藏",
                      @"意见反馈",
                      @"清除缓存",
                      @"联系我们"
                      ];
    }
    return _funcList;
}

- (QMUITips *)tips {
    if (!_tips) {
        _tips = [QMUITips createTipsToView:self.view];
    }
    return _tips;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedRowHeight = 0;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.navigationItem.title = @"我的";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadCustomInfo) name:@"LoginSuccessNotification" object:nil];
    NSLog(@"%@", [GODUserTool shared].user.id);
}

- (void)reloadCustomInfo {
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!section) {
        return 1;
    }
    else if (section == 1) {
        return self.funcList.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.section) {
        GODUserModel *user = [GODUserTool shared].user;
        ZDDPersonHeadTableViewCell *cell = [[ZDDPersonHeadTableViewCell alloc] init];
        [cell.avatarImageView yy_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", BASE_AVATAR_URL, user.avatar]] placeholder:[UIImage imageNamed:@"HAO-0"]];
        cell.nameLabel.text = [GODUserTool isLogin] ? user.username : @"登录";
        [cell.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        [cell.avatarButton addTarget:self action:@selector(changeAvatar) forControlEvents:UIControlEventTouchUpInside];
//        cell.joinLabel.text = [GODUserTool isLogin] ? [NSString stringWithFormat:@"join in %@", [self formatFromTS:user.create_date]] : @"";
        return cell;
    }
    else if (indexPath.section == 1) {
        ZDDGODPersonSettingTableViewCell *cell = [[ZDDGODPersonSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"setting"];
        cell.textLabel.text = self.funcList[indexPath.row];
        return cell;
    }
    
    return [[ZDDFuckPersonLogoutTableViewCell alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.section) {
        return 80;
    }
    return 46;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (!section) {
        return CGFLOAT_MIN;
    }
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([MFHUDManager isShowing]) {
        return;
    }
    if (indexPath.section == 1) {
        if (!indexPath.row) {
            if ([GODUserTool isLogin]) {
//                FUCKNoteViewController *fuck = [[FUCKNoteViewController alloc] init];
//                fuck.flag = 1;
//                
//                [self.navigationController pushViewController:fuck animated:YES];
            }
            else {
                [self presentViewController:[ZDDLogController new] animated:YES completion:nil];
            }
        }else if (indexPath.row == 1) {
            if ([GODUserTool isLogin]) {
                [self reportToUs];
            }
            else {
                [self presentViewController:[ZDDLogController new] animated:YES completion:nil];
            }
        }else if (indexPath.row == 2) {
            [self clearMemory];
        }else {
            [self connectUs];
        }
    }
    else if (indexPath.section == 2) {
        [[GODUserTool shared] clearUserInfo];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FBSuccessNotification" object:nil];
        [self reloadCustomInfo];
    }
    
}

- (void)login {
    if ([MFHUDManager isShowing]) {
        return;
    }
    if ([GODUserTool isLogin]) {
        //改名
        [self presentAlertController];
    }else {
        //login
        [self presentViewController:[ZDDLogController new] animated:YES completion:nil];
    }
}

- (void)presentAlertController {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请输入要修改的用户名" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.tintColor = [UIColor blackColor];
    }];
    __weak typeof(alert) weakAlert = alert;
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *ensure = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        __strong typeof(weakAlert) strongAlert = weakAlert;
        [self startLoadingWithText:@"修改中..."];
        NSString *user_name = strongAlert.textFields[0].text;
        
        MFNETWROK.requestSerialization = MFJSONRequestSerialization;
        [MFNETWROK post:@"https://api.godzzzzz.club/api/user/username" params:@{
                                                                                @"phone":[GODUserTool shared].phone,
                                                                                @"username": user_name
                                                                                } success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
                                                                                    if (![result[@"code"] integerValue]) {
                                                                                        GODUserModel *newUser = [GODUserModel yy_modelWithJSON:result[@"user"]];
                                                                                        [GODUserTool shared].user = newUser;
                                                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                                                            [self stopLoading];
                                                                                            [self reloadCustomInfo];
                                                                                        });
                                                                                    }else {
                                                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                                                            [self showErrorWithText:@"修改失败！"];
                                                                                        });
                                                                                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                                                            [self stopLoading];
                                                                                        });
                                                                                    }
                                                                                } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
                                                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                                                        [self showErrorWithText:@"修改失败！"];
                                                                                    });
                                                                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                                                        [self stopLoading];
                                                                                    });
                                                                                }];

        
        
        
    }];
    [cancel setValue:[UIColor customBlueColor] forKey:@"_titleTextColor"];
    [ensure setValue:[UIColor customBlueColor] forKey:@"_titleTextColor"];
    [alert addAction:cancel];
    [alert addAction:ensure];
    [self presentViewController:alert animated:YES completion:nil];
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

//点击头像
- (void)changeAvatar {
    if (![GODUserTool isLogin]) {
        return;
    }
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker.delegate = self;
    [[UIWindow topViewController] presentViewController:picker animated:YES completion:nil];
    
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
                [self reloadCustomInfo];
               
            }
        } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [[UIWindow topViewController] dismissViewControllerAnimated:YES completion:nil];
}



- (void)startLoadingWithText:(NSString *)text {
    //    [QMUITips showLoading:text inView:self.view];
    //    [self.tips showLoading:text];
    [MFHUDManager showLoading:text];
}

- (void)showErrorWithText:(NSString *)text {
    //    [self.tips showError:text];
    [MFHUDManager showError:text];
}

- (void)showSuccessWithText:(NSString *)text {
    //    [self.tips showSucceed:text];
    [MFHUDManager showSuccess:text];
    
}

- (void)stopLoading {
    //    [QMUITips hideAllToastInView:self.view animated:YES];
    //    [self.tips hideAnimated:YES];
    [MFHUDManager dismiss];
}
@end
