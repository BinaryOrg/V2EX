//
//  ZDDManHuaController.m
//  V2EX
//
//  Created by Maker on 2019/2/14.
//  Copyright © 2019 binary. All rights reserved.
//

#import "ZDDManHuaController.h"

@interface ZDDManHuaController ()

@property (nonatomic, strong) UIImageView *iv;

@end

@implementation ZDDManHuaController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.iv = [[UIImageView alloc] init];
    [self.view addSubview:self.iv];
    self.iv.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.frame.size.height);
    self.iv.contentMode = UIViewContentModeScaleAspectFit;
    
}

- (void)setImg_url:(NSString *)img_url {
    
    _img_url = img_url;
    self.iv.yy_imageURL = [NSURL URLWithString:[NSString stringWithFormat:img_url]];

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
