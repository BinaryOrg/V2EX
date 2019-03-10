//
//  ZDDBaseNavigationViewController.m
//  V2EX
//
//  Created by pipelining on 2019/1/26.
//  Copyright © 2019年 binary. All rights reserved.
//

#import "ZDDBaseNavigationViewController.h"
#import "UIColor+ZDDColor.h"
@interface ZDDBaseNavigationViewController ()

@end

@implementation ZDDBaseNavigationViewController

- (instancetype)initWithImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName title:(NSString *)title
{
    self = [super init];
    if (self) {
        UIImage *image = [UIImage imageNamed:imageName];
        UIImage *selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:selectedImage];
        [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor customBlueColor]} forState:UIControlStateSelected];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    UIImageView *iv = [[UIImageView alloc] init];
//    iv.frame = CGRectMake(5, 0, 23, 23);
//    iv.image = [UIImage imageNamed:@"changeUser"];
//    iv.userInteractionEnabled = YES;
//    [iv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickUserView)]];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:iv];
    
}
//- (void)clickUserView {
//    
//    [[ZDDMineView shareInstance] show];
//    
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
