//
//  ZDDManHuaController.m
//  V2EX
//
//  Created by Maker on 2019/2/14.
//  Copyright © 2019 binary. All rights reserved.
//

#import "ZDDManHuaController.h"

@interface ZDDManHuaController ()

@end

@implementation ZDDManHuaController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.iv = [[UIImageView alloc] init];
    [self.view addSubview:self.iv];
    self.iv.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.frame.size.height);
    self.iv.contentMode = UIViewContentModeScaleAspectFit;
    self.iv.yy_imageURL = [NSURL URLWithString:@"http://b-ssl.duitang.com/uploads/item/201609/09/20160909112601_xiHke.jpeg"];
    
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
