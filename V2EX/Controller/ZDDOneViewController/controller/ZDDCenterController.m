//
//  ZDDCenterController.m
//  V2EX
//
//  Created by Maker on 2019/3/8.
//  Copyright © 2019 binary. All rights reserved.
//

#import "ZDDCenterController.h"
#import "ZDDChangeTypeView.h"
#import "ZDDHomeController.h"

@interface ZDDCenterController ()<ZDDChangeTypeViewDelegate, UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) ZDDChangeTypeView *changeTypeView;
@property (nonatomic, strong) NSArray *dataArrray;
@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) NSArray <ZDDHomeController *>*controllerArray;
@property (nonatomic, strong) UIPageViewController *pageController;



@property (nonatomic, strong)  UIButton *btn;

@end

@implementation ZDDCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"漫画";
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.mas_equalTo(100);
    }];
    [btn setTitle:@"重新加载" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(loadData) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = [UIColor grayColor].CGColor;
    btn.layer.borderWidth = 0.5;
    self.btn = btn;
    [self loadData];
}

- (void)loadData {
    
    [MFHUDManager showLoading:@"请求中..."];
    NSDictionary *paragmras = @{
                                };
    MFNETWROK.requestSerialization = MFJSONRequestSerialization;
    [MFNETWROK get:@"getBookByType" params:paragmras success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
        [MFHUDManager dismiss];
        if (statusCode == 200) {
            self.dataArrray = [NSArray yy_modelArrayWithClass:ZDDManHuaListModel.class json:result[@"data"][@"book"]];
            
            [self setupUI];
            self.btn.hidden = YES;
        }else {
            self.btn.hidden = NO;
            [MFHUDManager showError:@"请求失败"];
        }
    } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
        
        [MFHUDManager dismiss];
        [MFHUDManager showError:@"请求失败"];
    }];
}
- (void)setupUI {
    
    
    [self.view addSubview:self.changeTypeView];
    [self.changeTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
    [self.pageController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.changeTypeView.mas_bottom);
        make.bottom.mas_equalTo(0);
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
