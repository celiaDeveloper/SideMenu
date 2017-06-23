//
//  XDSideTableView.m
//  SideMenu
//
//  Created by Celia on 2017/6/15.
//  Copyright © 2017年 skyApple. All rights reserved.
//

#import "XDSideTableView.h"
#import "XDMemberViewController.h"
#import "XDTrackingViewController.h"
#import "XDHistoryViewController.h"
#import "XDComplaintsViewController.h"
#import "XDContactUsViewController.h"
#import "XDSettingViewController.h"

#import "UIView+XDParentVC.h"
#import "XDContainerViewController.h"

@interface XDSideTableView ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation XDSideTableView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    //设置代理和数据源
    self.delegate=self;
    self.dataSource=self;
    
    self.rowHeight=50;
    
    self.separatorStyle=NO;
    return  self;
}



#pragma mark - 代理方法
//实现数据源方法
-(NSInteger)numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    
    if (indexPath.row==0) {
        cell.imageView.image=[UIImage imageNamed:@"icon_menu1"];
        cell.textLabel.text=@"会员审核";
    }else if (indexPath.row==1){
        cell.imageView.image=[UIImage imageNamed:@"icon_menu2"];
        cell.textLabel.text=@"物流跟踪";
    }else if (indexPath.row==2){
        cell.imageView.image=[UIImage imageNamed:@"icon_menu3"];
        cell.textLabel.text=@"历史订单";
    }else if (indexPath.row==3){
        cell.imageView.image=[UIImage imageNamed:@"icon_menu4"];
        cell.textLabel.text=@"我的投诉";
    }else if (indexPath.row==4){
        cell.imageView.image=[UIImage imageNamed:@"icon_menu4"];
        cell.textLabel.text=@"联系我们";
    }else{
        cell.imageView.image=[UIImage imageNamed:@"icon_menu5"];
        cell.textLabel.text=@"设置";
    }
    
    cell.backgroundColor=[UIColor clearColor];
    cell.textLabel.textColor=[UIColor whiteColor];
    //    点击cell时没有点击效果
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
}


//然后在设置cell的高度(controller)
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XDContainerViewController *containerVC = (XDContainerViewController *)[self parentClass:[UIViewController class]];
    
    switch (indexPath.row) {
        case 0:
        {
            XDMemberViewController *memberVC = [[XDMemberViewController alloc] init];
            [containerVC.navigationController pushViewController:memberVC animated:YES];
        }
            break;
        case 1:
        {
            XDTrackingViewController *trackingVC = [[XDTrackingViewController alloc] init];
            [containerVC.navigationController pushViewController:trackingVC animated:YES];
        }
            break;
        case 2:
        {
            XDHistoryViewController *historyVC = [[XDHistoryViewController alloc] init];
            [containerVC.navigationController pushViewController:historyVC animated:YES];
        }
            break;
        case 3:
        {
            XDComplaintsViewController *complaintsVC = [[XDComplaintsViewController alloc] init];
            [containerVC.navigationController pushViewController:complaintsVC animated:YES];
        }
            break;
        case 4:
        {
            XDContactUsViewController *contactVC = [[XDContactUsViewController alloc] init];
            [containerVC.navigationController pushViewController:contactVC animated:YES];
        }
            break;
        case 5:
        {
            XDSettingViewController *settingVC = [[XDSettingViewController alloc] init];
            [containerVC.navigationController pushViewController:settingVC animated:YES];
        }
            break;
        default:
            break;
    }
    
}




@end
