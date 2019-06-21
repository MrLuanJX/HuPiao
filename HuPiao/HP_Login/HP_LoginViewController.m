//
//  HP_LoginViewController.m
//  HuPiao
//
//  Created by a on 2019/6/20.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_LoginViewController.h"
#import "HP_RegistViewController.h"

@interface HP_LoginViewController () <UITextFieldDelegate>

@property (nonatomic , strong) UILabel * nameLabel;

@property (nonatomic , strong) UITextField * nameTF;

@property (nonatomic , strong) UILabel * pwLabel;

@property (nonatomic , strong) UITextField * pwTF;

@property (nonatomic , strong) UIButton * loginBtn;

@property (nonatomic , strong) UIButton * registBtn;

@property (nonatomic , strong) UIButton * forgetBtn;

@property (nonatomic , assign) BOOL phoneTFEmpty;
@property (nonatomic , assign) BOOL pwTFEmpty;

@end

@implementation HP_LoginViewController

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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    
    self.phoneTFEmpty = YES;
    self.pwTFEmpty = YES;
    
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSForegroundColorAttributeName] = HPUIColorWithRGB(0xffffff,1.0);
    attrDict[NSFontAttributeName] = HPFontSize(18);
    
    self.navigationController.navigationBar.titleTextAttributes = attrDict;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [UIView getGradientWithFirstColor:HPUIColorWithRGB(0xA2B5CD, 1.0) SecondColor:HPUIColorWithRGB(0x66CDAA, 1.0) WithView:self.view];
    
    [self configUI];
}

#pragma mark - 注册Action
- (void) registAction {
    NSLog(@"注册");
    [self jumpRegistOrForgotPwdVCWithTitle:@"注    册"];
}

#pragma mark - 忘记密码
- (void) forgetAction {
    NSLog(@"忘记密码");
    [self jumpRegistOrForgotPwdVCWithTitle:@"忘记密码"];
}

#pragma mark - 登录Action
- (void) loginAcion:(UIButton *)sender {
    self.loginBtn.backgroundColor = HPUIColorWithRGB(0x96CDCD, 1.0);
    
    if (self.nameTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请先填写用户名"];
        return;
    }
    if (self.pwTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请先填写密码"];
        return;
    }
}
-(void) loginDown:(UIButton *)sender {
    self.loginBtn.backgroundColor = HPUIColorWithRGB(0x000000, 0.5);
}

- (void) configUI {
    __weak typeof (self) weakSelf = self;
    
    [self.view addSubview: self.nameLabel];
    [self.view addSubview: self.nameTF];
    [self.view addSubview: self.pwLabel];
    [self.view addSubview: self.pwTF];
    [self.view addSubview: self.loginBtn];
    [self.view addSubview: self.forgetBtn];
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
    
    [self.pwLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.nameTF.mas_bottom).offset(HPFit(30));
        make.left.right.height.mas_equalTo (weakSelf.nameLabel);
    }];
    
    [self.pwTF mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.pwLabel.mas_bottom).offset (HPFit(10));
        make.left.right.height.mas_equalTo (weakSelf.nameTF);
    }];
    
    [self.forgetBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.pwTF.mas_bottom).offset (HPFit(10));
        make.height.left.mas_equalTo (weakSelf.nameLabel);
        make.width.mas_equalTo (weakSelf.nameLabel.mas_width).multipliedBy(0.5);
    }];
    
    [self.registBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.pwTF.mas_bottom).offset (HPFit(10));
        make.height.right.mas_equalTo (weakSelf.nameLabel);
        make.width.mas_equalTo (weakSelf.nameLabel.mas_width).multipliedBy(0.5);
    }];
    
    [self.loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.forgetBtn.mas_bottom).offset (HPFit(50));
        make.height.left.right.mas_equalTo (weakSelf.nameLabel);
    }];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.nameTF borderForColor:HPUIColorWithRGB(0xffffff, 1.0) borderWidth:1 borderType:UIBorderSideTypeBottom];
    [self.pwTF borderForColor:HPUIColorWithRGB(0xffffff, 1.0) borderWidth:1 borderType:UIBorderSideTypeBottom];
//    [self.loginBtn setBorderWithCornerRadius:5.0 borderWidth:1 borderColor:kSetUpCololor(195, 195, 195, 1.0) type:UIRectCornerAllCorners];
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
        _nameTF.font = [UIFont systemFontOfSize:14];
        _nameTF.backgroundColor = [UIColor clearColor];
        _nameTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, CGRectGetWidth(_nameTF.frame))];
        _nameTF.leftViewMode = UITextFieldViewModeAlways;
        _nameTF.keyboardType = UIKeyboardTypeNumberPad;
        _nameTF.textColor = [UIColor whiteColor];
        _nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nameTF.delegate = self;
        [_nameTF addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventAllEditingEvents];
    }
    return _nameTF;
}

- (UILabel *)pwLabel {
    if (!_pwLabel) {
        _pwLabel = [UILabel new];
        _pwLabel.text = @"密     码";
        _pwLabel.font = _nameLabel.font;
        _pwLabel.textColor = _nameLabel.textColor;
    }
    return _pwLabel;
}

- (UITextField *)pwTF {
    if (!_pwTF) {
        _pwTF = [UITextField new];
        _pwTF.font = self.nameTF.font;
        _pwTF.backgroundColor = [UIColor clearColor];
        _pwTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, CGRectGetWidth(_nameTF.frame))];
        _pwTF.leftViewMode = UITextFieldViewModeAlways;
        _pwTF.textColor = [UIColor whiteColor];
        _pwTF.secureTextEntry = YES;
        _pwTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _pwTF.delegate = self;
        [_pwTF addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventAllEditingEvents];
    }
    return _pwTF;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton new];
        _loginBtn.backgroundColor = kSetUpCololor(195, 195, 195, 1.0);
        [_loginBtn setTitle:@"登     录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:kSetUpCololor(242, 242, 242, 1.0) forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginAcion:) forControlEvents:UIControlEventTouchUpInside];
        [_loginBtn addTarget:self action:@selector(loginDown:) forControlEvents:UIControlEventTouchDown];
        _loginBtn.userInteractionEnabled = NO;
        _loginBtn.layer.borderColor = _loginBtn.backgroundColor.CGColor;
        _loginBtn.layer.cornerRadius = 5.0;
        _loginBtn.layer.borderWidth = 1.0;
    }
    return _loginBtn;
}

- (UIButton *)registBtn {
    if (!_registBtn) {
        _registBtn = [UIButton new];
        [_registBtn setTitle:@"注    册" forState:UIControlStateNormal];
        _registBtn.titleLabel.font = HPFontSize(16);
        [_registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registBtn setTitleColor:HPUIColorWithRGB(0x000000, 0.5) forState:UIControlStateHighlighted];
        [_registBtn addTarget:self action:@selector(registAction) forControlEvents:UIControlEventTouchUpInside];
        _registBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _registBtn;
}

- (UIButton *)forgetBtn {
    if (!_forgetBtn) {
        _forgetBtn = [UIButton new];
        _forgetBtn.titleLabel.font = self.registBtn.titleLabel.font;
        [_forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_forgetBtn setTitleColor:HPUIColorWithRGB(0x000000, 0.5) forState:UIControlStateHighlighted];
        [_forgetBtn addTarget:self action:@selector(forgetAction) forControlEvents:UIControlEventTouchUpInside];
        _forgetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _forgetBtn;
}

#pragma mark -给每个cell中的textfield添加事件，只要值改变就调用此函数
- (void)changedTextField:(UITextField *)textField {
    
    if (self.nameTF == textField) {
        NSLog(@"手机号");
        self.phoneTFEmpty = self.nameTF.text.length > 0 ? NO : YES;
    }
    
    if (self.pwTF == textField) {
        NSLog(@"密码");
        self.pwTFEmpty = self.pwTF.text.length > 0 ? NO : YES;
    }
    
    [self tfChanged];
}

- (void) tfChanged {
    self.loginBtn.userInteractionEnabled = self.phoneTFEmpty == NO && self.pwTFEmpty == NO ? YES : NO;
    self.loginBtn.backgroundColor = self.phoneTFEmpty == NO && self.pwTFEmpty == NO ? HPUIColorWithRGB(0x96CDCD, 1.0) : kSetUpCololor(195, 195, 195, 1.0);
    self.loginBtn.layer.borderColor = self.phoneTFEmpty == NO && self.pwTFEmpty == NO ? HPUIColorWithRGB(0xffffff, 1.0).CGColor : kSetUpCololor(195, 195, 195, 1.0).CGColor;
    [self.loginBtn setTitleColor:self.phoneTFEmpty == NO && self.pwTFEmpty == NO ? HPUIColorWithRGB(0xffffff, 1.0) : kSetUpCololor(225, 225, 225, 1.0) forState:UIControlStateNormal];
}

#pragma mark textfield的代理
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //敲删除键
    if ([string length] == 0) {
        return YES;
    }
    
    if (self.nameTF == textField) {
        if (textField.text.length > 10) return NO;  // 当前是手机号码
    } else if (self.pwTF == textField) {
        if (textField.text.length > 15) return NO;   // 当前是密码
    }
    
    return YES;
}

- (void) jumpRegistOrForgotPwdVCWithTitle:(NSString *)title {
    HP_RegistViewController * registVC = [HP_RegistViewController new];
    registVC.registOrForgotPwd = title;
    [self.navigationController pushViewController:registVC animated:YES];
}

@end
