//
//  XDHomeViewController.m
//  SideMenu
//
//  Created by Celia on 2017/6/15.
//  Copyright © 2017年 skyApple. All rights reserved.
//

#import "XDHomeViewController.h"

@interface XDHomeViewController ()

@end

@implementation XDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 64 + 30, 100*m5Scale, 60*m5Scale)];
    label.backgroundColor = [UIColor blackColor];
    
    NSLog(@"width :%f , height : %f",label.w ,label.h);
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
