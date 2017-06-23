//
//  XDLoginRootViewController.m
//  SideMenu
//
//  Created by Celia on 2017/6/21.
//  Copyright © 2017年 skyApple. All rights reserved.
//

#import "XDLoginRootViewController.h"

@interface XDLoginRootViewController ()

@end

@implementation XDLoginRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //登录、注册、忘记密码 都继承自这个VC
    self.view.backgroundColor = BGCOLOR_LightGray;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //添加手势 点击隐藏键盘
    [self addTapGesture];
    
}

#pragma mark - 点击手势
- (void)addTapGesture {
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidesKeybord:)];
    [self.view addGestureRecognizer:singleTap];
    
}

- (void)hidesKeybord:(id)sender {
    [self.view endEditing:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
