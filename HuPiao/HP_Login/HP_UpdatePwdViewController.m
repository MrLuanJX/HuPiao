//
//  HP_UpdatePwdViewController.m
//  HuPiao
//
//  Created by a on 2019/6/20.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_UpdatePwdViewController.h"

@interface HP_UpdatePwdViewController () <UITextFieldDelegate>

@property (nonatomic , strong) UILabel * pwOldLabel;

@property (nonatomic , strong) UITextField * pwOldTF;

@property (nonatomic , strong) UILabel * pwLabel;

@property (nonatomic , strong) UITextField * pwTF;

@property (nonatomic , strong) UILabel * pwAgainLabel;

@property (nonatomic , strong) UITextField * pwAgainTF;

@property (nonatomic , strong) UIButton * updateBtn;

@property (nonatomic , assign) BOOL pwOldTFEmpty;

@property (nonatomic , assign) BOOL pwTFEmpty;

@property (nonatomic , assign) BOOL pwAgainTFEmpty;

@end

@implementation HP_UpdatePwdViewController

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
    
    self.title = @"修改密码";
    
    self.pwOldTFEmpty = YES;
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

- (void) configUI {
    __weak typeof (self) weakSelf = self;
    
    [self.view addSubview: self.pwOldLabel];
    [self.view addSubview: self.pwOldTF];
    [self.view addSubview: self.pwLabel];
    [self.view addSubview: self.pwTF];
    [self.view addSubview: self.pwAgainLabel];
    [self.view addSubview: self.pwAgainTF];
    [self.view addSubview: self.updateBtn];
    
    [self.pwOldLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.view.height/5);
        make.left.mas_equalTo (weakSelf.view.mas_left).offset(HPFit(30));
        make.right.mas_equalTo (weakSelf.view.mas_right).offset(-HPFit(30));
        make.height.mas_equalTo (HPFit(40));
    }];
    
    [self.pwOldTF mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.pwOldLabel.mas_bottom).offset (HPFit(10));
        make.left.right.height.mas_equalTo (weakSelf.pwOldLabel);
    }];
    
    [self.pwLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.pwOldTF.mas_bottom).offset (HPFit(30));
        make.left.right.height.mas_equalTo (weakSelf.pwOldLabel);
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
    
    [self.updateBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.pwAgainTF.mas_bottom).offset (HPFit(70));
        make.height.left.right.mas_equalTo (weakSelf.pwLabel);
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.pwOldTF borderForColor:HPUIColorWithRGB(0xffffff, 1.0) borderWidth:1 borderType:UIBorderSideTypeBottom];
    [self.pwTF borderForColor:HPUIColorWithRGB(0xffffff, 1.0) borderWidth:1 borderType:UIBorderSideTypeBottom];
    [self.pwAgainTF borderForColor:HPUIColorWithRGB(0xffffff, 1.0) borderWidth:1 borderType:UIBorderSideTypeBottom];
}

- (void) setupRightNav {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"leftbackicon_white_titlebar_24x24_" highImage:@"leftbackicon_white_titlebar_night_24x24_" isLeftBtn:YES];
}
- (void) back {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 修改密码Action
- (void) updateAcion:(UIButton *)sender {
    self.updateBtn.backgroundColor = HPUIColorWithRGB(0x96CDCD, 1.0);
    
    if (self.pwOldTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请先填写旧密码"];
        return;
    }
    if (self.pwTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请先填写新密码"];
        return;
    }
    if (self.pwAgainTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请先填写确认密码"];
        return;
    }
}
-(void) updateDown:(UIButton *)sender {
    self.updateBtn.backgroundColor = HPUIColorWithRGB(0x000000, 0.5);
}

- (UILabel *)pwOldLabel {
    if (!_pwOldLabel) {
        _pwOldLabel = [UILabel new];
        _pwOldLabel.text = @"旧 密 码";
        _pwOldLabel.font = [UIFont boldSystemFontOfSize:25];
        _pwOldLabel.textColor = HPUIColorWithRGB(0xffffff, 1.0);
    }
    return _pwOldLabel;
}

- (UITextField *)pwOldTF {
    if (!_pwOldTF) {
        _pwOldTF = [UITextField new];
        _pwOldTF.font = [UIFont systemFontOfSize:14];
        _pwOldTF.backgroundColor = [UIColor clearColor];
        _pwOldTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, CGRectGetWidth(_pwTF.frame))];
        _pwOldTF.leftViewMode = UITextFieldViewModeAlways;
        _pwOldTF.textColor = [UIColor whiteColor];
        _pwOldTF.secureTextEntry = YES;
        _pwOldTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _pwOldTF.delegate = self;
        [_pwOldTF addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventAllEditingEvents];
    }
    return _pwOldTF;
}


- (UILabel *)pwLabel {
    if (!_pwLabel) {
        _pwLabel = [UILabel new];
        _pwLabel.text = @"新 密 码";
        _pwLabel.font = [UIFont boldSystemFontOfSize:25];
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
        _pwAgainLabel.text = @"确认密码";
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

- (UIButton *)updateBtn {
    if (!_updateBtn) {
        _updateBtn = [UIButton new];
        _updateBtn.layer.cornerRadius = 5.0f;
        _updateBtn.layer.borderColor = kSetUpCololor(195, 195, 195, 1.0).CGColor;
        _updateBtn.layer.borderWidth = 1.0f;
        _updateBtn.backgroundColor = kSetUpCololor(195, 195, 195, 1.0);
        [_updateBtn setTitle:@"立即修改" forState:UIControlStateNormal];
        [_updateBtn addTarget:self action:@selector(updateAcion:) forControlEvents:UIControlEventTouchUpInside];
        [_updateBtn addTarget:self action:@selector(updateDown:) forControlEvents:UIControlEventTouchDown];
        [_updateBtn setTitleColor:kSetUpCololor(225, 225, 225, 1.0) forState:UIControlStateNormal];
        _updateBtn.userInteractionEnabled = NO;
    }
    return _updateBtn;
}

#pragma mark -给每个cell中的textfield添加事件，只要值改变就调用此函数
- (void)changedTextField:(UITextField *)textField {
    //    NSLog(@"值是---%@",textField.text);
    if (self.pwOldTF == textField) {
        NSLog(@"密码");
        self.pwOldTFEmpty = self.pwOldTF.text.length > 0 ? NO : YES;
    }
    if (self.pwTF == textField) {
        NSLog(@"密码");
        self.pwTFEmpty = self.pwTF.text.length > 0 ? NO : YES;
    }
    if (self.pwAgainTF == textField) {
        NSLog(@"确认密码");
        self.pwAgainTFEmpty = self.pwAgainTF.text.length > 0 ? NO : YES;
    }
    
    [self tfChanged];
}

- (void) tfChanged {
    self.updateBtn.userInteractionEnabled = self.pwTFEmpty == NO && self.pwAgainTFEmpty == NO && self.pwOldTFEmpty == NO ? YES : NO;
    self.updateBtn.backgroundColor = self.pwTFEmpty == NO && self.pwAgainTFEmpty == NO && self.pwOldTFEmpty == NO ? HPUIColorWithRGB(0x96CDCD, 1.0) : kSetUpCololor(195, 195, 195, 1.0);
    self.updateBtn.layer.borderColor = self.pwTFEmpty == NO && self.pwAgainTFEmpty == NO && self.pwOldTFEmpty == NO ? HPUIColorWithRGB(0xffffff, 1.0).CGColor : kSetUpCololor(195, 195, 195, 1.0).CGColor;
    [self.updateBtn setTitleColor:self.pwTFEmpty == NO && self.pwAgainTFEmpty == NO && self.pwOldTFEmpty == NO ? HPUIColorWithRGB(0xffffff, 1.0) : kSetUpCololor(225, 225, 225, 1.0) forState:UIControlStateNormal];
}

#pragma mark textfield的代理
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //敲删除键
    if ([string length] == 0) {
        return YES;
    }
    
    if (self.pwTF == textField || self.pwAgainTF == textField || self.pwOldTF == textField) {
        if (textField.text.length > 15) return NO;   // 当前是密码
    }
    
    return YES;
}

@end
