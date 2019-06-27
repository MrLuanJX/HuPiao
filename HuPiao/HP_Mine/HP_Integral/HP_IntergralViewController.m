//
//  HP_IntergralViewController.m
//  HuPiao
//
//  Created by a on 2019/6/26.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_IntergralViewController.h"
#import "HP_IntergralHeadView.h"

@interface HP_IntergralViewController () <UIScrollViewDelegate>

@property (nonatomic , strong) UIScrollView * scrollView;

@property (nonatomic , strong) HP_IntergralHeadView * headView;

@property (nonatomic , strong) UILabel * vipView;

@property (nonatomic , strong) UIView * lineView;

@property (nonatomic , strong) UILabel * titleLabel;

@property (nonatomic , strong) UILabel * contentLabel;

@property (nonatomic , strong) UILabel * careLabel;

@property (nonatomic , strong) UIButton * intergralBtn;

@end

@implementation HP_IntergralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addScrollView];
}

- (void) addScrollView {
    WS(wSelf);
    
    [self.view addSubview: self.scrollView];
    
    [self.scrollView addSubview: self.headView];
    
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo (wSelf.view);
    }];
    
    [self createViews];
}

- (void) createViews {
    WS(wSelf);

    UIView * btnView = [UIView CreateViewWithFrame:CGRectMake(HPFit(30), CGRectGetMaxY(self.headView.frame) - HPFit(20), HPScreenW - HPFit(60), HPFit(60)) BackgroundColor:[UIColor whiteColor] InteractionEnabled:YES];
    [btnView setBorderWithCornerRadius:10 borderWidth:2 borderColor:HPUIColorWithRGB(0x333333, 1.0) type:UIRectCornerAllCorners];
    [self.scrollView addSubview: btnView];
    
    [btnView addSubview: self.vipView];
    
    [self.vipView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo (0);
    }];
    
    [self.scrollView addSubview: self.intergralBtn];
    [self.intergralBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (wSelf.vipView.mas_bottom).offset (HPFit(30));
        make.height.mas_equalTo (HPFit(40));
        make.width.mas_equalTo (HPFit(120));
        make.centerX.mas_equalTo (wSelf.vipView.mas_centerX);
    }];
    
    [self.scrollView addSubview: self.lineView];
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (btnView.mas_bottom).offset (HPFit(100));
        make.left.right.mas_equalTo (btnView);
        make.height.mas_equalTo (HPFit(1));
    }];

    [self.scrollView addSubview: self.titleLabel];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (wSelf.lineView.mas_bottom).offset (HPFit(20));
        make.left.right.mas_equalTo (wSelf.lineView);
        make.height.mas_equalTo (HPFit(30));
    }];
    
    [self.scrollView addSubview: self.contentLabel];
    [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (wSelf.titleLabel.mas_bottom).offset (HPFit(30));
        make.left.right.mas_equalTo (wSelf.lineView);
    }];
    
    [self.scrollView addSubview: self.careLabel];
    [self.careLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (wSelf.contentLabel.mas_bottom).offset (HPFit(20));
        make.left.right.mas_equalTo (wSelf.lineView);
    }];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = HPUIColorWithRGB(0xEDEDED, 1.0);
        _scrollView.contentSize = CGSizeMake(HPScreenW, HPScreenH);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (HP_IntergralHeadView *)headView {
    if (!_headView) {
        _headView = [[HP_IntergralHeadView alloc] initWithFrame:CGRectMake(0, 0, HPScreenW, HPFit(200))];
    }
    return _headView;
}

- (UILabel *)vipView {
    if (!_vipView) {
        _vipView = [UILabel new];
        _vipView.backgroundColor = [UIColor whiteColor];
        _vipView.font = HPFontSize(20);
        _vipView.textColor = HPUIColorWithRGB(0x333333, 1.0);
        _vipView.textAlignment = NSTextAlignmentCenter;
        _vipView.text = @"VIP专享每日签到可获20积分";
    }
    return _vipView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = HPUIColorWithRGB(0x999999, 1.0);
    }
    return _lineView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"积分获取";
        _titleLabel.font = HPFontBoldSize(20);
        _titleLabel.textColor = HPUIColorWithRGB(0x333333, 1.0);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.text = @"1.用户每储值1元RMB可获得1积分\n2.每日签到可获得10积分\n3.点赞可获得1积分（每日上限10f积分）\n4.VIP用户每日可额领取10积分";
        _contentLabel.font = HPFontSize(15);
        _contentLabel.textColor = HPUIColorWithRGB(0xB5B5B5, 1.0);
        _contentLabel.numberOfLines = 0;
        _contentLabel.preferredMaxLayoutWidth = HPScreenW - HPFit(60);
    }
    return _contentLabel;
}

- (UILabel *)careLabel {
    if (!_careLabel) {
        _careLabel = [UILabel new];
        _careLabel.text = @"*积分可用来为瓢儿虫送礼与私聊";
        _careLabel.font = HPFontSize(13);
        _careLabel.textColor = HPUIColorWithRGB(0xff0000, 1.0);
        _careLabel.numberOfLines = 0;
        _careLabel.preferredMaxLayoutWidth = HPScreenW - HPFit(60);
    }
    return _careLabel;
}

- (UIButton *)intergralBtn {
    if (!_intergralBtn) {
        _intergralBtn = [UIButton new];
        _intergralBtn.backgroundColor = HPUIColorWithRGB(0x96CDCD, 1.0);
        [_intergralBtn setTitle:@"立即签到" forState:UIControlStateNormal];
        [_intergralBtn setTitleColor:HPUIColorWithRGB(0xffffff, 1.0) forState:UIControlStateNormal];
        [_intergralBtn addTarget:self action:@selector(interAcion:) forControlEvents:UIControlEventTouchUpInside];
        [_intergralBtn addTarget:self action:@selector(interDown:) forControlEvents:UIControlEventTouchDown];
        _intergralBtn.layer.cornerRadius = HPFit(20);
    }
    return _intergralBtn;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y > -k_top_height) {
        scrollView.contentOffset = CGPointMake(0, -k_top_height);
    }
}

#pragma mark - 签到Action
- (void) interAcion:(UIButton *)sender {
    sender.backgroundColor = kSetUpCololor(195, 195, 195, 1.0);//HPUIColorWithRGB(0x96CDCD, 1.0);
    [sender setTitle:@"今日已签到" forState:UIControlStateNormal];
    sender.userInteractionEnabled = NO;
}

- (void) interDown:(UIButton *)sender {
    sender.backgroundColor = HPUIColorWithRGB(0x000000, 0.7);
}

@end
