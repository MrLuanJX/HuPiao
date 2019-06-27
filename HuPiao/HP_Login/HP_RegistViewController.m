//
//  HP_RegistViewController.m
//  HuPiao
//
//  Created by a on 2019/6/20.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_RegistViewController.h"
#import "HPRegistPwdViewController.h"
#import "DJZJ_RequestTool.h"

@interface HP_RegistViewController () <UITextFieldDelegate>

@property (nonatomic , strong) UILabel * nameLabel;

@property (nonatomic , strong) UITextField * nameTF;

@property (nonatomic , strong) UILabel * codeLabel;

@property (nonatomic , strong) UITextField * codeTF;

@property (nonatomic , strong) UIButton * codeBtn;

@property (nonatomic , strong) UIButton * registBtn;

@property (nonatomic , assign) BOOL phoneTFEmpty;
@property (nonatomic , assign) BOOL codeTFEmpty;

@end

@implementation HP_RegistViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //设置导航栏背景图片为一个无图的image，导航栏会加载空imgae，就自然透明掉了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];

    //同理透明掉导航栏下划线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //设置导航栏背景图片为一个无图的image，导航栏会加载空imgae，就自然透明掉了
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    //同理透明掉导航栏下划线
    [self.navigationController.navigationBar setShadowImage:nil];
    
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注    册";;
        
    self.phoneTFEmpty = YES;
    self.codeTFEmpty = YES;
    
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSForegroundColorAttributeName] = HPUIColorWithRGB(0xffffff,1.0);
    attrDict[NSFontAttributeName] = HPFontSize(18);
    
    self.navigationController.navigationBar.titleTextAttributes = attrDict;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [UIView getGradientWithFirstColor:HPUIColorWithRGB(0xA2B5CD, 1.0) SecondColor:HPUIColorWithRGB(0x66CDAA, 1.0) WithView:self.view];
    
    [self configUI];
    
    [self setupRightNav];
}

- (void) requestCode {
    NSDictionary * dict = @{
                            @"phoneNumber" : @"18910795322",//self.nameTF.text,
                            @"type" : @"register",
                            @"t" : [HPDivisableTool currentdateInterval],
                            @"code" : @"",
                            @"sign" : [NSString md5:[NSString stringWithFormat:@"%@%@%@%@%@%@",@"code",@"phoneNumber",@"sign",@"t",@"type",HPKey]],
                            };
    NSLog(@"md5 =--- %@",[NSString stringWithFormat:@"%@%@%@%@%@%@",@"code",@"phoneNumber",@"sign",@"t",@"type",HPKey]);

//    [DJZJ_RequestTool LJX_requestWithType:LJX_POST URL:HP_PhoneCode params:dict successBlock:^(id obj) {
//
//        NSLog(@"obj = %@",obj);
//
//    } failureBlock:^(NSError *error) {
//
//        NSLog(@"error = %@",error);
//
//    }];
//
    [HP_MemberHandler executeGetCode:dict Success:^(id  _Nonnull obj) {
        NSLog(@"obj ==== %@",obj);

    } Fail:^(id  _Nonnull obj) {

    }];
}

#pragma mark -返回键
- (void) setupRightNav {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"leftbackicon_white_titlebar_24x24_" highImage:@"leftbackicon_white_titlebar_night_24x24_" isLeftBtn:YES];
}
- (void) back {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 注册Action
- (void) registAcion:(UIButton *)sender {
    self.registBtn.backgroundColor = HPUIColorWithRGB(0x96CDCD, 1.0);
    
    if (self.nameTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请先填写用户名"];
        return;
    }
    if (self.codeTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请先填写验证码"];
        return;
    }
    
    HPRegistPwdViewController * registPwdVC = [HPRegistPwdViewController new];
    registPwdVC.registOrForgotPwd = @"注     册";
    [self.navigationController pushViewController:registPwdVC animated:YES];
}
-(void) registDown:(UIButton *)sender {
    self.registBtn.backgroundColor = HPUIColorWithRGB(0x000000, 0.5);
}

#pragma mark - 验证码Action
- (void) codeAcion:(UIButton *)sender {
    [self requestCode];
    
    [self.view endEditing:YES];
    
    [self.codeBtn setTitleColor:HPUIColorWithRGB(0xffffff, 1.0) forState:UIControlStateNormal];
    
    [self.codeBtn startWithTime:60 title:@"获取验证码" countDownTitle:@"秒" mainColor:HPUIColorWithRGB(0xffffff, 1.0) countColor:kSetUpCololor(225, 225, 225, 1.0)];
}
-(void) codeDown:(UIButton *)sender {
    [self.codeBtn setTitleColor:HPUIColorWithRGB(0x96CDCD, 1.0) forState:UIControlStateNormal];
}

- (void) configUI {
    __weak typeof (self) weakSelf = self;
    
    [self.view addSubview: self.nameLabel];
    [self.view addSubview: self.nameTF];
    [self.view addSubview: self.codeLabel];
    [self.view addSubview: self.codeTF];
    [self.view addSubview: self.codeBtn];
    [self.view addSubview: self.registBtn];
    
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.view.height/5);
        make.left.mas_equalTo (weakSelf.view.mas_left).offset(HPFit(30));
        make.right.mas_equalTo (weakSelf.view.mas_right).offset(-HPFit(30));
        make.height.mas_equalTo (HPFit(40));
    }];
    
    [self.nameTF mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.nameLabel.mas_bottom).offset(HPFit(10));
        make.left.right.height.mas_equalTo(weakSelf.nameLabel);
    }];
    
    [self.codeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.nameTF.mas_bottom).offset(HPFit(30));
        make.left.right.height.mas_equalTo (weakSelf.nameLabel);
    }];
    
    [self.codeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.codeLabel.mas_bottom).offset (HPFit(10));
        make.right.height.mas_equalTo (weakSelf.nameTF);
        make.width.mas_equalTo (weakSelf.codeBtn.mas_height).multipliedBy(2);
    }];
    
    [self.codeTF mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.codeLabel.mas_bottom).offset (HPFit(10));
        make.left.height.mas_equalTo (weakSelf.nameTF);
        make.right.mas_equalTo (weakSelf.codeBtn.mas_left).offset (-HPFit(10));
    }];
    
    [self.registBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.codeTF.mas_bottom).offset (HPFit(70));
        make.height.left.right.mas_equalTo (weakSelf.nameLabel);
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.nameTF borderForColor:HPUIColorWithRGB(0xffffff, 1.0) borderWidth:1 borderType:UIBorderSideTypeBottom];
    [self.codeTF borderForColor:HPUIColorWithRGB(0xffffff, 1.0) borderWidth:1 borderType:UIBorderSideTypeBottom];
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.text = @"手机号";
        _nameLabel.font = HPFontBoldSize(20);
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}

- (UITextField *)nameTF {
    if (!_nameTF) {
        _nameTF = [UITextField new];
        _nameTF.font = HPFontSize(16);
        _nameTF.backgroundColor = [UIColor clearColor];
        _nameTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, CGRectGetWidth(_nameTF.frame))];
        _nameTF.leftViewMode = UITextFieldViewModeAlways;
        _nameTF.textColor = [UIColor whiteColor];
        _nameTF.keyboardType = UIKeyboardTypeNumberPad;
        _nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nameTF.delegate = self;
        [_nameTF addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventAllEditingEvents];
    }
    return _nameTF;
}

- (UILabel *)codeLabel {
    if (!_codeLabel) {
        _codeLabel = [UILabel new];
        _codeLabel.text = @"验 证 码";
        _codeLabel.font = _nameLabel.font;
        _codeLabel.textColor = _nameLabel.textColor;
    }
    return _codeLabel;
}

- (UITextField *)codeTF {
    if (!_codeTF) {
        _codeTF = [UITextField new];
        _codeTF.font = self.nameTF.font;
        _codeTF.backgroundColor = [UIColor clearColor];
        _codeTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, CGRectGetWidth(_nameTF.frame))];
        _codeTF.leftViewMode = UITextFieldViewModeAlways;
        _codeTF.textColor = [UIColor whiteColor];
        _codeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _codeTF.keyboardType = UIKeyboardTypeNumberPad;
        _codeTF.delegate = self;
        [_codeTF addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventAllEditingEvents];
    }
    return _codeTF;
}

- (UIButton *)registBtn {
    if (!_registBtn) {
        _registBtn = [UIButton new];
        _registBtn.layer.cornerRadius = 5.0f;
        _registBtn.layer.borderColor = kSetUpCololor(195, 195, 195, 1.0).CGColor;
        _registBtn.layer.borderWidth = 1.0f;
        _registBtn.backgroundColor = kSetUpCololor(195, 195, 195, 1.0);//HPUIColorWithRGB(0x96CDCD, 1.0);
        [_registBtn setTitle:@"下 一 步" forState:UIControlStateNormal];
        [_registBtn addTarget:self action:@selector(registAcion:) forControlEvents:UIControlEventTouchUpInside];
        [_registBtn addTarget:self action:@selector(registDown:) forControlEvents:UIControlEventTouchDown];
        [_registBtn setTitleColor:kSetUpCololor(225, 225, 225, 1.0) forState:UIControlStateNormal];
        _registBtn.userInteractionEnabled = NO;
    }
    return _registBtn;
}

- (UIButton *)codeBtn {
    if (!_codeBtn) {
        _codeBtn = [UIButton new];
        _codeBtn.titleLabel.font = HPFontSize(13);
        _codeBtn.userInteractionEnabled = NO;
        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _codeBtn.layer.cornerRadius = 5.0;
        _codeBtn.layer.borderColor = kSetUpCololor(225, 225, 225, 1.0).CGColor;
        _codeBtn.layer.borderWidth = 1.0;
        [_codeBtn setTitleColor:kSetUpCololor(225, 225, 225, 1.0) forState:UIControlStateNormal];
        [_codeBtn addTarget:self action:@selector(codeAcion:) forControlEvents:UIControlEventTouchUpInside];
        [_codeBtn addTarget:self action:@selector(codeDown:) forControlEvents:UIControlEventTouchDown];
    }
    return _codeBtn;
}

#pragma mark -给每个cell中的textfield添加事件，只要值改变就调用此函数
- (void)changedTextField:(UITextField *)textField {
//    NSLog(@"值是---%@",textField.text);

    if (self.nameTF == textField) {
        NSLog(@"手机号");
        [self.codeBtn setTitleColor:self.nameTF.text.length == 11 ? HPUIColorWithRGB(0xffffff, 1.0) : kSetUpCololor(225, 225, 225, 1.0) forState:UIControlStateNormal];
        self.codeBtn.layer.borderColor = self.nameTF.text.length == 11 ? HPUIColorWithRGB(0xffffff, 1.0).CGColor : kSetUpCololor(225, 225, 225, 1.0).CGColor;
        self.codeBtn.userInteractionEnabled = self.nameTF.text.length == 11 ? YES : NO;
        self.phoneTFEmpty = self.nameTF.text.length == 11 ? NO : YES;
    }
    if (self.codeTF == textField) {
        NSLog(@"验证码");
        self.codeTFEmpty = self.codeTF.text.length == 6 ? NO : YES;
    }
    
    [self tfChanged];
}

- (void) tfChanged {
    // && self.pwTFEmpty == NO
    self.registBtn.userInteractionEnabled = self.phoneTFEmpty == NO && self.codeTFEmpty == NO  ? YES : NO;
    self.registBtn.backgroundColor = self.phoneTFEmpty == NO && self.codeTFEmpty == NO ? HPUIColorWithRGB(0x96CDCD, 1.0) : kSetUpCololor(195, 195, 195, 1.0);
    self.registBtn.layer.borderColor = self.phoneTFEmpty == NO && self.codeTFEmpty == NO ? HPUIColorWithRGB(0xffffff, 1.0).CGColor : kSetUpCololor(195, 195, 195, 1.0).CGColor;
    [self.registBtn setTitleColor:self.phoneTFEmpty == NO && self.codeTFEmpty == NO ? HPUIColorWithRGB(0xffffff, 1.0) : kSetUpCololor(225, 225, 225, 1.0) forState:UIControlStateNormal];
}


#pragma mark textfield的代理
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    //敲删除键
    if ([string length] == 0) {
        return YES;
    }

    if (self.nameTF == textField) {
        if (textField.text.length > 10) return NO;  // 当前是手机号码
    } else if (self.codeTF == textField) {
        if (textField.text.length > 5) return NO;   // 当前是验证码
    }

    return YES;
}

@end
