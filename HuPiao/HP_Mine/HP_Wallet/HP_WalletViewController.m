//
//  HP_WalletViewController.m
//  HuPiao
//
//  Created by a on 2019/6/6.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_WalletViewController.h"
#import "HP_WalletHeadView.h"
#import "HP_ExpenditureViewController.h"
#import "HP_CashWithdrawalViewController.h"
#import "HP_RechargeViewController.h"

@interface HP_WalletViewController () < UIScrollViewDelegate>

@property (nonatomic , strong) HP_WalletHeadView * headView;

@property (nonatomic , strong) UIScrollView * scrollView;

@end

@implementation HP_WalletViewController

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
    // 收入、支付明细
    HP_ExpenditureViewController * expenditureVC = [HP_ExpenditureViewController new];
    // 提现
    HP_CashWithdrawalViewController * cashVC = [HP_CashWithdrawalViewController new];
    // 充值
    HP_RechargeViewController * rechargeVC = [HP_RechargeViewController new];
    
    NSMutableArray * titleArr = [NSMutableArray arrayWithObjects:@"充值",@"支出明细",@"收入明细",@"提现", nil];
    
    UIView * btnView = [UIView CreateViewWithFrame:CGRectMake(HPFit(50), CGRectGetMaxY(self.headView.frame) - HPFit(20), HPScreenW - HPFit(100), titleArr.count * HPFit(60)) BackgroundColor:[UIColor whiteColor] InteractionEnabled:YES];
    
    [btnView setBorderWithCornerRadius:HPFit(10) borderWidth:0 borderColor:HPClearColor type:UIRectCornerAllCorners];
    [self.scrollView addSubview: btnView];
    
    for (int i = 0; i < titleArr.count; i++) {
        UIButton * btn = [UIButton addCustomButtonWithFrame:CGRectMake(0, i*(HPFit(59)), btnView.width, HPFit(59)) title:titleArr[i] backgroundColor:[UIColor whiteColor] titleColor:HPUIColorWithRGB(0x333333, 1.0) tapAction:^(UIButton *button) {
            switch (i) {
                case 0:
                    rechargeVC.title = @"充值";
                    [wSelf.navigationController pushViewController:rechargeVC animated:YES];
                    break;
                case 1:
                    expenditureVC.title = @"支出明细";
                    expenditureVC.isIncome = NO;
                    [wSelf.navigationController pushViewController:expenditureVC animated:YES];
                    break;
                case 2:
                    expenditureVC.title = @"收入明细";
                    expenditureVC.isIncome = YES;
                    [wSelf.navigationController pushViewController:expenditureVC animated:YES];
                    break;
                case 3:
                    cashVC.title = @"提现";
                    [wSelf.navigationController pushViewController:cashVC animated:YES];
                    break;
                default:
                    break;
            }
        }];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, HPFit(10), 0, 0);
        [btnView addSubview: btn];
        if (i < titleArr.count) {
            UIView * line = [UIView addLineWithFrame:CGRectMake(0, i*(HPFit(59)), btn.width, 1) WithView:btnView];
            [btnView addSubview:line];
        }
    }
}

- (HP_WalletHeadView *)headView {
    if (!_headView) {
        _headView = [[HP_WalletHeadView alloc] initWithFrame:CGRectMake(0, 0, HPScreenW, HPFit(200))];
    }
    return _headView;
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y > -k_top_height) {
        scrollView.contentOffset = CGPointMake(0, -k_top_height);
    }
}

@end
