//
//  XDHtmlViewController.m
//  SideMenu
//
//  Created by Celia on 2017/6/23.
//  Copyright © 2017年 skyApple. All rights reserved.
//

#import "XDHtmlViewController.h"

@interface XDHtmlViewController ()

@end

@implementation XDHtmlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BGCOLOR_LightGray;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIWebView *webV = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, mScreenWidth, mScreenHeight - 64)];
    
    
    if (self.URLString) {
        NSLog(@"服务协议 url -- %@", self.URLString);
        [webV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.URLString]]];
    }
    
    [self.view addSubview:webV];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
