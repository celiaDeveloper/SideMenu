//
//  XDForgotPasswordViewController.m
//  SideMenu
//
//  Created by Celia on 2017/6/22.
//  Copyright © 2017年 skyApple. All rights reserved.
//

#import "XDForgotPasswordViewController.h"

#import "XDViewTools.h"
#import "XDLoginCell.h"
#import "ForgotPasswordModel.h"
#import "XDDNetworking.h"
#import "NSString+XDCategory.h"

@interface XDForgotPasswordViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *forgotTableView;
@property (nonatomic, strong) UILabel *showErrorMess;
@property (nonatomic, assign) BOOL showPassword;        //显示密码
@property (nonatomic, strong) UIView *bottomView;       //底部协议和提交的父视图

@property (nonatomic, strong) ForgotPasswordModel *forgotModel;

@end

static NSString *const forgotCellID = @"forgot_cell";

@implementation XDForgotPasswordViewController{
    NSArray *leftImageArr;
    NSArray *placeholderArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"找回密码";
    
    [self dataSourceInit];
    [self subViewInit];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_showErrorMess setText:@""];
}

- (void)dataSourceInit {
    
    _forgotModel = [[ForgotPasswordModel alloc] init];
    leftImageArr = @[@"registPhoneLeft.png",@"registVCodeLeft.png",@"loginPasswordLeft.png",@"loginPasswordLeft.png"];
    placeholderArr = @[@"请输入手机号",@"请输入验证码",@"请输入密码",@"请重复输入密码"];
}

- (void)subViewInit {
    
    _forgotTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, mScreenWidth, 180*m6PScale*4 + 20)];
    _forgotTableView.backgroundColor = [UIColor clearColor];
    _forgotTableView.dataSource = self;
    _forgotTableView.delegate = self;
    _forgotTableView.scrollEnabled = NO;
    [self.view addSubview:_forgotTableView];
    
    [_forgotTableView registerNib:[UINib nibWithNibName:@"XDLoginCell" bundle:nil] forCellReuseIdentifier:forgotCellID];
    
    _showErrorMess = [[XDViewTools shareTools] labelFrame:CGRectMake(0, _forgotTableView.bottom, mScreenWidth, 30) text:@"" textColor:[UIColor redColor] font:14.0];
    _showErrorMess.backgroundColor = BGCOLOR_LightGray;
    [self.view addSubview:_showErrorMess];
    
    //提交
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, _showErrorMess.bottom, mScreenWidth, mScreenHeight / 4)];
    _bottomView.backgroundColor = BGCOLOR_LightGray;
    UIButton *commitBtn = [[XDViewTools shareTools] buttonFrame:CGRectMake(20, 0, mScreenWidth - 40, 40) backgroundColor:BGCOLOR_NaviBar title:@"提交" titleColor:[UIColor whiteColor] cornerRadius:5.0f];
    commitBtn.center = CGPointMake(commitBtn.center.x, _bottomView.h / 2);
    [commitBtn addTarget:self action:@selector(commitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:commitBtn];
    [self.view addSubview:_bottomView];
}

#pragma mark - 提交
- (void)commitBtnClicked:(UIButton *)btn {
    NSLog(@"提交密码");
    [self.view endEditing:YES];
    
    XDLoginCell *cellPass = [_forgotTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    NSString *pass = cellPass.textField.text;
    XDLoginCell *cellPassAgain = [_forgotTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    NSString *passAgain = cellPassAgain.textField.text;
    
    if (![_forgotModel.mobilePhone isMobilePhoneNum]) {
        [_showErrorMess setText:@"  手机号码不正确"];
    }else if (!_showPassword && ![pass isEqualToString:passAgain]) {
        [_showErrorMess setText:@"  两次输入密码不相同"];
    }else if (![pass isValidatePassword]) {
        [_showErrorMess setText:@"  密码格式不正确，请输入6-16位数字和字母组合密码"];
    }else if ([_forgotModel.valcode isBlankString]) {
        [_showErrorMess setText:@"  未填写验证码"];
    }else {
        //可以提交
        [_showErrorMess setText:@""];
        
        _forgotModel.userPassword = pass;
        
        mWeakSelf
        [[XDDNetworking shareNetworking] findPasswordModel:_forgotModel successBlock:^(NSDictionary * _Nonnull successDic) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [XTProgressHUD showText:@"密码修改成功" atView:mKeyWindow];
                [weakSelf.navigationController popViewControllerAnimated:YES];
                
            });
            
        } failBlock:^(NSDictionary * _Nonnull failDic) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *errDesc = @"密码修改失败";
                if (failDic[HTTP_RESULT_DESC]) {
                    errDesc = [NSString stringWithFormat:@"%@",failDic[HTTP_RESULT_DESC]];
                }
                [XTProgressHUD showText:errDesc atView:mKeyWindow];
                
            });
        }];
    }
    
}

#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XDLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:forgotCellID];
    
    cell.leftImageView.image = [UIImage imageNamed:leftImageArr[indexPath.row]];
    cell.textField.placeholder = placeholderArr[indexPath.row];
    cell.textField.delegate = self;
    cell.textField.tag = 100 + indexPath.row;
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

//发送验证码
- (void)SendCodeBtnClicked:(UIButton *)btn {
    [self.view endEditing:YES];
    
    if (!_forgotModel.mobilePhone || ![_forgotModel.mobilePhone isMobilePhoneNum]) {
        [_showErrorMess setText:@"  手机号码不正确"];
    }else {
        [_showErrorMess setText:@""];
        NSLog(@"发送短信验证码");
        
        [[XDDNetworking shareNetworking] sendSMSPhone:_forgotModel.mobilePhone type:SMSTypeForgotPass successBlock:^(NSDictionary * _Nonnull successDic) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [XTProgressHUD showText:@"验证码发送成功" atView:mKeyWindow];
            });
            
        } failBlock:^(NSDictionary * _Nonnull failDic) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *errDesc = @"验证码发送失败";
                if (failDic[HTTP_RESULT_DESC]) {
                    errDesc = [NSString stringWithFormat:@"%@",failDic[HTTP_RESULT_DESC]];
                }
                [XTProgressHUD showText:errDesc atView:mKeyWindow];
            });
            
        }];
        
    }
}

//显示\隐藏密码
- (void)eyeBtnClicked:(UIButton *)btn {
    NSLog(@"显示、隐藏密码");
    
    XDLoginCell *passwordCell = [_forgotTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    XDLoginCell *againPassCell = [_forgotTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
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
        _showErrorMess.text = @"";
        _showErrorMess.transform = CGAffineTransformMakeTranslation(0, -180*m6PScale);
        _bottomView.transform = CGAffineTransformMakeTranslation(0, -180*m6PScale);
    }
    
}

#pragma mark - textField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    switch (textField.tag) {
        case 100:
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
        case 100:
        {
            if (![textField.text isMobilePhoneNum]) {
                [_showErrorMess setText:@"  手机号码不正确"];
            }else {
                [_showErrorMess setText:@""];
            }
            XDLoginCell *VCodeCell = [_forgotTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            [VCodeCell.textField becomeFirstResponder];
        }
            break;
        case 101:
        {
            XDLoginCell *passCell = [_forgotTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            [passCell.textField becomeFirstResponder];
        }
            break;
        case 102:
        {
            if (![textField.text isValidatePassword]) {
                [_showErrorMess setText:@"  密码格式不正确，请输入6-16位数字和字母组合密码"];
            }else {
                [_showErrorMess setText:@""];
            }
            if (_showPassword) {
                
            }else {
                XDLoginCell *passAgainCell = [_forgotTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
                [passAgainCell.textField becomeFirstResponder];
            }
            
        }
            break;
        case 103:
        {
            XDLoginCell *passCell = [_forgotTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
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
        case 100:
        {
            _forgotModel.mobilePhone = textField.text;
        }
            break;
        case 101:
        {
            _forgotModel.valcode = textField.text;
        }
            break;
        case 102:
        {
            
        }
            break;
        case 103:
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
