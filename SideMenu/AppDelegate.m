//
//  AppDelegate.m
//  SideMenu
//
//  Created by Celia on 2017/6/15.
//  Copyright © 2017年 skyApple. All rights reserved.
//

#import "AppDelegate.h"
#import "XDContainerViewController.h"
#import "XDMainNavigationController.h"
#import "XDLoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"screen width %f",mScreenWidth);
    NSLog(@"screen height %f",mScreenHeight);
    
    [self makeWindowRootVC];
    
    [self.window makeKeyAndVisible];
    
    [NSThread sleepForTimeInterval:1.0];//设置启动页面时间
    
    return YES;
}

- (void)makeWindowRootVC {
    
    if ([mUserDefaults boolForKey:ISLOGINTAG]) {
        
        //已经登录
        XDContainerViewController *CVC = [[XDContainerViewController alloc] init];
        XDMainNavigationController *containerNav = [[XDMainNavigationController alloc] initWithRootViewController:CVC];
        
        containerNav.navigationBarHidden = YES;
        
        self.window.rootViewController = containerNav;
        
    }else {
        
        XDLoginViewController *loginVC = [[XDLoginViewController alloc] init];
        XDMainNavigationController *loginNav = [[XDMainNavigationController alloc] initWithRootViewController:loginVC];
        
        self.window.rootViewController = loginNav;
        
    }
 
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
