//
//  HP_GiftView.m
//  HuPiao
//
//  Created by a on 2019/6/11.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_GiftView.h"

static CGFloat contentViewH = 370;

@interface HP_GiftCell()

@property (nonatomic , strong) UIImageView * icon;
@property (nonatomic , strong) UILabel * title;
@property (nonatomic , strong) UIButton * money;

@end

@implementation HP_GiftCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
        
        [self createConstraint];
    }
    return self;
}

- (void) setupUI {
    [self addSubview: self.icon];
    [self addSubview: self.title];
    [self addSubview: self.money];
}

- (void) createConstraint {
    WS(wSelf);
    
    [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo (wSelf.mas_height).multipliedBy(0.5);
    }];
    
    [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (wSelf.icon.mas_bottom);
        make.left.right.mas_equalTo(wSelf.icon);
        make.height.mas_equalTo (wSelf.mas_height).multipliedBy(0.25);
    }];
    
    [self.money mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(wSelf.mas_bottom);
        make.left.right.mas_equalTo(wSelf.icon);
        make.height.mas_equalTo (wSelf.mas_height).multipliedBy(0.25);
    }];
    
    [self.money setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.money.imageView.bounds.size.width, 0, self.money.imageView.bounds.size.width + HPFit(5))];
    
    [self.money setImageEdgeInsets:UIEdgeInsetsMake(0, self.money.titleLabel.bounds.size.width + HPFit(5), 0, -self.money.titleLabel.bounds.size.width)];
}

- (UIImageView *)icon {
    if (!_icon) {
        _icon = [UIImageView new];
        _icon.backgroundColor = [UIColor yellowColor];
    }
    return _icon;
}

- (UILabel *)title {
    if (!_title) {
        _title = [UILabel new];
        _title.textColor = HPUIColorWithRGB(0xBEBEBE, 1.0);
        _title.font = HPFontSize(14);
        _title.textAlignment = NSTextAlignmentCenter;
        _title.text = @"黄瓜";
    }
    return _title;
}

- (UIButton *)money {
    if (!_money) {
        int x = arc4random() % 1000;
        _money = [UIButton new];
        [_money setTitle:[NSString stringWithFormat:@"%d",x] forState:UIControlStateNormal];
        [_money setImage:[UIImage imageNamed:@"HB"] forState:UIControlStateNormal];
        [_money setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _money.titleLabel.font = HPFontSize(14);
        _money.userInteractionEnabled = NO;
    }
    return _money;
}

@end

@interface HP_GiftContentView () <UICollectionViewDelegate , UICollectionViewDataSource>

@property (nonatomic , copy) void (^rechargeBlock) (void);

@property (nonatomic , strong) UILabel * title;
@property (nonatomic , strong) UILabel * lineTop;
@property (nonatomic , strong) UICollectionView * collectionView;
@property (nonatomic , strong) UILabel * lineBottom;
@property (nonatomic , strong) UIButton * currentMoney;
@property (nonatomic , strong) UIButton * rechargeBtn;

@end

@implementation HP_GiftContentView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
        [self createConstraint];
    }
    return self;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
     NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"黄瓜",@"飞机",@"游艇", @"火箭",@"1314",@"玫瑰",@"跑车",@"么么哒",@"蓝色妖姬",@"海洋之恋",@"城堡",@"香蕉",@"墨镜",nil];
    return arr.count;
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.width - HPFit(55))/5, HPFit(100));
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"黄瓜",@"飞机",@"游艇", @"火箭",@"1314",@"玫瑰",@"跑车",@"么么哒",@"蓝色妖姬",@"海洋之恋",@"城堡",@"香蕉",@"墨镜",nil];
    HP_GiftCell * collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"giftCell" forIndexPath:indexPath];
    collectionCell.title.text = arr[indexPath.item];
    return collectionCell;
}

/* 点击item */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击第%ld个item",indexPath.item);
    
}

- (void) setupUI {
    [self addSubview: self.title];
    [self addSubview: self.lineTop];
    [self addSubview: self.collectionView];
    [self addSubview: self.lineBottom];
    [self addSubview: self.currentMoney];
    [self addSubview: self.rechargeBtn];
}

- (void) createConstraint {
    WS(wSelf);
    
    [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo (HPFit(10));
        make.right.mas_equalTo (-HPFit(10));
        make.height.mas_equalTo (HPFit(30));
    }];

    [self.lineTop mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (wSelf.title.mas_bottom).offset(HPFit(10));
        make.left.right.mas_equalTo (0);
        make.height.mas_equalTo (1);
    }];
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (wSelf.lineTop.mas_bottom);
        make.left.right.mas_equalTo (0);
        make.height.mas_equalTo (HPFit(230));
    }];
    
    [self.lineBottom mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (wSelf.collectionView.mas_bottom);
        make.left.right.mas_equalTo (0);
        make.height.mas_equalTo (1);
    }];
    
    [self.currentMoney mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (wSelf.lineBottom.mas_bottom).offset (HPFit(15));
        make.left.mas_equalTo (HPFit(10));
        make.width.mas_equalTo (HPFit(100));
    }];
    
    [self.rechargeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo (wSelf.currentMoney.mas_centerY);
        make.right.mas_equalTo (-HPFit(10));
        make.width.mas_equalTo (wSelf.currentMoney);
    }];
    
    [self.currentMoney setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.currentMoney.imageView.bounds.size.width, 0, self.currentMoney.imageView.bounds.size.width + HPFit(10))];
    
    [self.currentMoney setImageEdgeInsets:UIEdgeInsetsMake(0, self.currentMoney.titleLabel.bounds.size.width + HPFit(10), 0, -self.currentMoney.titleLabel.bounds.size.width)];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self.rechargeBtn setBorderWithCornerRadius:self.rechargeBtn.height/2 borderWidth:0 borderColor:HPClearColor type:UIRectCornerAllCorners];
}

- (UILabel *)title {
    if (!_title) {
        _title = [UILabel new];
        _title.text = @"礼物";
        _title.font = HPFontSize(16);
        _title.textColor = HPUIColorWithRGB(0xffffff, 1.0);
    }
    return _title;
}

- (UILabel *)lineTop {
    if (!_lineTop) {
        _lineTop = [UILabel new];
        _lineTop.backgroundColor = HPUIColorWithRGB(0xD1D1D1, 0.8);
    }
    return _lineTop;
}

- (UILabel *)lineBottom {
    if (!_lineBottom) {
        _lineBottom = [UILabel new];
        _lineBottom.backgroundColor = _lineTop.backgroundColor;
    }
    return _lineBottom;
}

- (UIButton *)currentMoney {
    if (!_currentMoney) {
        _currentMoney = [UIButton new];
        [_currentMoney setTitle:@"0" forState:UIControlStateNormal];
        [_currentMoney setImage:[UIImage imageNamed:@"HB"] forState:UIControlStateNormal];
        [_currentMoney setTitleColor:_title.textColor forState:UIControlStateNormal];
        _currentMoney.titleLabel.font = HPFontSize(20);
        _currentMoney.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _currentMoney.userInteractionEnabled = NO;
    }
    return _currentMoney;
}

- (UIButton *)rechargeBtn {
    if (!_rechargeBtn) {
        _rechargeBtn = [UIButton new];
        [_rechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
        [_rechargeBtn setTitleColor:_title.textColor forState:UIControlStateNormal];
        _rechargeBtn.titleLabel.font = HPFontSize(15);
        _rechargeBtn.backgroundColor = kSetUpCololor(61, 121, 253, 1.0);
        [_rechargeBtn addTarget:self action:@selector(rechargeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rechargeBtn;
}

- (void) rechargeAction {
    NSLog(@"充值");
    if (self.rechargeBlock) {
        self.rechargeBlock();
    }
}

- (UICollectionView *)collectionView {

    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(HPFit(10), HPFit(10), HPFit(10), HPFit(10)); //设置距离上 左 下 右
        //设置布局方向为垂直流布局
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = HPClearColor;
        [_collectionView registerClass:[HP_GiftCell class] forCellWithReuseIdentifier:@"giftCell"];
    }
    return _collectionView;
}

@end

@interface HP_GiftView ()
/** 视图 */
@property (nonatomic , strong) HP_GiftContentView * giftContentView;

@end

@implementation HP_GiftView

+ (instancetype)showGiftView {
    return [[self alloc] init];
}

- (instancetype)init{
    if (self = [super init]) {
        __weak typeof (self) weakSelf = self;
        //蒙版遮罩
        UIButton *coverBtn = [[UIButton alloc] init];
        coverBtn.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1];
        [coverBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:coverBtn];
        [coverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf);
        }];
        
        //弹出视图
        HP_GiftContentView * giftContentView = [[HP_GiftContentView alloc]initWithFrame:CGRectMake(0, HPScreenH, HPScreenW, HPFit(200))];
        self.giftContentView = giftContentView;
        giftContentView.rechargeBlock = ^{
            weakSelf.rechargeBlock();
            [weakSelf close];
        };
        giftContentView.backgroundColor = HPUIColorWithRGB(0x000000, 0.7);
        [self addSubview:giftContentView];
    }
    return self;
}

- (void)close {
     WS(wSelf);
    [UIView animateWithDuration:0.2 animations:^{
        wSelf.giftContentView.frame = CGRectMake(0, HPScreenH, HPScreenW, contentViewH);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)show{
    __weak typeof (self) weakSelf = self;

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    
    NSLog(@"dataArray = %@",self.dataArray);
    
    [self showViewWithAnimation];
    
    [window addSubview:self];
}

- (void) showViewWithAnimation {
    WS(wSelf);
    [UIView animateWithDuration:0.2 animations:^{
        wSelf.giftContentView.frame = CGRectMake(0, HPScreenH - contentViewH - SAFE_AREA_INSETS_BOTTOM, HPScreenW, contentViewH);
    } completion:^(BOOL finished) {}];
}

/* 显示提示框的动画 */
- (void)shakeToShow:(UIView*)aView {
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1,1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2,1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0,1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}

@end
