//
//  XDSettingViewController.m
//  SideMenu
//
//  Created by Celia on 2017/6/19.
//  Copyright © 2017年 skyApple. All rights reserved.
//

#import "XDSettingViewController.h"
#import "XDViewTools.h"

#import "XDLoginViewController.h"
#import "XDMainNavigationController.h"

@interface XDSettingViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIScrollView *backScrollView;
@property (nonatomic, strong) UITableView *settingTableView;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) NSArray *leftTitleArr;

@end

static NSString *cellSwitch = @"switchCell";
static NSString *cellArrow = @"arrowCell";

const CGFloat settingCellH = 50;
const CGFloat settingHeaderH = 10;

@implementation XDSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    
    [self.view addSubview:self.backScrollView];
    [self.backScrollView addSubview:self.settingTableView];
    [self.backScrollView addSubview:self.bottomView];
    [self.backScrollView setContentSize:CGSizeMake(mScreenWidth, self.settingTableView.h + self.bottomView.h)];
    
}

- (NSArray *)leftTitleArr {
    if (!_leftTitleArr) {
        _leftTitleArr = @[@[@"提示声音",@"震动"],@[@"清空下载目录",@"清除缓存",@"意见反馈",@"修改绑定手机"],@[@"使用帮助",@"软件更新"]];
    }
    return _leftTitleArr;
}

- (UIScrollView *)backScrollView {
    if (!_backScrollView) {
        _backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, mScreenWidth, mScreenHeight - 64)];
        
    }
    
    return _backScrollView;
}

- (UITableView *)settingTableView {
    if (!_settingTableView) {
        _settingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, 8 *settingCellH + 2 * settingHeaderH) style:UITableViewStylePlain];
        _settingTableView.tableFooterView = [UIView new];
        _settingTableView.dataSource = self;
        _settingTableView.delegate = self;
        _settingTableView.scrollEnabled = NO;
        
    }
    return _settingTableView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.settingTableView.bottom, mScreenWidth, 84)];
        _bottomView.backgroundColor = [UIColor clearColor];
        
        
        UIButton *exitBtn = [[XDViewTools shareTools] buttonFrame:CGRectMake(15, 20, mScreenWidth - 30, 44) backgroundColor:[UIColor redColor] title:@"退出当前账户" titleColor:[UIColor whiteColor] cornerRadius:5.0f tag:111];
        [exitBtn addTarget:self action:@selector(exitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:exitBtn];
        
    }
    return _bottomView;
}

- (void)exitBtnAction:(UIButton *)btn {
    
    mWeakSelf
    UIAlertController *alertSheet = [[XDViewTools shareTools] alertSheetTitle:@"确定要退出登录吗？"  cancelTitle:@"取消" action2Title:@"确认" cancelHandler:^(UIAlertAction *action) {
        
    } action2Handler:^(UIAlertAction *action) {
        [weakSelf exitLogin];
    }];
    [self.navigationController presentViewController:alertSheet animated:YES completion:nil];
    
}

#pragma mark - 退出登录
- (void)exitLogin {
    
//    ExitLoginModel *exitModel = [[ExitLoginModel alloc] init];
//    exitModel.loginName = [kUSERDEFAULTS objectForKey:LOGIN_Name];
//    exitModel.loginToken = [kUSERDEFAULTS objectForKey:LOGIN_Password];
//    
//    [[XDDNetworking shareNetworking] exitLoginModel:exitModel successBlock:^(NSDictionary * _Nonnull successDic) {
//        
//        Log(@"exit :%@",successDic);
//        [[XDDDataManager shareManager] removeLoginData];
//        
//    } failBlock:^(NSDictionary * _Nonnull failDic) {
//        
//    }];
    
    [mUserDefaults setBool:NO forKey:ISLOGINTAG];
    
    XDLoginViewController *loginVC = [[XDLoginViewController alloc] init];
    XDMainNavigationController *loginNav = [[XDMainNavigationController alloc] initWithRootViewController:loginVC];
    [[UIApplication sharedApplication] keyWindow].rootViewController = loginNav;
}

#pragma mark - 开关控件
- (void)statusSwitch:(UISwitch *)sender {
    if (100 == sender.tag) {
        NSLog(@"提示音");
    }else if(101 == sender.tag) {
        NSLog(@"震动");
    }
}

#pragma mark - tableview  delegate  datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (1 == section) {
        return 4;
    }
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return settingCellH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (0 == section) {
        return 0;
    }
    return settingHeaderH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.section) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellSwitch];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellSwitch];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        UISwitch *tempS = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        tempS.tag = 100 +indexPath.row;
        [tempS addTarget:self action:@selector(statusSwitch:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = tempS;
        
        cell.textLabel.text = self.leftTitleArr[indexPath.section][indexPath.row];
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellArrow];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellArrow];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.accessoryView = [[XDViewTools shareTools] imageViewFrame:CGRectMake(0, 0, 20, 20) image:@"regist_toLogin.png"];
    
    cell.textLabel.text = self.leftTitleArr[indexPath.section][indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
