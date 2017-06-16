//
//  XDMainViewController.m
//  SideMenu
//
//  Created by Celia on 2017/6/15.
//  Copyright © 2017年 skyApple. All rights reserved.
//

#import "XDMainViewController.h"
#import "XDMainNavigationController.h"
#import "XDHomeViewController.h"
#import "XDDraftViewController.h"
#import "XDMessageViewController.h"

@interface XDMainViewController ()

@end

@implementation XDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont   systemFontOfSize:13], NSForegroundColorAttributeName: [UIColor grayColor]} forState: UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13], NSForegroundColorAttributeName: TEXTCOLOR_TabBarTitle} forState: UIControlStateSelected];
    
    
    [self addChildViewController:[[XDHomeViewController alloc] init] andTitle:@"首页" andImageName:@"tab1_"];
    [self addChildViewController:[[XDDraftViewController alloc] init] andTitle:@"草稿" andImageName:@"tab2_"];
    [self addChildViewController:[[XDMessageViewController alloc] init] andTitle:@"消息" andImageName:@"tab3_"];
    
    
}


-(void)addChildViewController:(UIViewController *)VC andTitle:(NSString *)title andImageName:(NSString *)imageName{
    
    VC.title = title;
    VC.tabBarItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@normal",imageName]];
    VC.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@pressed",imageName]];
    
    self.tabBar.tintColor = mRGB(13, 184, 246);
    
    XDMainNavigationController *nav = [[XDMainNavigationController alloc] initWithRootViewController:VC];
    
    
    [self addChildViewController:nav];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
