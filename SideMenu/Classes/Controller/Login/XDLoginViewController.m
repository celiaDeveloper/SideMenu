//
//  XDLoginViewController.m
//  SideMenu
//
//  Created by Celia on 2017/6/21.
//  Copyright © 2017年 skyApple. All rights reserved.
//

#import "XDLoginViewController.h"
#import "XDViewTools.h"
#import "XDLoginCell.h"

#import "XDContainerViewController.h"
#import "XDMainNavigationController.h"

#import "XDRegisterViewController.h"
#import "XDForgotPasswordViewController.h"

@interface XDLoginViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *middleTable;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UILabel *showErrorMess;

@property (nonatomic, copy) NSString *nameString;
@property (nonatomic, copy) NSString *passwordString;

@end

static NSString *const middleCellID = @"login_cell";

@implementation XDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    
    [mUserDefaults setBool:NO forKey:ISLOGINTAG];
    
    [self navigationSet];
    
    [self addSubViews];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_showErrorMess setText:@""];
    //注册成功返回登录页  刷新页面
    [_middleTable reloadData];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [mNotificationCenter removeObserver:self];
}

//定义Navigation右侧的item
- (void)navigationSet {
    
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];//设置了下一个跳转页面的左侧返回按钮
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerAction:)];
}

#pragma mark - 注册
- (void)registerAction:(id)sender {

    XDRegisterViewController *registerVC = [[XDRegisterViewController alloc] init];
//    registerVC.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];//不管用
    
    [self.navigationController pushViewController:registerVC animated:YES];
    
}

#pragma mark - subViews
- (void)addSubViews {
    
    //顶部 icon
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, mScreenWidth, mScreenHeight /4)];
    headView.backgroundColor = [UIColor clearColor];
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth /4, mScreenWidth / 4)];
    [iconView setImage:[UIImage imageNamed:@"head_icon.png"]];
    iconView.center = CGPointMake(mScreenWidth / 2, mScreenHeight / 4 / 2);
    [headView addSubview:iconView];
    [self.view addSubview:headView];
    
    
    //tableview
    _middleTable = [[UITableView alloc] initWithFrame:CGRectMake(0, headView.bottom, mScreenWidth, 180*m6PScale * 2)];
    _middleTable.backgroundColor = [UIColor clearColor];
    _middleTable.delegate = self;
    _middleTable.dataSource = self;
    _middleTable.scrollEnabled = NO;
    [self.view addSubview:_middleTable];
    
    [_middleTable registerNib:[UINib nibWithNibName:@"XDLoginCell" bundle:nil] forCellReuseIdentifier:middleCellID];
    
    //显示手机号 密码的错误提示
    _showErrorMess = [[XDViewTools shareTools] labelFrame:CGRectMake(15, _middleTable.bottom, mScreenWidth - 30, 30) text:@"" textColor:[UIColor redColor] font:14.0];
    _showErrorMess.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_showErrorMess];
    
    //底部登录和忘记密码
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, _showErrorMess.bottom, mScreenWidth, mScreenHeight / 4)];
    bottomView.backgroundColor = [UIColor clearColor];
    _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 0, mScreenWidth - 40, 40)];
    _loginBtn.layer.cornerRadius = 5.0f;
    _loginBtn.showsTouchWhenHighlighted = YES;
    _loginBtn.center = CGPointMake(mScreenWidth / 2, mScreenHeight / 8);
    _loginBtn.backgroundColor = BGCOLOR_NaviBar;
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:_loginBtn];
    
    UIButton *forgotPassBtn = [[UIButton alloc] initWithFrame:CGRectMake(mScreenWidth - 100, _loginBtn.bottom + 10, 80, 40)];
    forgotPassBtn.showsTouchWhenHighlighted = YES;
    [forgotPassBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [forgotPassBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgotPassBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    forgotPassBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [forgotPassBtn addTarget:self action:@selector(forgotPassBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:forgotPassBtn];
    
    [self.view addSubview:bottomView];
    
}

#pragma mark - 登录 忘记密码
//登录
- (void)loginBtnClicked:(UIButton *)btn {
    [self.view endEditing:YES];
    
    if (![_nameString isMobilePhoneNum]) {
        
        NSLog(@"手机号格式不正确");
        [_showErrorMess setText:@"手机号格式不正确"];
        
    }else if (![_passwordString isValidatePassword]) {
        NSLog(@"密码格式不正确");
        [_showErrorMess setText:@"密码格式不正确"];
        
    }else {
        [_showErrorMess setText:@""];
        
        
        [self loginSuccessed];
        
//        mHUDSHOWAT(self.view)
//        
//        mWeakSelf
//        [[XDDNetworking shareNetworking] userLoginModel:_loginModel successBlock:^(NSDictionary * _Nonnull successDic) {
//            
//            weakSelf.returnModel = [[LoginReturnedModel alloc] initWithDictionary:successDic error:nil];
//            
//            Log(@"登录 服务器 :%@",successDic);
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                mHUDHIDE
//                if ([[XDDDataManager shareManager] saveLoginData:successDic]) {
//                    [kUSERDEFAULTS setObject:weakSelf.loginModel.loginToken forKey:LOGIN_Password];
//                    [weakSelf loginSuccessed];
//                }else {
//                    NSString *errDesc = kSTRINGVALUE(_returnModel.message);
//                    [XTProgressHUD showText:errDesc atView:mKeyWindow];
//                    
//                }
//                
//            });
//            
//            
//        } failBlock:^(NSDictionary * _Nonnull failDic) {
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                mHUDHIDE
//                NSString *errDesc = @"登录失败";
//                if (failDic[HTTP_RESULT_DESC]) {
//                    errDesc = [NSString stringWithFormat:@"%@",failDic[HTTP_RESULT_DESC]];
//                }
//                [XTProgressHUD showText:errDesc atView:mKeyWindow];
//                
//            });
//            
//        }];
        
    }
    
}

//忘记密码
- (void)forgotPassBtnClicked:(UIButton *)btn {
    
    NSLog(@"忘记密码");
    XDForgotPasswordViewController *forgotVC = [[XDForgotPasswordViewController alloc] init];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    [self.navigationController pushViewController:forgotVC animated:YES];
    
}

#pragma mark - table Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XDLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:middleCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textField.delegate = self;
    cell.textField.returnKeyType = UIReturnKeyDone;
    switch (indexPath.row) {
        case 0:
        {
            cell.leftImageView.image = [UIImage imageNamed:@"loginUserLeft.png"];
            cell.textField.placeholder = @"请输入手机号";
            cell.textField.tag = 11;
            
            //注册后的手机号
            if (self.remberPhoneNum && [self.remberPhoneNum length] > 2) {
                cell.textField.text = self.remberPhoneNum;
                _nameString = cell.textField.text;
            }else if ([mUserDefaults objectForKey:LOGIN_Name]) {
                
                cell.textField.text = [mUserDefaults objectForKey:LOGIN_Name];
                _nameString = cell.textField.text;
            }
            
        }
            break;
        case 1:
        {
            cell.leftImageView.image = [UIImage imageNamed:@"loginPasswordLeft"];
            cell.textField.placeholder = @"请输入密码";
            cell.textField.tag = 12;
            cell.textField.secureTextEntry = YES;
        }
            break;
        default:
            break;
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180*m6PScale;
}


#pragma mark - textField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    switch (textField.tag) {
        case 11:
            textField.keyboardType = UIKeyboardTypePhonePad;
            break;
        case 12:
            textField.keyboardType = UIKeyboardTypeEmailAddress;
            break;
        default:
            break;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (11 == textField.tag) {
        
        XDLoginCell *passCell = [_middleTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        [passCell.textField becomeFirstResponder];
        NSString *phoneNum = textField.text;
        if (![phoneNum isMobilePhoneNum]) {
            [_showErrorMess setText:@"手机号码不正确"];
        }else {
            [_showErrorMess setText:@""];
        }
        
    }else if (12 == textField.tag) {
        
        [textField resignFirstResponder];
        NSString *passString = textField.text;
        if (![passString isValidatePassword]) {
            [_showErrorMess setText:@"密码不正确"];
        }else {
            [_showErrorMess setText:@""];
        }
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    switch (textField.tag) {
        case 11:
        {
            _nameString = textField.text;
        }
            break;
        case 12:
        {
            _passwordString = textField.text;
        }
            break;
        default:
            break;
    }
}

#pragma mark - 登录成功
- (void)loginSuccessed {
    
    [mUserDefaults setBool:YES forKey:ISLOGINTAG];
    
    XDContainerViewController *CVC = [[XDContainerViewController alloc] init];
    XDMainNavigationController *containerNav = [[XDMainNavigationController alloc] initWithRootViewController:CVC];
    containerNav.navigationBarHidden = YES;
    [[UIApplication sharedApplication] keyWindow].rootViewController = containerNav;
    
}


#pragma mark - 键盘位置改变  改变view位置
- (void)transformView:(NSNotification *)notice {
    //获取键盘弹出前的Rect
    NSValue *keyBoardBeginBounds=[[notice userInfo]objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect beginRect=[keyBoardBeginBounds CGRectValue];
    
    //获取键盘弹出后的Rect
    NSValue *keyBoardEndBounds=[[notice userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect  endRect=[keyBoardEndBounds CGRectValue];
    
    CGFloat changedY = endRect.origin.y - beginRect.origin.y;
    
    NSLog(@"keybord y :%f", endRect.origin.y);
    
    if (changedY < 0) {
        self.view.transform = CGAffineTransformMakeTranslation(0, -100);
    }else if(changedY > 0) {
        
        self.view.transform = CGAffineTransformMakeTranslation(0, 0);
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
