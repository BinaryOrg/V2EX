//
//  ZDDTabOneViewController.m
//  V2EX
//
//  Created by pipelining on 2019/1/26.
//  Copyright © 2019年 binary. All rights reserved.
//

#import "ZDDTabOneViewController.h"
#import "ZDDChangeTypeView.h"
#import "ZDDHomeListController.h"

@interface ZDDTabOneViewController ()<ZDDChangeTypeViewDelegate, UIPageViewControllerDelegate, UIPageViewControllerDataSource>

/** <#class#> */
@property (nonatomic, strong) ZDDChangeTypeView *changeTypeView;
@property (nonatomic, strong) NSDictionary *typeDic;
@property (nonatomic, strong) NSArray <ZDDHomeListController *>*controllerArray;
@property (nonatomic, strong) UIPageViewController *pageController;
@end

@implementation ZDDTabOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    
    [self.view addSubview:self.changeTypeView];
    [self.changeTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];

    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
    [self.pageController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(50);
    }];
    
    [self.pageController setViewControllers:@[self.controllerArray.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

}

#pragma mark - UIPageViewControllerDataSource / UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    NSInteger index = [self.controllerArray indexOfObject:pageViewController.viewControllers.firstObject];
    [self.changeTypeView setSelectedIndex:index];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self.controllerArray indexOfObject:viewController];
    if (index < self.controllerArray.count-1 && self.controllerArray.count) {
        return [self.controllerArray objectAtIndex:index+1];
    }
    return nil;
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(nonnull UIViewController *)viewController {
    NSInteger index = [self.controllerArray indexOfObject:viewController];
    if (index>0 && self.controllerArray.count) {
        return [self.controllerArray objectAtIndex:index-1];
    }
    return nil;
}

- (void)clickButtonAtIndex:(NSInteger)index {
    NSInteger currentIndex = [self.controllerArray indexOfObject:self.pageController.viewControllers.firstObject];
    [self.pageController setViewControllers:@[[self.controllerArray objectAtIndex:index]] direction:index>currentIndex?UIPageViewControllerNavigationDirectionForward:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
}

- (ZDDChangeTypeView *)changeTypeView {
    if (!_changeTypeView) {
        _changeTypeView = [[ZDDChangeTypeView alloc] initWithTitles:self.typeDic.allValues];
        _changeTypeView.delegate = self;
    }
    return _changeTypeView;
}

- (NSDictionary *)typeDic {
    if (!_typeDic) {
        _typeDic = @{
                     @"/category/weimanhua/kbmh" : @"恐怖漫画",
                     @"/category/weimanhua/gushimanhua" : @"故事漫画",
                     @"/category/duanzishou" : @"段子手",
                     @"/category/lengzhishi" : @"冷知识",
                     @"/category/qiqu" : @"奇趣",
                     @"/category/dianying" : @"电影",
                     @"/category/gaoxiao" : @"搞笑",
                     @"/category/mengchong" : @"萌宠",
                     @"/category/xinqi" : @"新奇",
                     @"/category/huanqiu" : @"环球",
                     @"/category/sheying" : @"摄影",
                     @"/category/wanyi" : @"玩艺",
                     @"/category/chahua" : @"插画"
                     };
    }
    return _typeDic;
}

- (UIPageViewController *)pageController {
    if (!_pageController) {
        _pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageController.delegate = self;
        _pageController.dataSource = self;
    }
    return _pageController;
}

- (NSArray<ZDDHomeListController *> *)controllerArray {
    if (!_controllerArray) {
        NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:self.typeDic.allKeys.count];
        for (NSInteger i = 0; i < self.typeDic.allKeys.count; i ++) {
            NSString *title = self.typeDic.allValues[i];
            ZDDHomeListController *vc = [[ZDDHomeListController alloc] init];
            vc.title = title;
            vc.reuestId = self.typeDic.allKeys[i];
            [tempArr addObject:vc];
        }
        _controllerArray = tempArr.copy;
    }
    return _controllerArray;
}

@end
