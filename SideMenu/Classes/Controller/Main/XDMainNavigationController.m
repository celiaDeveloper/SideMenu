//
//  XDMainNavigationController.m
//  SideMenu
//
//  Created by Celia on 2017/6/15.
//  Copyright © 2017年 skyApple. All rights reserved.
//

#import "XDMainNavigationController.h"

@interface XDMainNavigationController ()

@end

@implementation XDMainNavigationController

//一个类只调用一次
+ (void)initialize {
    //取出设置主题的对象
    UINavigationBar *naviBar = [UINavigationBar appearance];
    
    //bar 的背景颜色
    [naviBar setBarTintColor:BGCOLOR_NaviBar];
    //bar 的前景颜色
    [naviBar setTintColor:[UIColor whiteColor]];
    //bar 的标题颜色
    [naviBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



//设置返回按钮的文字显示
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    [super pushViewController:viewController animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
