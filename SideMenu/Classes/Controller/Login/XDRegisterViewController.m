//
//  XDRegisterViewController.m
//  SideMenu
//
//  Created by Celia on 2017/6/22.
//  Copyright © 2017年 skyApple. All rights reserved.
//

#import "XDRegisterViewController.h"
#import "XDLoginViewController.h"
#import "XDLoginCell.h"
#import "XDViewTools.h"
#import "XDHtmlViewController.h"

#import "RegisterParameterModel.h"
#import "NSString+XDCategory.h"
#import "XDDNetworking.h"

@interface XDRegisterViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *regisTableView;
@property (nonatomic, strong) UILabel *showErrorMess;
@property (nonatomic, assign) BOOL selectedCarrier;     //选择了个人和企业
@property (nonatomic, assign) BOOL selectedAgreement;   //同意了协议
@property (nonatomic, assign) BOOL showPassword;        //显示密码
@property (nonatomic, strong) UIView *bottomView;       //底部协议和提交的父视图

@property (nonatomic, strong) RegisterParameterModel *registerModel;

@end

static NSString *const regisCellID = @"register_cell";

@implementation XDRegisterViewController{
    NSArray *leftImageArr;          //左侧小图片数组
    NSArray *placeholderStringArr;  //textField 占位字符数组
    NSString *recordPhone;          //记录手机号
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    
    [self dataSourceInit];
    [self SubViewInit];
    
}

- (void)dataSourceInit {
    
    _registerModel = [[RegisterParameterModel alloc] init];
    
    leftImageArr = @[@"registPhoneLeft.png",@"registVCodeLeft.png",@"loginPasswordLeft.png",@"loginPasswordLeft.png"];
    placeholderStringArr = @[@"请输入手机号",@"请输入验证码",@"请输入密码",@"请再次输入密码"];
}


//子视图初始化
- (void)SubViewInit {
    
    _regisTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, mScreenWidth, 180*m6PScale*4 + 50)];
    _regisTableView.backgroundColor = [UIColor clearColor];
    _regisTableView.dataSource = self;
    _regisTableView.delegate = self;
    _regisTableView.scrollEnabled = NO;
    
    //tableview 添加头视图
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, 50)];
    [_regisTableView setTableHeaderView:headView];
    
    
    [self.view addSubview:_regisTableView];
    
    [_regisTableView registerNib:[UINib nibWithNibName:@"XDLoginCell" bundle:nil] forCellReuseIdentifier:regisCellID];
    
    //
    _showErrorMess = [[XDViewTools shareTools] labelFrame:CGRectMake(0, _regisTableView.bottom, mScreenWidth, 30) text:@"" textColor:[UIColor redColor] font:14.0];
    _showErrorMess.backgroundColor = BGCOLOR_LightGray;
    [self.view addSubview:_showErrorMess];
    
    //协议和提交按钮
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, _showErrorMess.bottom, mScreenWidth, mScreenHeight / 4)];
    _bottomView.backgroundColor = BGCOLOR_LightGray;
    UIView *agreementView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, mScreenWidth - 20, 40)];
    UIButton *agreeBtn = [[XDViewTools shareTools] buttonFrame:CGRectMake(0, 10, 20, 20) image:@"agreement_no.png" selectedImage:@"agreement_yes.png"];
    agreeBtn.tag = 104;
    [agreeBtn addTarget:self action:@selector(agreeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *readLabel = [[XDViewTools shareTools] labelFrame:CGRectMake(agreeBtn.right + 5, 0, 80, 40) text:@"阅读并同意" textColor:[UIColor grayColor] font:15.0f];
    UIButton *agreementWord = [[XDViewTools shareTools] buttonFrame:CGRectMake(readLabel.right, 0, 180, 40) title:@"《软件许可及服务协议》" titleColor:BGCOLOR_NaviBar font:15.0f];
    agreementWord.titleLabel.textAlignment = NSTextAlignmentLeft;
    [agreementWord addTarget:self action:@selector(showAgreementWord:) forControlEvents:UIControlEventTouchUpInside];
    [agreementView addSubview:agreeBtn];
    [agreementView addSubview:readLabel];
    [agreementView addSubview:agreementWord];
    
    UIButton *commitBtn = [[XDViewTools shareTools] buttonFrame:CGRectMake(20, _bottomView.h / 2 - 20, mScreenWidth - 40, 40) backgroundColor:BGCOLOR_NaviBar title:@"提交" titleColor:[UIColor whiteColor] cornerRadius:5.0f];
    [commitBtn addTarget:self action:@selector(commitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *toLoginView = [[UIView alloc] initWithFrame:CGRectMake(mScreenWidth - 140, commitBtn.bottom + 20, 130, 40)];
    UIButton *toLoginBtn = [[XDViewTools shareTools] buttonFrame:CGRectMake(0, 0, 115, 40) title:@"已有账号,去登录" titleColor:BGCOLOR_NaviBar font:15.0f];
    toLoginBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [toLoginBtn addTarget:self action:@selector(toLoginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *toLoginImage = [[XDViewTools shareTools] imageViewFrame:CGRectMake(toLoginBtn.right, 13, 15, 15) image:@"regist_toLogin.png"];
    [toLoginView addSubview:toLoginBtn];
    [toLoginView addSubview:toLoginImage];
    
    [_bottomView addSubview:agreementView];
    [_bottomView addSubview:commitBtn];
    [_bottomView addSubview:toLoginView];
    
    [self.view addSubview:_bottomView];
}

//同意注册协议
- (void)agreeBtnClicked:(UIButton *)btn {
    
    BOOL haveSelected = btn.selected;
    
    btn.selected = !haveSelected;
    _selectedAgreement = !haveSelected;
}

//webView显示协议
- (void)showAgreementWord:(UIButton *)btn {
    NSLog(@"显示用户注册协议");
    XDHtmlViewController *htmlVC = [[XDHtmlViewController alloc] init];
    htmlVC.title = @"服务协议";
    htmlVC.URLString = [NSString stringWithFormat:@"%@/%@",BaseURL_Short,AgreementEnd];
    [self.navigationController pushViewController:htmlVC animated:YES];
}

#pragma mark - 提交注册
- (void)commitBtnClicked:(UIButton *)btn {
    NSLog(@"提交注册");
    [self.view endEditing:YES];
    
    XDLoginCell *passwordCell = [_regisTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    NSString *password = passwordCell.textField.text;
    
    XDLoginCell *againPassCell = [_regisTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    NSString *againPass = againPassCell.textField.text;
    
    if (![_registerModel.mobilePhone isMobilePhoneNum]) {
        [_showErrorMess setText:@"  手机号码不正确"];
    }else if (!_showPassword && ![password isEqualToString:againPass]) {
        [_showErrorMess setText:@"  两次输入密码不相同"];
    }else if (![password isValidatePassword]) {
        [_showErrorMess setText:@"  密码格式不正确，请输入6-16位数字和字母组合密码"];
    }else if (!_selectedCarrier) {
        [_showErrorMess setText:@"  未选择注册企业/个人用户"];
    }else if (!_selectedAgreement) {
        [_showErrorMess setText:@"  未同意软件注册协议"];
        
    }else if ([_registerModel.SMScode isBlankString]) {
        [_showErrorMess setText:@"  未填写验证码"];
    }else {
        [_showErrorMess setText:@""];
        
        recordPhone = _registerModel.mobilePhone;
        _registerModel.userPassword = password;
        _registerModel.carrierType = 0;
        
        mWeakSelf
        //可以提交
        [[XDDNetworking shareNetworking] userRegisterModel:_registerModel successBlock:^(NSDictionary * _Nonnull successDic) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [XTProgressHUD showText:@"注册成功" atView:mKeyWindow];
                [weakSelf returnLoginVC];
            });
            
        } failBlock:^(NSDictionary * _Nonnull failDic) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [XTProgressHUD showText:@"注册失败" atView:mKeyWindow];
            });
            
        }];
        
    }
    
}


//去登录
- (void)toLoginBtnClicked:(UIButton *)btn {
    NSLog(@"去登录");
    [self returnLoginVC];
}

- (void)returnLoginVC {
    XDLoginViewController *login_vc = (XDLoginViewController *)self.navigationController.viewControllers[0];
    if (recordPhone && recordPhone.length > 0) {
        login_vc.remberPhoneNum = recordPhone;
    }
    [self.navigationController popToViewController:login_vc animated:YES];
}


#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XDLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:regisCellID];
    
    cell.leftImageView.image = [UIImage imageNamed:leftImageArr[indexPath.row]];
    cell.textField.placeholder = placeholderStringArr[indexPath.row];
    cell.textField.delegate = self;
    cell.textField.tag = 10 + indexPath.row;
    
    if (indexPath.row == 0) {
        
        UIButton *SendCodeBtn = [[XDViewTools shareTools] buttonFrame:CGRectMake(cell.contentView.w - 100, 10, 80, 40) backgroundColor:BGCOLOR_NaviBar title:@"获取验证码" titleColor:[UIColor whiteColor] cornerRadius:5.0f];
        SendCodeBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [SendCodeBtn addTarget:self action:@selector(SendCodeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:SendCodeBtn];
        
    }else if (indexPath.row == 2) {
        
        UIButton *eyeBtn = [[XDViewTools shareTools] buttonFrame:CGRectMake(cell.contentView.w - 40, 15, 30, 30) image:@"registerEyeClosed.png" selectedImage:@"registerEyeOpen.png"];
        eyeBtn.tag = 1111;
        [eyeBtn addTarget:self action:@selector(eyeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:eyeBtn];
        
        cell.textField.secureTextEntry = YES;
        
    }else if (indexPath.row == 3) {
        cell.textField.secureTextEntry = YES;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180*m6PScale;
}


//发送验证码
- (void)SendCodeBtnClicked:(UIButton *)btn {
    
    [self.view endEditing:YES];
    
    if (!_registerModel.mobilePhone || ![_registerModel.mobilePhone isMobilePhoneNum]) {
        [_showErrorMess setText:@"  手机号码不正确"];
    }else {
        [_showErrorMess setText:@""];
        NSLog(@"发送短信验证码");
        mWeakSelf
        [[XDDNetworking shareNetworking] sendSMSPhone:_registerModel.mobilePhone type:SMSTypeRegister successBlock:^(NSDictionary * _Nonnull successDic) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [XTProgressHUD showText:@"验证码发送成功" atView:weakSelf.view];
            });
            
        } failBlock:^(NSDictionary * _Nonnull failDic) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [XTProgressHUD showText:@"验证码发送失败" atView:weakSelf.view];
                
            });
            
        }];
    }
}

//显示\隐藏密码
- (void)eyeBtnClicked:(UIButton *)btn {
    NSLog(@"显示、隐藏密码");
    
    XDLoginCell *passwordCell = [_regisTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    XDLoginCell *againPassCell = [_regisTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    BOOL btnSelected = btn.selected;
    if (btnSelected) {
        btn.selected = NO;
        passwordCell.textField.secureTextEntry = YES;
        againPassCell.textField.secureTextEntry = YES;
        _showPassword = NO;
        
        _showErrorMess.transform = CGAffineTransformMakeTranslation(0, 0);
        _bottomView.transform = CGAffineTransformMakeTranslation(0, 0);
        
    }else {
        btn.selected = YES;
        passwordCell.textField.secureTextEntry = NO;
        againPassCell.textField.secureTextEntry = NO;
        _showPassword = YES;
        
        _showErrorMess.transform = CGAffineTransformMakeTranslation(0, -180*m6PScale);
        _bottomView.transform = CGAffineTransformMakeTranslation(0, -180*m6PScale);
    }
    
}

#pragma mark - textField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    switch (textField.tag) {
        case 10:
            textField.keyboardType = UIKeyboardTypePhonePad;
            break;
        default:
            textField.keyboardType = UIKeyboardTypeEmailAddress;
            break;
    }
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    switch (textField.tag) {
        case 10:
        {
            if (![textField.text isMobilePhoneNum]) {
                [_showErrorMess setText:@"  手机号码不正确"];
            }else {
                [_showErrorMess setText:@""];
            }
            XDLoginCell *VCodeCell = [_regisTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            [VCodeCell.textField becomeFirstResponder];
        }
            break;
        case 11:
        {
            XDLoginCell *passCell = [_regisTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            [passCell.textField becomeFirstResponder];
        }
            break;
        case 12:
        {
            if (![textField.text isValidatePassword]) {
                [_showErrorMess setText:@"  密码格式不正确，请输入6-16位数字和字母组合密码"];
            }else {
                [_showErrorMess setText:@""];
            }
            if (_showPassword) {
                //显示密码  就不跳转下一个输入框
            }else {
                XDLoginCell *passAgainCell = [_regisTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
                [passAgainCell.textField becomeFirstResponder];
            }
            
        }
            break;
        case 13:
        {
            XDLoginCell *passCell = [_regisTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            NSString *pass = passCell.textField.text;
            if (![pass isEqualToString:textField.text]) {
                [_showErrorMess setText:@"  两次输入密码不相同"];
            }else {
                [_showErrorMess setText:@""];
            }
            [textField resignFirstResponder];
        }
            break;
        default:
            break;
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    switch (textField.tag) {
        case 10:
        {
            _registerModel.mobilePhone = textField.text;
        }
            break;
        case 11:
        {
            _registerModel.SMScode = textField.text;
        }
            break;
        case 12:
        {
            
        }
            break;
        case 13:
        {
            
        }
            break;
        default:
            break;
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
