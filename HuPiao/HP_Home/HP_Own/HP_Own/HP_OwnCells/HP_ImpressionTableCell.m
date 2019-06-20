//
//  HP_ImpressionTableCell.m
//  HuPiao
//
//  Created by a on 2019/6/10.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_ImpressionTableCell.h"

@interface HP_ImpressionCollectionCell ()

@property (nonatomic , strong) UILabel * title;

@end

@implementation HP_ImpressionCollectionCell

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
        _title.backgroundColor = [UIColor greenColor];
    }
    return _title;
}

@end

@interface HP_ImpressionTableCell () <UICollectionViewDelegate , UICollectionViewDataSource>

@property (nonatomic , strong) UICollectionView * collectionView;

@end

@implementation HP_ImpressionTableCell

// 创建cell
+ (instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier{
    
    HP_ImpressionTableCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HP_ImpressionTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
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
    //设置每个item的大小
    //    layout.itemSize = CGSizeMake((HPScreenW - HPFit(90))/5, HPFit(50));
    layout.sectionInset = UIEdgeInsetsMake(HPFit(10), HPFit(10), HPFit(10), HPFit(10)); //设置距离上 左 下 右
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:[HP_ImpressionCollectionCell class] forCellWithReuseIdentifier:@"imCollectCell"];
    collectionView.backgroundColor = HPUIColorWithRGB(0xffffff, 1.0);
    self.collectionView = collectionView;
    [self.contentView addSubview:collectionView];
}

- (void) createConstrainte {
    __weak typeof (self) weakSelf = self;
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo (0);
    }];
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.contentView.mas_top).mas_offset (HPFit(10));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo (-HPFit(30));
        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).offset (-HPFit(10));
    }];
    
    [self.collectionView reloadData];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((HPScreenW - HPFit(80))/3.5, HPFit(30));
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HP_ImpressionCollectionCell * collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imCollectCell" forIndexPath:indexPath];
    return collectionCell;
}

/* 点击item */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

@end
