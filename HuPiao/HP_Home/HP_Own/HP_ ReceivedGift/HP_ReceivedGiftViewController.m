//
//  HP_ReceivedGiftViewController.m
//  HuPiao
//
//  Created by a on 2019/6/24.
//  Copyright © 2019 栾金鑫. All rights reserved.
//


#import "HP_ReceivedGiftViewController.h"

@interface HP_ReceivedGiftModel ()

@end

@implementation HP_ReceivedGiftModel

@end

@interface HP_ReceivedGiftCell ()

@property (nonatomic , strong) UIImageView * icon;

@property (nonatomic , strong) UILabel * name;

@property (nonatomic , strong) UILabel * count;

@property (nonatomic , strong) HP_ReceivedGiftModel * giftModel;

@end

@implementation HP_ReceivedGiftCell

- (void)setGiftModel:(HP_ReceivedGiftModel *)giftModel {
    _giftModel = giftModel;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:giftModel.icon] placeholderImage:[UIImage imageWithColor:[UIColor yellowColor]]];
    
    self.name.text = giftModel.name;
    
    self.count.text = [NSString stringWithFormat:@"x%@",giftModel.count];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addViews];
    }
    return self;
}

- (void) addViews {
    WS(wSelf);
    
    [self.contentView addSubview: self.icon];
    [self.contentView addSubview: self.name];
    [self.contentView addSubview: self.count];
    
    [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo (0);
        make.height.mas_equalTo (wSelf.contentView.mas_height).offset(-HPFit(60));
    }];
    
    [self.name mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (wSelf.icon.mas_bottom).offset (HPFit(10));
        make.left.right.mas_equalTo (wSelf.icon);
        make.height.mas_equalTo (HPFit(20));
    }];
    
    [self.count mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (wSelf.name.mas_bottom);
        make.left.right.mas_equalTo (wSelf.icon);
        make.bottom.mas_equalTo (wSelf.contentView.mas_bottom);
    }];
}

- (UIImageView *)icon {
    if (!_icon) {
        _icon = [UIImageView new];
        _icon.backgroundColor = [UIColor yellowColor];
    }
    return _icon;
}

- (UILabel *)name {
    if (!_name) {
        _name = [UILabel new];
        _name.font = HPFontSize(15);
        _name.textColor = HPUIColorWithRGB(0x666666, 1.0);
        _name.textAlignment = NSTextAlignmentCenter;
        _name.text = @"飞机";
    }
    return _name;
}

- (UILabel *)count {
    if (!_count) {
        _count = [UILabel new];
        _count.font = HPFontSize(13);
        _count.textColor = HPUIColorWithRGB(0xFF34B3, 1.0);
        _count.textAlignment = _name.textAlignment;
        _count.text = @"x134";
    }
    return _count;
}

@end

@interface HP_ReceivedGiftViewController () <UICollectionViewDelegate , UICollectionViewDataSource>

@property (nonatomic , strong) UILabel * textLabel;

@property (nonatomic , strong) UICollectionView * collectionView;

@property (nonatomic , strong) NSMutableArray * dataSource;

@end

@implementation HP_ReceivedGiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"礼物柜";
    
    self.dataSource = [NSMutableArray arrayWithObjects:[HP_ReceivedGiftModel mj_objectWithKeyValues:@{@"icon":@"",@"name":@"黄瓜",@"count":@"132"}],[HP_ReceivedGiftModel mj_objectWithKeyValues:@{@"icon":@"",@"name":@"飞机",@"count":@"332"}],[HP_ReceivedGiftModel mj_objectWithKeyValues:@{@"icon":@"",@"name":@"游艇",@"count":@"155"}],[HP_ReceivedGiftModel mj_objectWithKeyValues:@{@"icon":@"",@"name":@"火箭",@"count":@"587"}],[HP_ReceivedGiftModel mj_objectWithKeyValues:@{@"icon":@"",@"name":@"1314",@"count":@"442"}],[HP_ReceivedGiftModel mj_objectWithKeyValues:@{@"icon":@"",@"name":@"玫瑰",@"count":@"900"}],[HP_ReceivedGiftModel mj_objectWithKeyValues:@{@"icon":@"",@"name":@"跑车",@"count":@"1001"}],[HP_ReceivedGiftModel mj_objectWithKeyValues:@{@"icon":@"",@"name":@"么么哒",@"count":@"332"}],[HP_ReceivedGiftModel mj_objectWithKeyValues:@{@"icon":@"",@"name":@"蓝色妖姬",@"count":@"764"}],[HP_ReceivedGiftModel mj_objectWithKeyValues:@{@"icon":@"",@"name":@"海洋之恋",@"count":@"465"}],[HP_ReceivedGiftModel mj_objectWithKeyValues:@{@"icon":@"",@"name":@"城堡",@"count":@"342"}],[HP_ReceivedGiftModel mj_objectWithKeyValues:@{@"icon":@"",@"name":@"香蕉",@"count":@"332"}],[HP_ReceivedGiftModel mj_objectWithKeyValues:@{@"icon":@"",@"name":@"墨镜",@"count":@"1242"}],nil];
    
    [self addViews];
    
    [self createConstraint];
}

- (void) addViews {
    [self.view addSubview: self.textLabel];
    [self.view addSubview: self.collectionView];
}

-(void)createConstraint {
    WS(wSelf);
    
    [self.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HPFit(15)+k_top_height);
        make.left.mas_equalTo(HPFit(10));
        make.right.mas_equalTo(-HPFit(10));
    }];
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (wSelf.textLabel.mas_bottom).offset (HPFit(15));
        make.left.right.mas_equalTo (0);
        make.bottom.mas_equalTo (0);
    }];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((HPScreenW - HPFit(60))/5, (HPScreenW - HPFit(60))/5 + HPFit(60));
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HP_ReceivedGiftCell * collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"receivedGiftCell" forIndexPath:indexPath];
    
    collectionCell.giftModel = self.dataSource[indexPath.item];
    
    return collectionCell;
}

/* 点击item */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.attributedText = [HP_Label setUpFirstStr:@"总礼物数：" FirstColor:HPUIColorWithRGB(0x333333, 1.0) FirstFont:HPFontSize(17) SecondStr:@"1032" SecondColor:HPUIColorWithRGB(0xFF0000, 1.0) SecondFont:HPFontSize(22)];
        _textLabel.numberOfLines = 0;
        _textLabel.preferredMaxLayoutWidth = HPScreenW - HPFit(20);
    }
    return _textLabel;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置布局方向为垂直流布局
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        // 行间距
        layout.minimumLineSpacing = HPFit(10);
        layout.minimumInteritemSpacing = HPFit(10);
        layout.sectionInset = UIEdgeInsetsMake(HPFit(10), HPFit(10), HPFit(10), HPFit(10)); //设置距离上 左 下 右
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[HP_ReceivedGiftCell class] forCellWithReuseIdentifier:@"receivedGiftCell"];
        _collectionView.backgroundColor = HPUIColorWithRGB(0xffffff, 1.0);
//        _collectionView.userInteractionEnabled = NO;
    }
    return _collectionView;
}

@end
