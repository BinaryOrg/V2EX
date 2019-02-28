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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"漫画详情";
    
    NSDictionary *options = @{UIPageViewControllerOptionSpineLocationKey : @(UIPageViewControllerSpineLocationMin)};
    
    // 根据给定的属性实例化UIPageViewController
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                        options:options];
    // 设置UIPageViewController代理和数据源
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    
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
#pragma mark 返回上一个ViewController对象

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:(ZDDManHuaController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {

        return nil;
    }
    index--;
    
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
