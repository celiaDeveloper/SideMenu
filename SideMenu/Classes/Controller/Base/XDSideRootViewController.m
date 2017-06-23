//
//  XDSideRootViewController.m
//  SideMenu
//
//  Created by Celia on 2017/6/19.
//  Copyright © 2017年 skyApple. All rights reserved.
//

#import "XDSideRootViewController.h"
#import "XDContainerViewController.h"

@interface XDSideRootViewController ()

@end

@implementation XDSideRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //侧边栏 所有视图 继承自这个视图控制器
    self.view.backgroundColor = BGCOLOR_LightGray;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSInteger vcCount = self.navigationController.viewControllers.count;
    if (vcCount > 0) {
        if ([self.navigationController.viewControllers[vcCount - 1] isKindOfClass:[XDContainerViewController class]]) {
            self.navigationController.navigationBarHidden = YES;
        }
    }
    
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
