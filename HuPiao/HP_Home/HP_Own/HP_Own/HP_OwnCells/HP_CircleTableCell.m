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

@property (nonatomic , strong) HP_CsoGiftSendMemberColl * csoGiftSendMemberColl;

@end

@implementation HP_CircleCollectionCell

- (void)setCsoGiftSendMemberColl:(HP_CsoGiftSendMemberColl *)csoGiftSendMemberColl {
    _csoGiftSendMemberColl = csoGiftSendMemberColl;
    
    [self.img sd_setImageWithURL:[NSURL URLWithString:csoGiftSendMemberColl.strHardimg] placeholderImage:[UIImage imageNamed:@""]];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
     
        [self setupUI];
    }
    return self;
}

- (void) setupUI {
    [self addSubview: self.img];
    
    [self.img mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo (self.contentView);
    }];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self.img setBorderWithCornerRadius:self.img.width/2 borderWidth:0 borderColor:HPClearColor type:UIRectCornerAllCorners];
}

- (UIImageView *)img {
    if (!_img) {
        _img = [UIImageView new];
        int R = (arc4random() % 256) ;
        int G = (arc4random() % 256) ;
        int B = (arc4random() % 256) ;
        _img.backgroundColor = kSetUpCololor(R, G, B, 1.0);
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
    
    [self.contentView addSubview:self.collectionView];
}

- (void) createConstrainte {
    __weak typeof (self) weakSelf = self;

    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.contentView.mas_top);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo (0);
        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom);
    }];    
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"count = ---%lu",(unsigned long)self.csoGiftSendMemberColl.count);
    return self.csoGiftSendMemberColl.count > 5 ? 5 : self.csoGiftSendMemberColl.count;
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((HPScreenW - HPFit(90))/5, (HPScreenW - HPFit(90))/5);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HP_CircleCollectionCell * collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"circleCollectCell" forIndexPath:indexPath];
    
    if (self.csoGiftSendMemberColl.count > 0) {
        
        collectionCell.csoGiftSendMemberColl = self.csoGiftSendMemberColl[indexPath.row];
    }
    
    return collectionCell;
}

/* 点击item */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置布局方向为垂直流布局
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // 行间距
        layout.minimumLineSpacing = HPFit(10);
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, HPFit(10), 0, HPFit(10)); //设置距离上 左 下 右
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[HP_CircleCollectionCell class] forCellWithReuseIdentifier:@"circleCollectCell"];
        _collectionView.backgroundColor = HPUIColorWithRGB(0xffffff, 1.0);
        _collectionView.userInteractionEnabled = NO;
    }
    return _collectionView;
}

- (void)setCsoGiftSendMemberColl:(NSArray<HP_CsoGiftSendMemberColl *> *)csoGiftSendMemberColl {
    _csoGiftSendMemberColl = csoGiftSendMemberColl;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.collectionView reloadData];
    });
}

@end
