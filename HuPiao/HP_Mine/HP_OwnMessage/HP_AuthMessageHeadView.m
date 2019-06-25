//
//  HP_AuthMessageHeadView.m
//  HuPiao
//
//  Created by a on 2019/6/5.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_AuthMessageHeadView.h"

@interface HP_AuthCollectCell ()

@property (nonatomic , strong) NSIndexPath * index;

@property (nonatomic , strong) UILabel * avatarImageLabel;

@property (nonatomic , copy) UIImage * img;

@end

@implementation HP_AuthCollectCell

- (void)setImg:(UIImage *)img {
    _img = img;
    
    self.image.image = img;
}

- (void)setIndex:(NSIndexPath *)index {
    _index = index;
    
    self.avatarImageLabel.hidden = index.row == 0 ? NO : YES;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupItemUI];
    }
    return self;
}

-(void)setupItemUI{
    
    self.image = [UIImageView new];
    self.image.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);//[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    self.image.contentMode = UIViewContentModeScaleAspectFill;
    self.image.clipsToBounds = YES;
    
    [self.contentView addSubview:self.image];
    [self.contentView addSubview:self.avatarImageLabel];
    
    [self.image mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    [self.avatarImageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(0);
        make.width.mas_equalTo (HPFit(40));
        make.height.mas_equalTo (HPFit(20));
    }];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self.image setBorderWithCornerRadius:8 borderWidth:0 borderColor:[UIColor clearColor] type:UIRectCornerAllCorners];
}

- (UILabel *)avatarImageLabel {
    if (!_avatarImageLabel) {
        _avatarImageLabel = [UILabel new];
        _avatarImageLabel.backgroundColor = HPUIColorWithRGB(0x303030, 0.5);
        _avatarImageLabel.textColor = HPUIColorWithRGB(0xffffff, 1.0);
        _avatarImageLabel.text = @"头像";
        _avatarImageLabel.font = HPFontSize(14);
        _avatarImageLabel.textAlignment = NSTextAlignmentCenter;
        [_avatarImageLabel sizeToFit];
    }
    return _avatarImageLabel;
}

@end

@interface HP_AuthMessageHeadView() <UICollectionViewDelegate , UICollectionViewDataSource>

@property (nonatomic , strong) UICollectionView * collectionView;
@property (nonatomic , strong) NSMutableArray * images;

@end

@implementation HP_AuthMessageHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}

- (void) setupUI {
    [self addSubview: self.collectionView];
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo (0);
    }];
}

#pragma mark ====== UICollectionViewDelegate ======
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  
    return CGSizeMake((HPScreenW - HPFit(30))/3, (HPScreenW - HPFit(30))/3 * 1.5);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HP_AuthCollectCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"detailCollectCell" forIndexPath:indexPath];
    
    cell.index = indexPath;
    
    NSLog(@"dataSource = %@",self.dataSource);
    
    if (self.dataSource.count > 0) {
        if (self.dataSource.count < 9) {
            for (int i = 0; i < 9 - self.dataSource.count; i++) {
                [self.dataSource addObject:[UIImage imageWithColor:kSetUpCololor(242, 242, 242, 1.0)]];
            }
        }
        cell.img = self.dataSource[indexPath.item];
    }
    
    return cell;
}

/* 点击item */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HP_AuthCollectCell * cell = (HP_AuthCollectCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (self.collectSeleteBlock) {
        self.collectSeleteBlock(indexPath,cell);
    }
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置布局方向为垂直流布局
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        // 行间距
        layout.minimumLineSpacing = HPFit(5);
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(HPFit(10), HPFit(10), HPFit(10), HPFit(10));
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[HP_AuthCollectCell class] forCellWithReuseIdentifier:@"detailCollectCell"];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (void)setDataSource:(NSMutableArray *)dataSource {
    _dataSource = dataSource;
    
      NSLog(@"d----%@",dataSource);
    
    [self.collectionView reloadData];
}

@end
