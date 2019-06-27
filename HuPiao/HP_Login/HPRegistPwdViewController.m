//
//  HPRegistPwdViewController.m
//  HuPiao
//
//  Created by a on 2019/6/20.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HPRegistPwdViewController.h"

@interface HPRegistPwdViewController () <UITextFieldDelegate>

@property (nonatomic , strong) UILabel * pwLabel;

@property (nonatomic , strong) UITextField * pwTF;

@property (nonatomic , strong) UILabel * pwAgainLabel;

@property (nonatomic , strong) UITextField * pwAgainTF;

@property (nonatomic , strong) UIButton * registBtn;

@property (nonatomic , assign) BOOL pwTFEmpty;

@property (nonatomic , assign) BOOL pwAgainTFEmpty;

@end

@implementation HPRegistPwdViewController

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

    self.title = self.registOrForgotPwd;
    
    self.pwTFEmpty = YES;
    self.pwAgainTFEmpty = YES;

    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSForegroundColorAttributeName] = HPUIColorWithRGB(0xffffff,1.0);
    attrDict[NSFontAttributeName] = HPFontSize(18);
    
    self.navigationController.navigationBar.titleTextAttributes = attrDict;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [UIView getGradientWithFirstColor:HPUIColorWithRGB(0xA2B5CD, 1.0) SecondColor:HPUIColorWithRGB(0x66CDAA, 1.0) WithView:self.view];
    
    [self configUI];
    
    [self setupRightNav];
}

- (void)setRegistOrForgotPwd:(NSString *)registOrForgotPwd {
    _registOrForgotPwd = registOrForgotPwd;
}


- (void) setupRightNav {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"leftbackicon_white_titlebar_24x24_" highImage:@"leftbackicon_white_titlebar_night_24x24_" isLeftBtn:YES];
}
- (void) back {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 注册Action
- (void) registAcion:(UIButton *)sender {
    self.registBtn.backgroundColor = HPUIColorWithRGB(0x96CDCD, 1.0);

    if (self.pwTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请先填写密码"];
        return;
    }
    if (self.pwAgainTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请先填写确认密码"];
        return;
    }
}
-(void) registDown:(UIButton *)sender {
    self.registBtn.backgroundColor = HPUIColorWithRGB(0x000000, 0.5);
}

- (void) configUI {
    __weak typeof (self) weakSelf = self;

    [self.view addSubview: self.pwLabel];
    [self.view addSubview: self.pwTF];
    [self.view addSubview: self.pwAgainLabel];
    [self.view addSubview: self.pwAgainTF];
    [self.view addSubview: self.registBtn];
    
    [self.pwLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.view.height/5);
        make.left.mas_equalTo (weakSelf.view.mas_left).offset(HPFit(30));
        make.right.mas_equalTo (weakSelf.view.mas_right).offset(-HPFit(30));
        make.height.mas_equalTo (HPFit(40));
    }];
    
    [self.pwTF mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.pwLabel.mas_bottom).offset (HPFit(10));
        make.left.right.height.mas_equalTo (weakSelf.pwLabel);
    }];
    
    [self.pwAgainLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.pwTF.mas_bottom).offset (HPFit(30));
        make.left.right.height.mas_equalTo (weakSelf.pwLabel);
    }];
    
    [self.pwAgainTF mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.pwAgainLabel.mas_bottom).offset (HPFit(10));
        make.left.right.height.mas_equalTo (weakSelf.pwLabel);
    }];
    
    [self.registBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.pwAgainTF.mas_bottom).offset (HPFit(70));
        make.height.left.right.mas_equalTo (weakSelf.pwLabel);
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.pwTF borderForColor:HPUIColorWithRGB(0xffffff, 1.0) borderWidth:1 borderType:UIBorderSideTypeBottom];
    [self.pwAgainTF borderForColor:HPUIColorWithRGB(0xffffff, 1.0) borderWidth:1 borderType:UIBorderSideTypeBottom];
}

- (UILabel *)pwLabel {
    if (!_pwLabel) {
        _pwLabel = [UILabel new];
        _pwLabel.text = @"密     码";
        _pwLabel.font = HPFontBoldSize(20);
        _pwLabel.textColor = HPUIColorWithRGB(0xffffff, 1.0);
    }
    return _pwLabel;
}

- (UITextField *)pwTF {
    if (!_pwTF) {
        _pwTF = [UITextField new];
        _pwTF.font = [UIFont systemFontOfSize:14];
        _pwTF.backgroundColor = [UIColor clearColor];
        _pwTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, CGRectGetWidth(_pwTF.frame))];
        _pwTF.leftViewMode = UITextFieldViewModeAlways;
        _pwTF.textColor = [UIColor whiteColor];
        _pwTF.secureTextEntry = YES;
        _pwTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _pwTF.delegate = self;
        [_pwTF addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventAllEditingEvents];
    }
    return _pwTF;
}

- (UILabel *)pwAgainLabel {
    if (!_pwAgainLabel) {
        _pwAgainLabel = [UILabel new];
        _pwAgainLabel.text = @"昵    称";
        _pwAgainLabel.font = _pwLabel.font;
        _pwAgainLabel.textColor = _pwLabel.textColor;
    }
    return _pwAgainLabel;
}

- (UITextField *)pwAgainTF{
    if (!_pwAgainTF) {
        _pwAgainTF = [UITextField new];
        _pwAgainTF.font = [UIFont systemFontOfSize:14];
        _pwAgainTF.backgroundColor = [UIColor clearColor];
        _pwAgainTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, CGRectGetWidth(_pwTF.frame))];
        _pwAgainTF.leftViewMode = UITextFieldViewModeAlways;
        _pwAgainTF.textColor = [UIColor whiteColor];
        _pwAgainTF.secureTextEntry = YES;
        _pwAgainTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _pwAgainTF.delegate = self;
        [_pwAgainTF addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventAllEditingEvents];
    }
    return _pwAgainTF;
}

- (UIButton *)registBtn {
    if (!_registBtn) {
        _registBtn = [UIButton new];
        _registBtn.layer.cornerRadius = 5.0f;
        _registBtn.layer.borderColor = kSetUpCololor(195, 195, 195, 1.0).CGColor;
        _registBtn.layer.borderWidth = 1.0f;
        _registBtn.backgroundColor = kSetUpCololor(195, 195, 195, 1.0);
        [_registBtn setTitle:@"立即注册" forState:UIControlStateNormal];
        [_registBtn addTarget:self action:@selector(registAcion:) forControlEvents:UIControlEventTouchUpInside];
        [_registBtn addTarget:self action:@selector(registDown:) forControlEvents:UIControlEventTouchDown];
        [_registBtn setTitleColor:kSetUpCololor(225, 225, 225, 1.0) forState:UIControlStateNormal];
        _registBtn.userInteractionEnabled = NO;
    }
    return _registBtn;
}

#pragma mark -给每个cell中的textfield添加事件，只要值改变就调用此函数
- (void)changedTextField:(UITextField *)textField {
    //    NSLog(@"值是---%@",textField.text);
    
    if (self.pwTF == textField) {
        NSLog(@"密码");
        self.pwTFEmpty = self.pwTF.text.length > 0 ? NO : YES;
    }
    if (self.pwAgainTF == textField) {
        NSLog(@"昵称");
        self.pwAgainTFEmpty = self.pwAgainTF.text.length > 0 ? NO : YES;
    }
    
    [self tfChanged];
}

- (void) tfChanged {
    self.registBtn.userInteractionEnabled = self.pwTFEmpty == NO && self.pwAgainTFEmpty == NO  ? YES : NO;
    self.registBtn.backgroundColor = self.pwTFEmpty == NO && self.pwAgainTFEmpty == NO ? HPUIColorWithRGB(0x96CDCD, 1.0) : kSetUpCololor(195, 195, 195, 1.0);
    self.registBtn.layer.borderColor = self.pwTFEmpty == NO && self.pwAgainTFEmpty == NO ? HPUIColorWithRGB(0xffffff, 1.0).CGColor : kSetUpCololor(195, 195, 195, 1.0).CGColor;
    [self.registBtn setTitleColor:self.pwTFEmpty == NO && self.pwAgainTFEmpty == NO ? HPUIColorWithRGB(0xffffff, 1.0) : kSetUpCololor(225, 225, 225, 1.0) forState:UIControlStateNormal];
}

#pragma mark textfield的代理
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //敲删除键
    if ([string length] == 0) {
        return YES;
    }
    
    if (self.pwTF == textField ) {
        if (textField.text.length > 8) return NO;   // 当前是密码
    }
    if (self.pwAgainTF == textField) {
        if (textField.text.length > 6) return NO;   // 当前是昵称
    }
    
    return YES;
}

@end
