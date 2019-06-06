//
//  HP_NormalOwnView.m
//  HuPiao
//
//  Created by a on 2019/6/5.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_NormalOwnView.h"

@interface HP_NormalOwnView ()

@property (nonatomic , strong) UIButton * iconBtn;

@property (nonatomic , strong) UITextField * nameTF;

@property (nonatomic , strong) UIButton * commitBtn;

@property (nonatomic , strong) UILabel * careLabel;

@end

@implementation HP_NormalOwnView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        [self createConstrainte];
    }
    return self;
}

- (void)setUser:(MUser *)user {
    _user = user;
    
    NSLog(@"setuser - %@",self.user);

    [self.iconBtn sd_setImageWithURL:[NSURL URLWithString:_user.portrait] forState:UIControlStateNormal placeholderImage:[UIImage imageWithColor:[UIColor greenColor]]];
    self.nameTF.text = _user.name;
}

- (void) createUI {
    [self addSubview: self.iconBtn];
    [self addSubview: self.nameTF];
    [self addSubview: self.commitBtn];
    [self addSubview: self.careLabel];
}

- (void) createConstrainte{
    WS(wSelf);
    [self.iconBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (wSelf.mas_centerY).multipliedBy(0.5);
        make.centerX.mas_equalTo (wSelf.mas_centerX);
        make.width.height.mas_equalTo (HPFit(100));
    }];
    
    [self.nameTF mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (wSelf.iconBtn.mas_bottom).offset (HPFit(30));
        make.left.mas_equalTo (HPFit(50));
        make.right.mas_equalTo (-HPFit(50));
        make.height.mas_equalTo (HPFit(40));
    }];
    
    [self.commitBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (wSelf.nameTF.mas_bottom).offset (HPFit(50));
        make.left.right.height.mas_equalTo (wSelf.nameTF);
    }];
    
    [self.careLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(wSelf.commitBtn.mas_bottom).offset (HPFit(20));
        make.left.right.height.mas_equalTo (wSelf.nameTF);
    }];
}

-(void)layoutSublayersOfLayer:(CALayer *)layer{
    [super layoutSublayersOfLayer:layer];
    
    [self.iconBtn setBorderWithCornerRadius:self.iconBtn.height/2 borderWidth:0 borderColor:[UIColor clearColor] type:UIRectCornerAllCorners];
    
    [self.nameTF borderForColor:HPUIColorWithRGB(0x999999, 0.5) borderWidth:0.5 borderType:UIBorderSideTypeBottom];
    
    [self.commitBtn setBorderWithCornerRadius:self.commitBtn.height/2 borderWidth:0 borderColor:[UIColor clearColor] type:UIRectCornerAllCorners];
}

- (UIButton *)iconBtn {
    if (!_iconBtn) {
        _iconBtn = [UIButton new];
        [_iconBtn addTarget:self action:@selector(iconAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _iconBtn;
}

- (UITextField *)nameTF {
    if (!_nameTF) {
        _nameTF = [UITextField new];
        _nameTF.textColor = HPUIColorWithRGB(0x333333, 1.0);
        _nameTF.font = HPFontSize(17);
        _nameTF.textAlignment = NSTextAlignmentCenter;
    }
    return _nameTF;
}

- (UIButton *)commitBtn {
    if (!_commitBtn) {
        _commitBtn = [UIButton new];
        [_commitBtn setTitle:@"提    交" forState:UIControlStateNormal];
        _commitBtn.backgroundColor = kSetUpCololor(61, 121, 253, 1.0);
        _commitBtn.titleLabel.font = HPFontSize(15);
        [_commitBtn addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
        [_commitBtn addTarget:self action:@selector(commitDown:) forControlEvents:UIControlEventTouchDown];

    }
    return _commitBtn;
}

- (UILabel *)careLabel {
    if (!_careLabel) {
        _careLabel = [UILabel new];
        _careLabel.text = @"严禁上传违反国家法律法规内容";
        _careLabel.textColor = HPUIColorWithRGB(0xFF0000, 1.0);
        _careLabel.font = HPFontSize(13);
        _careLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _careLabel;
}

// 头像
- (void) iconAction: (UIButton *) sender{
    if (self.iconClickBlock) {
        self.iconClickBlock();
    }
}

- (void) commitAction: (UIButton *) sender{
    if (self.commitClickBlock) {
        self.commitClickBlock();
    }
    sender.backgroundColor = kSetUpCololor(61, 121, 253, 1.0);
}
- (void) commitDown: (UIButton *) sender{
    sender.backgroundColor = HPUIColorWithRGB(0x4D4D4D, 0.8);
}


@end
