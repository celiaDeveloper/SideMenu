//
//  XDMainRootViewController.m
//  SideMenu
//
//  Created by Celia on 2017/6/15.
//  Copyright © 2017年 skyApple. All rights reserved.
//

#import "XDMainRootViewController.h"

@interface XDMainRootViewController ()

@property (nonatomic, strong) UIImageView *headImage;

@end

@implementation XDMainRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BGCOLOR_LightGray;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self addSubView];
}

-(void)addSubView{
    
    self.headImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"head"]];
    
    self.headImage.frame = CGRectMake(0, 0, 35, 35);
    self.headImage.layer.cornerRadius = self.headImage.bounds.size.height * 0.5;
    self.headImage.layer.masksToBounds = YES;
    self.headImage.userInteractionEnabled = YES;
    [self.headImage setImage:[UIImage imageNamed:@"head"]];

    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSideMenu)];
    [self.headImage addGestureRecognizer:singleTap];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.headImage];
    
}

-(void)showSideMenu{
    [mNotificationCenter postNotificationName:NOTIFICATION_ShowMenu object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [mNotificationCenter postNotificationName:PANGESTURE_ADD object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [mNotificationCenter postNotificationName:PANGESTURE_REMOVE object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if ([mUserDefaults boolForKey:MENU_SHOWED]) {
        [mNotificationCenter postNotificationName:NOTIFICATION_ShowMenu object:nil];
        NSLog(@"hide_menu hide_menu hide_menu ");
    }else {
        [super touchesBegan:touches withEvent:event];
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
