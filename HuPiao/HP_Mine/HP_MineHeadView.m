//
//  HP_MineHeadView.m
//  HuPiao
//
//  Created by a on 2019/6/4.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_MineHeadView.h"

@interface HP_MineHeadView ()
@property (nonatomic, strong) UIButton * ownView;
@property (nonatomic, strong) UIImageView * avatarImageView;       // 当前用户头像
@property (nonatomic, strong) UILabel * nameLabel;                  // 昵称
@property (nonatomic, strong) UIButton * ownReadWrite;              // 查看个人主页
@property (nonatomic, strong) UIButton * signBtn;
@property (nonatomic, strong) UIButton * setBtn;
@property (nonatomic, strong) NSMutableArray * masonryViewArray;
@property (nonatomic, strong) NSMutableArray * masonryLabelArray;
@property (nonatomic, strong) NSMutableArray * masonryTextArray;

@end

@implementation HP_MineHeadView

- (void)setUser:(MUser *)user {
    _user = user;
    
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:_user.portrait] placeholderImage:[UIImage imageWithColor:[UIColor greenColor]]];
    self.nameLabel.text = _user.name;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.image = [UIImage imageNamed:@"bgView.jpg"];
        
        [self setupUI];
        [self createConstrainte];
    }
    return self;
}

- (void) setupUI {
  
    [self addSubview: self.ownView];
    // 用户头像
    [self.ownView addSubview: self.avatarImageView];

    // 昵称
    UILabel * nameLabel = [[UILabel alloc] init];
    nameLabel.font = HPFontBoldSize(20);
    nameLabel.textColor = [UIColor colorWithWhite:1 alpha:1];
    nameLabel.textAlignment = NSTextAlignmentRight;
    nameLabel.text = @"安鑫";
    self.nameLabel = nameLabel;
    [self.ownView addSubview: self.nameLabel];
    // 个人主页
    UIButton * ownReadWrite = [UIButton new];
    [ownReadWrite setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [ownReadWrite setTitle:@"查看个人主页 >" forState:UIControlStateNormal];
    ownReadWrite.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    ownReadWrite.titleLabel.font = HPFontSize(15);
    [ownReadWrite addTarget:self action:@selector(ownReadWriteAction:) forControlEvents:UIControlEventTouchUpInside];
    //    ownReadWrite.hidden = YES;
    self.ownReadWrite = ownReadWrite;
    [self.ownView addSubview: ownReadWrite];
    
    // 关注
    [self forViewWithAuth:YES];
    // 签到
    UIButton * siginBtn = [UIButton new];
    [siginBtn setTitle:@"签到赚H币" forState:UIControlStateNormal];
    [siginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    siginBtn.titleLabel.font = HPFontSize(18);
    siginBtn.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];//kSetUpCololor(61, 121, 253, 0.5);
    [siginBtn addTarget:self action:@selector(signBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.signBtn = siginBtn;
    [self addSubview: siginBtn];
    
    // 个人资料页
    [self addSubview: self.setBtn];
}

- (void) createConstrainte {
    WS(wSelf);
    
    [self.ownView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo (wSelf.mas_centerY).multipliedBy(0.6);
        make.height.mas_equalTo (HPFit(60));
    }];
    
    [self.avatarImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo (0);
        make.left.mas_equalTo (HPFit(20));
        make.width.mas_equalTo (HPFit(60));
    }];
    
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (wSelf.avatarImageView.mas_right).offset(HPFit(10));
        make.top.mas_equalTo (wSelf.avatarImageView.mas_top).offset(HPFit(5));
    }];
    
    [self.ownReadWrite mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(wSelf.avatarImageView.mas_bottom).offset(-HPFit(5));
        make.left.mas_equalTo (wSelf.nameLabel.mas_left);
    }];
    
    [self.setBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (k_status_height+22);
        make.right.mas_equalTo (-HPFit(20));
        make.width.height.mas_equalTo (HPFit(40));
    }];
    
    [self.signBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(wSelf);
        make.height.mas_equalTo(HPFit(40));
    }];
}

-(void)layoutSublayersOfLayer:(CALayer *)layer{
    [super layoutSublayersOfLayer:layer];
    
    [self.avatarImageView setBorderWithCornerRadius:HPFit(30) borderWidth:0 borderColor:[UIColor clearColor] type:UIRectCornerAllCorners];
}

// 个人资料页修改
- (void) setAction: (UIButton *) sender{
    NSLog(@"set");
    if (self.jumpOwnPage) {
        self.jumpOwnPage();
    }
}
// 个人主页
- (void) ownReadWriteAction: (UIButton *) sender{
    if (self.jumpOwnPage) {
        self.jumpOwnPage();
    }
}
// 签到
- (void) signBtnAction:(UIButton *) sender {
    sender.backgroundColor = HPUIColorWithRGB(0xDBDBDB, 0.6);
    [sender setTitle:@"今日已签到" forState:UIControlStateNormal];
}

// 关注
- (void)careTapHandler:(UITapGestureRecognizer *)tap{
    NSInteger wantedStr = tap.view.tag;
    NSLog(@"%ld",(long)wantedStr);
    
    if (self.followAction) {
        self.followAction((long)wantedStr);
    }
}
// 个人资料
- (void) ownViewAction: (UIButton *)sender{
     NSLog(@"ownViewAction");
    if (self.jumpOwnMessagePage) {
        self.jumpOwnMessagePage();
    }
}

// 关注
- (void) forViewWithAuth:(BOOL) isAuth {
    NSArray * titleArr = isAuth == YES ? @[@"关注",@"粉丝",@"H币"] : @[@"关注",@"H币"];
    NSArray * countArr = isAuth == YES ? @[@"10",@"200",@"1000"] : @[@"15",@"180"];
    for (int i = 0; i < titleArr.count; i ++) {
            UIView * view = [[UIView alloc] init];
            view.tag = i;
            view.userInteractionEnabled = YES;
            [self addSubview:view];
            [self.masonryViewArray addObject:view];
            UILabel * careLabel = [UILabel new];
            careLabel.numberOfLines = 0;
            careLabel.textColor = HPUIColorWithRGB(0xffffff, 1.0);
            careLabel.textAlignment = NSTextAlignmentCenter;
            careLabel.text = countArr[i];
            careLabel.font = HPFontBoldSize(24);
            [view addSubview: careLabel];
            [self.masonryLabelArray addObject:careLabel];
            UILabel * careText = [UILabel new];
            careText.textColor = careLabel.textColor;
            careText.font = HPFontSize(15);
            careText.textAlignment = careLabel.textAlignment;
            careText.text = titleArr[i];
            [view addSubview: careText];
            [self.masonryTextArray addObject:careText];
            UITapGestureRecognizer * careTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(careTapHandler:)];
            [view addGestureRecognizer:careTap];
        }
        [self test_masonry_horizontal_fixSpace];
}
// 关注
- (void)test_masonry_horizontal_fixSpace {
    WS(wSelf);
    // 实现masonry水平固定间隔方法
    [self.masonryViewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:30 leadSpacing:10 tailSpacing:10];
    
    // 设置array的垂直方向的约束
    [self.masonryViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (wSelf.avatarImageView.mas_bottom).offset(HPFit(20));
        make.height.mas_equalTo (HPFit(50));
    }];
    
    [self.masonryLabelArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo (0);
        make.height.mas_equalTo (HPFit(25));
    }];
    
    [self.masonryTextArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo (0);
        make.height.mas_equalTo (HPFit(25));
    }];
}

- (NSMutableArray *)masonryViewArray {
    if (!_masonryViewArray) {
        _masonryViewArray = [NSMutableArray array];
    }
    return _masonryViewArray;
}

- (NSMutableArray *)masonryLabelArray {
    if (!_masonryLabelArray) {
        _masonryLabelArray = [NSMutableArray array];
    }
    return _masonryLabelArray;
}

- (NSMutableArray *)masonryTextArray {
    if (!_masonryTextArray) {
        _masonryTextArray = [NSMutableArray array];
    }
    return _masonryTextArray;
}
// 头像
- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [UIImageView new];
//        _avatarImageView.backgroundColor = [UIColor greenColor];
//        _avatarImageView.image = [UIImage imageNamed:@"moment_head"];
    }
    return _avatarImageView;
}
//  个人资料背景view
- (UIButton *)ownView {
    if (!_ownView) {
        _ownView = [UIButton new];
        [_ownView addTarget:self action:@selector(ownViewAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ownView;
}

- (UIButton *)setBtn {
    if (!_setBtn) {
        _setBtn = [UIButton new];
        [_setBtn setImage:[UIImage imageNamed:@"icon5"] forState:UIControlStateNormal];
        [_setBtn addTarget:self action:@selector(setAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _setBtn;
}

@end
