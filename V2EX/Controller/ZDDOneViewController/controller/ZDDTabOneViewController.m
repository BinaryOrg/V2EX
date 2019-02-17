//
//  ZDDTabOneViewController.m
//  V2EX
//
//  Created by pipelining on 2019/1/26.
//  Copyright © 2019年 binary. All rights reserved.
//

#import "ZDDTabOneViewController.h"
#import "ZDDChangeTypeView.h"
#import "ZDDHomeController.h"

@interface ZDDTabOneViewController ()<ZDDChangeTypeViewDelegate, UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) ZDDChangeTypeView *changeTypeView;
@property (nonatomic, strong) NSArray *dataArrray;
@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) NSArray <ZDDHomeController *>*controllerArray;
@property (nonatomic, strong) UIPageViewController *pageController;


@end

@implementation ZDDTabOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

- (void)loadData {
    
    [MFHUDManager showLoading:@"请求中..."];
    NSDictionary *paragmras = @{
                                };
    MFNETWROK.requestSerialization = MFJSONRequestSerialization;
    [MFNETWROK post:@"http://kanmanapi-main.321mh.com/v1/book/getBookByType?platform=19&platformname=iphone&booktype=132&productname=aym&pagesize=20&page=0" params:paragmras success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
        [MFHUDManager dismiss];
        if (statusCode == 200) {
            self.dataArrray = [NSArray yy_modelArrayWithClass:ZDDManHuaListModel.class json:result[@"data"][@"book"]];
            
            [self setupUI];
        }else {
            [MFHUDManager showError:@"请求失败"];
        }
    } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
        
        [MFHUDManager dismiss];
        [MFHUDManager showError:@"请求失败"];
    }];
}
- (void)setupUI {
    
    self.title = @"漫画";
    
    [self.view addSubview:self.changeTypeView];
    [self.changeTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(NavBarHeight);
        make.height.mas_equalTo(50);
    }];

    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
    [self.pageController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.changeTypeView.mas_bottom);
        make.bottom.mas_equalTo(-SafeTabBarHeight);
    }];
    
    [self.pageController setViewControllers:@[self.controllerArray.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
}



#pragma mark - UIPageViewControllerDataSource / UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    NSInteger index = [self.controllerArray indexOfObject:pageViewController.viewControllers.firstObject];
    [self.changeTypeView setSelectedTag:index];
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
        _changeTypeView = [[ZDDChangeTypeView alloc] initWithTitles:self.titleArray];
        _changeTypeView.delegate = self;
    }
    return _changeTypeView;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:self.dataArrray.count];
        for (NSInteger i = 0; i < self.dataArrray.count; i ++) {
            ZDDManHuaListModel *model = self.dataArrray[i];
            [tempArr addObject:model.title];
        }
        _titleArray = tempArr.copy;
    }
    return _titleArray;
}


- (UIPageViewController *)pageController {
    if (!_pageController) {
        _pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageController.delegate = self;
        _pageController.dataSource = self;
    }
    return _pageController;
}

- (NSArray<ZDDHomeController *> *)controllerArray {
    if (!_controllerArray) {
        NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:self.dataArrray.count];
        for (NSInteger i = 0; i < self.dataArrray.count; i ++) {
            ZDDManHuaListModel *model = self.dataArrray[i];
            ZDDHomeController *vc = [[ZDDHomeController alloc] init];
            vc.title = model.title;
            vc.dataArray = model.comic_info;
            [tempArr addObject:vc];
        }
        _controllerArray = tempArr.copy;
    }
    return _controllerArray;
}

@end