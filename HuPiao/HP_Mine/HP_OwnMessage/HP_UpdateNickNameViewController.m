//
//  HP_UpdateNickNameViewController.m
//  HuPiao
//
//  Created by a on 2019/6/6.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_UpdateNickNameViewController.h"

@interface HP_UpdateNickNameViewController () <UITextFieldDelegate>

@property (nonatomic , strong) UITextField * textField;

@property (nonatomic , strong) UIButton * sendBtn;

@end

@implementation HP_UpdateNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self addView];
    
    self.textField.text = self.user.name;
    self.sendBtn.backgroundColor = [UIColor lightGrayColor];
    self.sendBtn.userInteractionEnabled = NO;
}

- (void) feedbackAction {
    NSLog(@"保存");
    self.sendBtn.backgroundColor = kSetUpCololor(61, 121, 253, 1.0);
}

- (void) feedbackDown {
    self.sendBtn.backgroundColor = HPUIColorWithRGB(0x4D4D4D, 0.8);
}

#pragma mark -给每个cell中的textfield添加事件，只要值改变就调用此函数
-(void)changedTextField:(UITextField *)textField {
    if (![[textField.text trim] isEqualToString:self.user.name] || [textField.text trim].length == 0) {
        self.sendBtn.backgroundColor = kSetUpCololor(61, 121, 253, 1.0);
        self.sendBtn.userInteractionEnabled = YES;
    } else {
        self.sendBtn.backgroundColor = [UIColor lightGrayColor];
        self.sendBtn.userInteractionEnabled = NO;
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.textField setBorderWithCornerRadius:8.0 borderWidth:1 borderColor:HPUIColorWithRGB(0x999999, 1.0) type:UIRectCornerAllCorners];
    [self.sendBtn setBorderWithCornerRadius:8.0 borderWidth:0 borderColor:HPClearColor type:UIRectCornerAllCorners];
}

- (void) addView {
    WS(wSelf);
    
    [self.view addSubview: self.textField];
    [self.view addSubview: self.sendBtn];
    
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (HPFit(30) + k_top_height);
        make.left.mas_equalTo (HPFit(30));
        make.right.mas_equalTo (-HPFit(30));
        make.height.mas_equalTo (HPFit(40));
    }];
    
    [self.sendBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (wSelf.textField.mas_bottom).offset (HPFit(50));
        make.height.left.right.mas_equalTo (wSelf.textField);
    }];
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField new];
        _textField.delegate = self;
        _textField.font = HPFontSize(14);
        _textField.placeholder = @"请输入昵称";
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _textField.layer.borderWidth = 1.0f;
        _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, CGRectGetWidth(_textField.frame))];
        [_textField addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
        _textField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _textField;
}

- (UIButton *)sendBtn {
    if (!_sendBtn) {
        _sendBtn = [UIButton new];
        [_sendBtn setTitle:@"保  存" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendBtn addTarget:self action:@selector(feedbackDown) forControlEvents:UIControlEventTouchDown];
        [_sendBtn addTarget:self action:@selector(feedbackAction) forControlEvents:UIControlEventTouchUpInside];
        [_sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    }
    return _sendBtn;
}


@end
