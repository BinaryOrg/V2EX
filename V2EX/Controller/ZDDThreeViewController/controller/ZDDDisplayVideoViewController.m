//
//  ZDDDisplayVideoViewController.m
//  V2EX
//
//  Created by pipelining on 2019/2/16.
//  Copyright © 2019年 binary. All rights reserved.
//

#import "ZDDDisplayVideoViewController.h"
#import <MFHUDManager/MFHUDManager.h>
#import <SuperPlayer/SuperPlayer.h>
#import <MFNetworkManager/MFNetworkManager.h>
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "GODDefine.h"
@interface ZDDDisplayVideoViewController ()
<
SuperPlayerDelegate
>
@property(nonatomic, strong) SuperPlayerView  *playerView;
@property(nonatomic, strong) UIView *fatherView;
@end

@implementation ZDDDisplayVideoViewController

- (UIView *)fatherView {
    if (!_fatherView) {
        _fatherView = [[UIView alloc] initWithFrame:CGRectMake(0, NavBarHeight, ScreenWidth, ScreenHeight - NavBarHeight)];
        _fatherView.backgroundColor = [UIColor whiteColor];
    }
    return _fatherView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.fatherView];
    self.title = self.model.title;
    
    [self request];
}

- (void)request {
    [MFHUDManager showLoading:@"解析中..."];
//    MFNETWROK.requestSerialization = MFHTTPRequestSerialization;
    NSLog(@"%@", self.model.url);
    [MFNETWROK get:[NSString stringWithFormat:@"https://api.godzzzzz.club/api/v2ex/getVideoMp4Url?url=%@", self.model.url] params:nil success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
        [MFHUDManager dismiss];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self playWithUrl:result[@"url"]];
        });
    } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
        [MFHUDManager showWarning:@"视频解析出错！"];
    }];
}

- (void)playWithUrl:(NSString *)url {
    _playerView = [[SuperPlayerView alloc] init];
    // 设置代理，用于接受事件
    _playerView.delegate = self;
    // 设置父View，_playerView会被自动添加到holderView下面
    _playerView.fatherView = self.fatherView;
    
    SuperPlayerModel *playerModel = [[SuperPlayerModel alloc] init];
    // 设置播放地址，直播、点播都可以
    playerModel.videoURL = url;
    // 开始播放
    [_playerView playWithModel:playerModel];

}

- (void)superPlayerFullScreenChanged:(SuperPlayerView *)player {
    SPDefaultControlView *controlView = (SPDefaultControlView *)player.controlView;
    if (player.isFullScreen) {
        controlView.danmakuBtn.hidden = YES;
        controlView.backBtn.hidden = NO;
    }else {
        controlView.backBtn.hidden = YES;
    }
}

- (void)superPlayerDidEnd:(SuperPlayerView *)player {
    SPDefaultControlView *controlView = (SPDefaultControlView *)player.controlView;
    if (player.isFullScreen) {
        controlView.backBtn.hidden = NO;
    }else {
        controlView.backBtn.hidden = YES;
    }
}

- (void)dealloc {
    [_playerView resetPlayer];
}

@end
