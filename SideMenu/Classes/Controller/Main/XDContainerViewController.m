//
//  XDContainerViewController.m
//  SideMenu
//
//  Created by Celia on 2017/6/15.
//  Copyright © 2017年 skyApple. All rights reserved.
//

#import "XDContainerViewController.h"
#import "XDSideView.h"
#import "XDMainViewController.h"

@interface XDContainerViewController ()

@property (nonatomic,assign) Boolean isShow;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@end

@implementation XDContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navigationSet];
    self.view.backgroundColor = BGCOLOR_Side;
    
    [self addSubViews];
    
    [mUserDefaults setBool:NO forKey:MENU_SHOWED];
    
    [mNotificationCenter addObserver:self selector:@selector(showMenu) name:NOTIFICATION_ShowMenu object:nil];
    [mNotificationCenter addObserver:self selector:@selector(addRecognizer) name:PANGESTURE_ADD object:nil];
    [mNotificationCenter addObserver:self selector:@selector(removeRecognizer) name:PANGESTURE_REMOVE object:nil];
    
}

//添加子视图
-(void)addSubViews{
    
    //在self.view上创建一个透明的View
    XDSideView *mainView = [[XDSideView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    //设置冰川背景图
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    img.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*0.4);
    
    [self.view addSubview:img];
    
    img.hidden=YES;
    
    //添加
    [self.view addSubview:mainView];
    
    [self addTabbarController];
    
}


//添加主控制器（tabbarcontroller）的View
-(void)addTabbarController{
    
    XDMainViewController *MVC = [[XDMainViewController alloc] init];
    
    //添加子控制器 - 保证响应者链条的正确传递
    [self addChildViewController:MVC];
    
    
    //将 MVC 的视图，添加到 self.view 上
    [self.view addSubview:MVC.view];
    
    MVC.view.frame = self.view.bounds;
    
}

//添加手势
-(void)addRecognizer{
    //添加拖拽
    if (!_pan) {
        _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPanEvent:)];
        [self.view addGestureRecognizer:_pan];
    }
    
}

//移除手势
- (void)removeRecognizer {
    [self.view removeGestureRecognizer:self.pan];
    self.pan = nil;
}


//实现拖拽
-(void)didPanEvent:(UIPanGestureRecognizer *)recognizer{
    
    
    // 1. 获取手指拖拽的时候, 平移的值
    CGPoint translation = [recognizer translationInView:[self.view.subviews objectAtIndex:2]];
    
    // 2. 让当前控件做响应的平移
    [self.view.subviews objectAtIndex:2].transform = CGAffineTransformTranslate([self.view.subviews objectAtIndex:2].transform, translation.x, 0);
    
    // 3. 每次平移手势识别完毕后, 让平移的值不要累加
    [recognizer setTranslation:CGPointZero inView:[self.view.subviews objectAtIndex:2]];
    
    //获取最右边范围
    CGAffineTransform rightScopeTransform = CGAffineTransformTranslate(self.view.transform, mScreenWidth * 0.5, 0);
    
    //当移动到右边极限时
    if ([self.view.subviews objectAtIndex:2].transform.tx > rightScopeTransform.tx) {
        
        //限制最右边的范围
        [self.view.subviews objectAtIndex:2].transform = rightScopeTransform;
        //限制透明view最右边的范围
        //    [self.view.subviews objectAtIndex:1].ttx=[self.view.subviews objectAtIndex:2].ttx;
        
        //当移动到左边极限时
    }else if ([self.view.subviews objectAtIndex:2].transform.tx < 0.0){
        
        //限制最左边的范围
        [self.view.subviews objectAtIndex:2].transform = CGAffineTransformTranslate(self.view.transform, 0, 0);
        //    限制透明view最左边的范围
        //   [self.view.subviews objectAtIndex:1].ttx=[self.view.subviews objectAtIndex:2].ttx;
        
    }
    //    当托拽手势结束时执行
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        [UIView animateWithDuration:0.2 animations:^{
            
            if ([self.view.subviews objectAtIndex:2].x > mScreenWidth * 0.4) {
                
                [self.view.subviews objectAtIndex:2].transform = rightScopeTransform;
                self.isShow = true;
                
                
            }else{
                self.isShow = false;
                
                [self.view.subviews objectAtIndex:2].transform = CGAffineTransformIdentity;
                
            }
        }];
    }
}


-(void)showMenu{
    
    
    self.isShow = !self.isShow;
    [mUserDefaults setBool:self.isShow forKey:MENU_SHOWED];
    
    if(self.isShow){
        
        CGAffineTransform rightScopeTransform = CGAffineTransformTranslate(self.view.transform,mScreenWidth * 0.5, 0);
        
        
        
        [UIView animateWithDuration:0.2 animations:^{
            [self.view.subviews objectAtIndex:2].transform = rightScopeTransform;
        }];
        
    }else{
        
        [UIView animateWithDuration:0.2 animations:^{
            [self.view.subviews objectAtIndex:2].transform = CGAffineTransformIdentity;
        }];
        
        
    }
    
    //获取最右边范围
    
    
}





-(void)dealloc{
    // 移除通知观察者.
    [mNotificationCenter removeObserver:self];
    
}

- (void)navigationSet {
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
