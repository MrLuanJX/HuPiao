//
//  HP_WalletHeadView.m
//  HuPiao
//
//  Created by a on 2019/6/10.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_WalletHeadView.h"

@interface HP_WalletHeadView()

@property (nonatomic , strong) UIImageView * bgView;

@property (nonatomic , strong) UILabel * moneyLabel;

@property (nonatomic , strong) UILabel * titleLabel;

@end

@implementation HP_WalletHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}

- (void) setupUI {
    WS(wSelf);
    [self addSubview: self.bgView];
    [self addSubview: self.moneyLabel];
    [self addSubview: self.titleLabel];
    
    [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo (0);
    }];
    
    [self.moneyLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (wSelf.mas_centerY).offset (-HPFit(30));
        make.left.right.mas_equalTo (0);
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (wSelf.moneyLabel.mas_bottom).offset(HPFit(20));
        make.left.right.mas_equalTo (wSelf.moneyLabel);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [UIView getGradientWithFirstColor:HPUIColorWithRGB(0xA2B5CD, 1.0) SecondColor:HPUIColorWithRGB(0x66CDAA, 1.0) WithView:self.bgView];
}

- (UIImageView *)bgView {
    if (!_bgView) {
        _bgView = [UIImageView new];
        [_bgView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageWithColor:[UIColor redColor]]];
    }
    return _bgView;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [UILabel new];
        _moneyLabel.textColor = [UIColor whiteColor];
        _moneyLabel.font = HPFontBoldSize(40);
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        _moneyLabel.text = @"1000";
    }
    return _moneyLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = HPFontSize(16);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"我的H币";
    }
    return _titleLabel;
}

@end
