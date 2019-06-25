//
//  HP_SignViewController.m
//  HuPiao
//
//  Created by a on 2019/6/6.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_SignViewController.h"

//static int maxLength = 100;

@interface HP_SignViewController () <UITextViewDelegate>

@property (nonatomic , strong) UITextView * FKTextView;
@property (nonatomic , strong) UILabel * descLab;
@property (nonatomic , strong) UIButton * sendBtn;
@property (nonatomic , strong) UILabel * stringlenghtLab;

@end

@implementation HP_SignViewController

- (void)setMaxLength:(int)maxLength {
    _maxLength = maxLength;
}

- (void)setSendBtnTitle:(NSString *)sendBtnTitle {
    _sendBtnTitle = sendBtnTitle;
    
    [self.sendBtn setTitle:sendBtnTitle forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
       
    [self configUI];
    self.descLab.userInteractionEnabled = NO;
    self.sendBtn.userInteractionEnabled = NO;
    self.sendBtn.backgroundColor = [UIColor lightGrayColor];
}

- (void) feedbackAction {
    NSLog(@"保存");
    self.sendBtn.backgroundColor = kSetUpCololor(61, 121, 253, 1.0);
    
    if ([self.title isEqualToString:@"个性签名"]) {
        if (self.signBlock) {
            self.signBlock(self.FKTextView.text);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void) feedbackDown {
    self.sendBtn.backgroundColor = HPUIColorWithRGB(0x4D4D4D, 0.8);
}

-(void)textViewDidChange:(UITextView *)textView{
    self.descLab.hidden = YES;
    self.sendBtn.userInteractionEnabled = YES;
    self.sendBtn.backgroundColor = kSetUpCololor(61, 121, 253, 1.0);

    //字数限制
    if (textView.text.length >= self.maxLength) {
        textView.text = [textView.text substringToIndex:self.maxLength];
    }
    
    //实时显示字数
    self.stringlenghtLab.text = [NSString stringWithFormat:@"%ld/%d",(long)textView.text.length,self.maxLength];
    
    //取消按钮点击权限，并显示文字
    if (textView.text.length == 0) {
        self.descLab.hidden = NO;
        self.sendBtn.userInteractionEnabled = NO;
        self.sendBtn.backgroundColor = [UIColor lightGrayColor];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        
        [self.FKTextView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
}

- (void) configUI {
    __weak typeof (self) weakSelf = self;
    
    [self.view addSubview: self.FKTextView];
    [self.FKTextView addSubview:self.descLab];
    [self.view addSubview: self.sendBtn];
    [self.view addSubview: self.stringlenghtLab];
    
    [self.FKTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HPFit(114));
        make.left.mas_equalTo(HPFit(20));
        make.right.mas_equalTo(-HPFit(20));
        make.height.mas_equalTo(HPFit(200));
    }];
    
    [self.descLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(HPFit(7));
        make.right.mas_equalTo(weakSelf.FKTextView);
        make.height.mas_equalTo(HPFit(20));
    }];
    
    [self.stringlenghtLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.FKTextView.mas_bottom);
        make.right.mas_equalTo (weakSelf.FKTextView.mas_right);
        make.height.mas_equalTo (HPFit(20));
    }];
    
    [self.sendBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.stringlenghtLab.mas_bottom).offset (HPFit(50));
        make.left.right.mas_equalTo (weakSelf.FKTextView);
        make.height.mas_equalTo (HPFit(40));
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.FKTextView setBorderWithCornerRadius:8.0 borderWidth:1 borderColor:HPUIColorWithRGB(0x999999, 1.0) type:UIRectCornerAllCorners];
    [self.sendBtn setBorderWithCornerRadius:8.0 borderWidth:0 borderColor:HPClearColor type:UIRectCornerAllCorners];
}

- (UITextView *)FKTextView {
    if (!_FKTextView) {
        _FKTextView = [UITextView new];
        _FKTextView.backgroundColor = [UIColor whiteColor];
        _FKTextView.font = HPFontSize(14);
        _FKTextView.delegate = self;
    }
    return _FKTextView;
}

- (UILabel *)descLab {
    if (!_descLab) {
        _descLab = [UILabel new];
        _descLab.text = @"请输入内容";
        _descLab.font = HPFontSize(14);
        _descLab.textColor = HPUIColorWithRGB(0xC1C1C1, 1.0);
    }
    return _descLab;
}

- (UILabel *)stringlenghtLab {
    if (!_stringlenghtLab) {
        _stringlenghtLab = [UILabel new];
        _stringlenghtLab.font = HPFontSize(13);
        _stringlenghtLab.textColor = [UIColor lightGrayColor];
        _stringlenghtLab.textAlignment = NSTextAlignmentRight;
        _stringlenghtLab.text = [NSString stringWithFormat:@"0/%d",self.maxLength];
    }
    return _stringlenghtLab;
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
