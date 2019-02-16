//
//  ZDDHomeListController.m
//  V2EX
//
//  Created by Maker on 2019/2/14.
//  Copyright © 2019 binary. All rights reserved.
//

#import "ZDDHomeListController.h"
#import "ZDDManHuaController.h"
#import "ShowAPIRequest.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface ZDDHomeListController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSArray *pageContentArray;

@end

@implementation ZDDHomeListController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.fd_interactivePopDisabled = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.fd_interactivePopDisabled = NO;
}

-(void)setImagesArray:(NSArray *)imagesArray {
    _imagesArray = imagesArray;
    NSMutableArray *arrayM = [[NSMutableArray alloc] init];
    for (int i = 1; i < imagesArray.count + 1; i++) {
        NSString *contentString = [[NSString alloc] initWithFormat:@"This is the page %d of content displayed using UIPageViewController", i];
        [arrayM addObject:contentString];
    }
    _pageContentArray = arrayM;
    
}

#pragma mark - Life Cycle
//-(void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//}
//
//-(void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"漫画详情";
    // 设置UIPageViewController的配置项
    //    NSDictionary *options = @{UIPageViewControllerOptionInterPageSpacingKey : @(20)};
    NSDictionary *options = @{UIPageViewControllerOptionSpineLocationKey : @(UIPageViewControllerSpineLocationMin)};
    
    // 根据给定的属性实例化UIPageViewController
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                        options:options];
    // 设置UIPageViewController代理和数据源
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    
    // 设置UIPageViewController初始化数据, 将数据放在NSArray里面
    // 如果 options 设置了 UIPageViewControllerSpineLocationMid,注意viewControllers至少包含两个数据,且 doubleSided = YES
    
    ZDDManHuaController *initialViewController = [self viewControllerAtIndex:0];// 得到第一页
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [_pageViewController setViewControllers:viewControllers
                                  direction:UIPageViewControllerNavigationDirectionReverse
                                   animated:NO
                                 completion:nil];
    
    // 设置UIPageViewController 尺寸
    _pageViewController.view.frame = self.view.bounds;
    
    // 在页面上，显示UIPageViewController对象的View
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    
}
//
//- (void)setReuestId:(NSString *)reuestId {
//    _reuestId = reuestId;
//    
//    [MFHUDManager showLoading:@"发布中"];
//    NSDictionary *paragmras = @{
//                                @"showapi_appid" : yiyuanId,
//                                @"showapi_sign" : yiyuanSign,
//                                @"showapi_timestamp" : [ZDDTool getCurrentTime],
//                                @"showapi_res_gzip" : @(0),
//                                @"type" : reuestId,
//                                @"page" : @(1)
//                                };
//    MFNETWROK.requestSerialization = MFJSONRequestSerialization;
//    [MFNETWROK post:@"http://route.showapi.com/958-1" params:paragmras success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
//        NSLog(@"%@", result);
//        [MFHUDManager dismiss];
//        if ([result[@"code"] integerValue] == 200) {
//           
//        }else {
//            [MFHUDManager showError:@"发布失败"];
//        }
//    } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
//        
//        [MFHUDManager dismiss];
//        [MFHUDManager showError:@"发布失败"];
//    }];
//    
//    ShowAPIRequest *request=[[ShowAPIRequest alloc] initWithAppid:yiyuanId andSign:yiyuanSign];
//    //调用接口
//    [request post:@"http://route.showapi.com/958-1"//注意您需要先订购该接口套餐才能测试
//          timeout:18//超时设置为20秒
//           params:[[NSDictionary alloc] initWithObjectsAndKeys:reuestId,@"type",@"1",@"page", nil]//传入参数
//   withCompletion:^(NSDictionary *result) {
//       //打印返回结果
//       NSData *jsonData = [NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:nil];
//       // NSData转为NSString
//       NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//       NSLog(@"返回结果为：%@",jsonStr);
//   }];
//}

#pragma mark - UIPageViewControllerDataSource And UIPageViewControllerDelegate

#pragma mark 返回上一个ViewController对象

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:(ZDDManHuaController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        [self.navigationController popViewControllerAnimated:YES];
        return nil;
    }
    index--;
    // 返回的ViewController，将被添加到相应的UIPageViewController对象上。
    // UIPageViewController对象会根据UIPageViewControllerDataSource协议方法,自动来维护次序
    // 不用我们去操心每个ViewController的顺序问题
    return [self viewControllerAtIndex:index];
    
    
}

#pragma mark 返回下一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:(ZDDManHuaController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.pageContentArray count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
    
    
}

#pragma mark - 根据index得到对应的UIViewController
- (ZDDManHuaController *)viewControllerAtIndex:(NSUInteger)index {
    if (([self.pageContentArray count] == 0) || (index >= [self.pageContentArray count])) {
        return nil;
    }
    // 创建一个新的控制器类，并且分配给相应的数据
    ZDDManHuaController *contentVC = [[ZDDManHuaController alloc] init];
    contentVC.content = [self.pageContentArray objectAtIndex:index];
    contentVC.img_url = self.imagesArray[index];
    return contentVC;
}

#pragma mark - 数组元素值，得到下标值
- (NSUInteger)indexOfViewController:(ZDDManHuaController *)viewController {
    return [self.pageContentArray indexOfObject:viewController.content];
}

@end
