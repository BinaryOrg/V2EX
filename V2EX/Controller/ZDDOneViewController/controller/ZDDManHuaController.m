//
//  ZDDManHuaController.m
//  V2EX
//
//  Created by Maker on 2019/2/14.
//  Copyright © 2019 binary. All rights reserved.
//

#import "ZDDManHuaController.h"
#import <YYImage.h>
#import "UIImageView+TransitionImage.h"
@interface ZDDManHuaController ()

@property (nonatomic, strong) UIImageView *iv;
// 下载 operation
@property (nonatomic, strong) YYWebImageOperation *operation;
@end

@implementation ZDDManHuaController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.iv = [[YYAnimatedImageView alloc] init];
    [self.view addSubview:self.iv];
    self.iv.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.frame.size.height);
    self.iv.contentMode = UIViewContentModeScaleAspectFit;
    NSLog(@"%@",@(YYImageWebPAvailable()));
}

- (void)setImg_url:(NSString *)img_url {
    __weak __typeof(self)weakSelf = self;
    NSLog(@"%@", img_url);
    
    self.operation = [[YYWebImageManager sharedManager] requestImageWithURL:[NSURL URLWithString:img_url] options:YYWebImageOptionProgressiveBlur progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    } transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        NSLog(@"%@", url.absoluteString);
        NSLog(@"%@", image);
        NSLog(@"%lu", (unsigned long)from);
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (!error && stage == YYWebImageStageFinished) {
            strongSelf.operation = nil;
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *webpImage = (YYImage *)image;
                if (webpImage) {
                    [strongSelf.iv animatedTransitionImage:webpImage];
                }
            });
        }else if (error) {
            NSLog(@"%@",error.userInfo);
            strongSelf.operation = nil;
        }
    }];
    
//    self.operation = [[YYWebImageManager sharedManager] requestImageWithURL:[NSURL URLWithString:@"http://res.cloudinary.com/demo/image/upload/w_300/sample.webp"] options:YYWebImageOptionProgressiveBlur progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//    } transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
//        NSLog(@"%@", url.absoluteString);
//        NSLog(@"%@", image);
//        NSLog(@"%lu", (unsigned long)from);
//        __strong __typeof(weakSelf)strongSelf = weakSelf;
//        if (!error && stage == YYWebImageStageFinished) {
//            strongSelf.operation = nil;
//            dispatch_async(dispatch_get_main_queue(), ^{
//                UIImage *webpImage = (YYImage *)image;
//                if (webpImage) {
//                    [strongSelf.iv animatedTransitionImage:webpImage];
//                }
//            });
//        }else if (error) {
//            NSLog(@"%@",error.userInfo);
//            strongSelf.operation = nil;
//        }
//    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
