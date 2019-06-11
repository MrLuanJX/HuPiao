//
//  HP_CeIdcardBaseViewController.m
//  HuPiao
//
//  Created by a on 2019/6/11.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_CeIdcardBaseViewController.h"
#import "HP_CeIdFirstView.h"
#import "HP_CeIdSecondView.h"

@interface HP_CeIdcardBaseViewController () <UIScrollViewDelegate>

@property (nonatomic , strong) UIScrollView * bgScrollView;

@property (nonatomic , strong) UIView * bgView;
@property (nonatomic , strong) UIImageView * leftView;
@property (nonatomic , strong) UIView * lineView;
@property (nonatomic , strong) UIImageView * rightView;
@property (nonatomic , strong) UIView * bgView2;
@property (nonatomic , strong) UIImageView * leftView2;
@property (nonatomic , strong) UIView * lineView2;
@property (nonatomic , strong) UIImageView * rightView2;

@property (nonatomic , strong) HP_CeIdFirstView * firstView;
@property (nonatomic , strong) HP_CeIdSecondView * secondView;

@end

@implementation HP_CeIdcardBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addScrollView];
    [self setupRightNavBtn];
    [self blockBackAction];
}

- (void) addScrollView {
    WS(wSelf);
    
    [self.view addSubview: self.bgScrollView];
    [self.bgScrollView addSubview: self.bgView];
    [self.bgView addSubview: self.leftView];
    [self.bgView addSubview: self.lineView];
    [self.bgView addSubview: self.rightView];
    [self.bgScrollView addSubview: self.firstView];
    [self.bgScrollView addSubview: self.bgView2];
    [self.bgScrollView addSubview: self.secondView];
    [self.bgView2 addSubview: self.leftView2];
    [self.bgView2 addSubview: self.lineView2];
    [self.bgView2 addSubview: self.rightView2];

    [self.bgScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo (wSelf.view);
    }];
    
    [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HPFit(20));
        make.left.mas_equalTo (0);
        make.width.mas_equalTo (HPScreenW);
        make.height.mas_equalTo (HPFit(40));
    }];
    
    [self.leftView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo (wSelf.bgView.mas_centerX).offset (-HPFit(80));
        make.width.height.mas_equalTo (HPFit(30));
        make.centerY.mas_equalTo (wSelf.bgView.mas_centerY);
    }];
    
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (wSelf.leftView.mas_right).offset (HPFit(15));
        make.centerY.mas_equalTo (wSelf.bgView.mas_centerY);
        make.height.mas_equalTo (HPFit(2));
        make.width.mas_equalTo (HPFit(100));
    }];
    
    [self.rightView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo (wSelf.bgView.mas_centerX).offset (HPFit(80));
        make.width.height.centerY.mas_equalTo (wSelf.leftView);
    }];
    
    [self.bgView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HPFit(20));
        make.left.mas_equalTo (HPScreenW);
        make.width.mas_equalTo (HPScreenW);
        make.height.mas_equalTo (HPFit(40));
    }];
    
    [self.leftView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo (wSelf.bgView2.mas_centerX).offset (-HPFit(80));
        make.width.height.mas_equalTo (HPFit(30));
        make.centerY.mas_equalTo (wSelf.bgView2.mas_centerY);
    }];
    
    [self.lineView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (wSelf.leftView2.mas_right).offset (HPFit(15));
        make.centerY.mas_equalTo (wSelf.bgView2.mas_centerY);
        make.height.mas_equalTo (HPFit(2));
        make.width.mas_equalTo (HPFit(100));
    }];
    
    [self.rightView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo (wSelf.bgView2.mas_centerX).offset (HPFit(80));
        make.width.height.centerY.mas_equalTo (wSelf.leftView2);
    }];
}

- (void) blockBackAction {
    WS(wSelf);
    self.firstView.firstCommitBlock = ^{
        NSLog(@"commit");
        [wSelf.bgScrollView setContentOffset:CGPointMake(HPScreenW,-k_top_height) animated:YES];
    };
}

- (void) setupRightNavBtn {
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(commitAction:) Title:@"保存" TitleColor:kSetUpCololor(61, 121, 253, 1.0)];
}

- (void) commitAction: (UIBarButtonItem *) sender{
    NSLog(@"提交");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == HPScreenW) {
        NSLog(@"第二页");
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(commitAction:) Title:@"保存" TitleColor:kSetUpCololor(61, 121, 253, 1.0)];
    } else if (scrollView.contentOffset.x == 0) {
        NSLog(@"第一页");
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (UIScrollView *)bgScrollView {
    if (!_bgScrollView) {
        _bgScrollView = [UIScrollView new];
        _bgScrollView.alwaysBounceHorizontal = YES;
        _bgScrollView.pagingEnabled = YES;
        _bgScrollView.delegate = self;
        _bgScrollView.contentSize = CGSizeMake(HPScreenW * 2, 0);
        _bgScrollView.backgroundColor = [UIColor whiteColor];
        _bgScrollView.showsVerticalScrollIndicator = NO;
        _bgScrollView.showsHorizontalScrollIndicator = NO;
        _bgScrollView.bounces = NO;
        [_bgScrollView setScrollEnabled:NO];
    }
    return _bgScrollView;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UIImageView *)leftView {
    if (!_leftView) {
        _leftView = [UIImageView new];
        _leftView.image = [UIImage imageNamed:@"num1"];
    }
    return _leftView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor grayColor];
    }
    return _lineView;
}

- (UIImageView *)rightView {
    if (!_rightView) {
        _rightView = [UIImageView new];
        _rightView.image = [UIImage imageNamed:@"num2"];
    }
    return _rightView;
}

- (UIView *)bgView2 {
    if (!_bgView2) {
        _bgView2 = [UIView new];
        _bgView2.backgroundColor = [UIColor whiteColor];
    }
    return _bgView2;
}

- (UIImageView *)leftView2 {
    if (!_leftView2) {
        _leftView2 = [UIImageView new];
        _leftView2.image = [UIImage imageNamed:@"单选"];
    }
    return _leftView2;
}

- (UIView *)lineView2 {
    if (!_lineView2) {
        _lineView2 = [UIView new];
        _lineView2.backgroundColor = [UIColor redColor];
    }
    return _lineView2;
}

- (UIImageView *)rightView2 {
    if (!_rightView2) {
        _rightView2 = [UIImageView new];
        _rightView2.image = [UIImage imageNamed:@"num2"];
    }
    return _rightView2;
}

- (HP_CeIdFirstView *)firstView {
    if (!_firstView) {
        _firstView = [[HP_CeIdFirstView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bgView.frame)+HPFit(70) , self.view.width, self.view.height - CGRectGetMaxY(self.bgView.frame) - HPFit(10) - HPFit(60) - k_nav_height)];
        _firstView.userInteractionEnabled = YES;
    }
    return _firstView;
}

- (HP_CeIdSecondView *)secondView {
    if (!_secondView) {
        _secondView = [[HP_CeIdSecondView alloc] initWithFrame:CGRectMake(HPScreenW, CGRectGetMaxY(self.bgView2.frame)+HPFit(70) , self.view.width, self.view.height - CGRectGetMaxY(self.bgView2.frame) - HPFit(10) - HPFit(60) - k_nav_height)];
        _secondView.userInteractionEnabled = YES;
    }
    return _secondView;
}

@end
