//
//  HPCircleCollectionCell.m
//  HuPiao
//
//  Created by a on 2019/6/10.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_CircleTableCell.h"

@interface HP_CircleCollectionCell ()

@property (nonatomic , strong) UIImageView * img;

@end

@implementation HP_CircleCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
     
        [self setupUI];
    }
    return self;
}

- (void) setupUI {
    [self addSubview: self.img];
    
    [self.img mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo (self);
    }];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self.img setBorderWithCornerRadius:self.img.width/2 borderWidth:0 borderColor:HPClearColor type:UIRectCornerAllCorners];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (UIImageView *)img {
    if (!_img) {
        _img = [UIImageView new];
        _img.backgroundColor = [UIColor redColor];
    }
    return _img;
}

@end

@interface HP_CircleTableCell() <UICollectionViewDelegate , UICollectionViewDataSource>

@property (nonatomic , strong) UICollectionView * collectionView;

@end

@implementation HP_CircleTableCell

// 创建cell
+ (instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier{
    
    HP_CircleTableCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HP_CircleTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
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
    [collectionView registerClass:[HP_CircleCollectionCell class] forCellWithReuseIdentifier:@"circleCollectCell"];
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
    return CGSizeMake((HPScreenW - HPFit(90))/5, (HPScreenW - HPFit(90))/5);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HP_CircleCollectionCell * collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"circleCollectCell" forIndexPath:indexPath];
    return collectionCell;
}

/* 点击item */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

@end
