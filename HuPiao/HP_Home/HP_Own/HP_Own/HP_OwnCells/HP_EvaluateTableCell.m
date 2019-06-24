//
//  HP_EvaluateTableCell.m
//  HuPiao
//
//  Created by a on 2019/6/10.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_EvaluateTableCell.h"

@interface HP_EvaluateCollectionCell ()

@property (nonatomic , strong) UILabel * title;

@end

@implementation HP_EvaluateCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}

- (void) setupUI {
    [self addSubview: self.title];
    
    [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo (self);
    }];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self.title setBorderWithCornerRadius:self.title.height/2 borderWidth:0 borderColor:HPClearColor type:UIRectCornerAllCorners];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (UILabel *)title {
    if (!_title) {
        _title = [UILabel new];
        int R = (arc4random() % 256) ;
        int G = (arc4random() % 256) ;
        int B = (arc4random() % 256) ;
        _title.backgroundColor = kSetUpCololor(R, G, B, 1.0);
    }
    return _title;
}

@end

@interface HP_EvaluateTableCell() <UICollectionViewDelegate , UICollectionViewDataSource>

@property (nonatomic , strong) UICollectionView * collectionView;

@property (nonatomic , strong) UIButton * icon;

@property (nonatomic , strong) UIButton * name;

@end

@implementation HP_EvaluateTableCell

// 创建cell
+ (instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier{
    
    HP_EvaluateTableCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HP_EvaluateTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];//kSetUpCololor(242, 242, 242, 1.0);
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self configUI];
        
        [self createConstrainte];
    }
    return self;
}

- (void) configUI {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 行间距
    layout.minimumLineSpacing = HPFit(10);
    layout.minimumInteritemSpacing = HPFit(10);
    layout.sectionInset = UIEdgeInsetsMake(0, HPFit(10), 0, HPFit(10)); //设置距离上 左 下 右
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:[HP_EvaluateCollectionCell class] forCellWithReuseIdentifier:@"evaluateCollectCell"];
    collectionView.backgroundColor = HPUIColorWithRGB(0xffffff, 1.0);
    collectionView.userInteractionEnabled = NO;
    self.collectionView = collectionView;
    [self.contentView addSubview:collectionView];
    
    [self.contentView addSubview: self.icon];
    [self.contentView addSubview: self.name];
}

- (void) createConstrainte {
    __weak typeof (self) weakSelf = self;

    [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(HPFit(10));
        make.width.height.mas_equalTo (HPFit(40));
    }];
    
    [self.name mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (weakSelf.icon.mas_right).offset(HPFit(10));
        make.height.top.bottom.mas_equalTo (weakSelf.icon);
    }];
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.contentView.mas_top).mas_offset (HPFit(10));
        make.left.mas_equalTo(weakSelf.name.mas_right).offset(HPFit(10));
        make.right.mas_equalTo (0);
        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).offset (-HPFit(10));
    }];
    
    [self.collectionView reloadData];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self.icon setBorderWithCornerRadius:self.icon.height/2 borderWidth:0 borderColor:HPClearColor type:UIRectCornerAllCorners];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((HPScreenW - self.icon.width - self.name.width - HPFit(60))/2, HPFit(30));
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HP_EvaluateCollectionCell * collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"evaluateCollectCell" forIndexPath:indexPath];
    return collectionCell;
}

/* 点击item */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (UIButton *)icon {
    if(!_icon){
        _icon = [UIButton new];
        _icon.backgroundColor = [UIColor yellowColor];
    }
    return _icon;
}

- (UIButton *)name {
    if (!_name) {
        _name = [UIButton new];
        [_name setTitle:@"用户名称" forState:UIControlStateNormal];
        [_name setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _name.titleLabel.font = HPFontSize(15);
    }
    return _name;
}

@end
