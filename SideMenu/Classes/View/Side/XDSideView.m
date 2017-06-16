//
//  XDSideView.m
//  SideMenu
//
//  Created by Celia on 2017/6/15.
//  Copyright © 2017年 skyApple. All rights reserved.
//

#import "XDSideView.h"
#import "XDSideTableView.h"
#import <Masonry.h>

@interface XDSideView ()

@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, copy) NSString *name;

@end

@implementation XDSideView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        CGFloat headW = mScreenWidth/6;
        CGFloat headH = headW;
        CGFloat M_TOP = mScreenHeight/12;
        
        
        
        //  头像
        _headImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"head"]];
        [_headImage layout_heigth:headH];
        [_headImage layout_width:headW];
        _headImage.layer.cornerRadius = headW * 0.5;
        _headImage.layer.masksToBounds = YES;
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeHeaderImage)];
        [_headImage addGestureRecognizer:singleTap];
        
        [self addSubview:_headImage];
        
        [_headImage layout_horizontalCenter];
        
        [_headImage margin_rigth:kDeviceWidth * 0.675];
        
        [_headImage margin_top:M_TOP];
        [_headImage setImage:[UIImage imageNamed:@"head"]];
//        [_headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",BaseURL_Short,ImageURLMiddle,[kUSERDEFAULTS objectForKey:CUSTOMER_HEAD]]] placeholderImage:[UIImage imageNamed:@"head"]];
        
        //名称
        UILabel *headLabel = [[UILabel alloc]init];
        headLabel.textColor = [UIColor whiteColor];
        headLabel.font = [UIFont systemFontOfSize:14.0];
        headLabel.text = @"用户名称";
        
        headLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:headLabel];
        
        [headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headImage.mas_bottom).offset(5);
            make.centerX.equalTo(_headImage.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(kDeviceWidth / 2, 30));
        }];
        
        
        //tableview
        XDSideTableView *sbv = [[XDSideTableView alloc] initWithFrame:CGRectMake(0, mScreenHeight * 0.35, mScreenWidth, mScreenHeight * 0.6 - 48)];
        
        sbv.backgroundColor = [UIColor clearColor];
        
        [self addSubview:sbv];
        [sbv margin_left:kDeviceWidth*0.05];
        
        //  ===========================================
        //       创建底部view的按钮
        //        UIButton *setBtn=[[UIButton alloc]initWithFrame:CGRectMake(0,0,48*2,48)];
        //        [setBtn setTitle:@"设置" forState:UIControlStateNormal];
        //        [setBtn setImage:[UIImage imageNamed:@"sidebar_setting"] forState:UIControlStateNormal];
        //
        //
        //        UIButton *dayBtn=[[UIButton alloc]initWithFrame:CGRectMake(48*2,0,48*2,48)];
        //        [dayBtn setTitle:@"夜间" forState:UIControlStateNormal];
        //        [dayBtn setImage:[UIImage imageNamed:@"sidebar_nightmode_on"] forState:UIControlStateNormal];
        
        UILabel *versiton = [[UILabel alloc]init];
        versiton.textColor = [UIColor whiteColor];
        versiton.text = @"V1.0.0";
        [versiton layout_width:100];
        [versiton layout_heigth:30];
        versiton.textAlignment = NSTextAlignmentCenter;
        
        
        //底部view
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, mScreenHeight - 48, mScreenWidth * 0.5, 48)];
        footView.backgroundColor = [UIColor clearColor];
        
        [footView addSubview:versiton];
        [versiton layout_verticalCenter];
        [versiton layout_horizontalCenter];
        
        
        
        [self addSubview:footView];
        
    }
    
    //    注册通知观察者（接受通知，将记录跳转界面的值从主控制器传过来）
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(zhuchuanzuo:) name:@"主传左" object:nil];
    
    
    return  self ;
    
}
-(void)dealloc
{
    // 移除通知观察者.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    NSLog(@"移除主传左通知对象");
}
//接受从主控制器传过来的值
-(void)zhuchuanzuo:(NSNotification *)notify{
    
    self.name = notify.object;
}
//点击了头像按钮（更换头像）
-(void)changeHeaderImage{
    
    NSLog(@"更换头像");
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:self.name object:nil];
    
    
    
}

@end
