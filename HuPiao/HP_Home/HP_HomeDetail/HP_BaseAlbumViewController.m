//
//  HP_BaseAlbumViewController.m
//  HuPiao
//
//  Created by a on 2019/5/23.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_BaseAlbumViewController.h"
#import "XZ_CollectionCell.h"

@interface HP_BaseAlbumViewController () <UICollectionViewDelegate , UICollectionViewDataSource>

@property (nonatomic , strong) UICollectionView * collectionView;

@property (nonatomic , strong) NSMutableArray * dataArray;
    
@property (nonatomic , strong) NSMutableArray * imgArr;

@end

@implementation HP_BaseAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
}

- (void) setupUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 行间距
    layout.minimumInteritemSpacing = HPFit(10);
    if ((void)(SAFE_AREA_INSETS_BOTTOM),safeAreaInsets().bottom > 0.0) {
        layout.minimumLineSpacing = HPFit(10);
    } else {
        layout.minimumLineSpacing = HPFit(10);
    }
    //设置每个item的大小
    layout.itemSize = CGSizeMake((HPScreenW - HPFit(40))/3, (HPScreenW - HPFit(40))/3);
    layout.sectionInset = UIEdgeInsetsMake( HPFit(10), HPFit(10), HPFit(30), HPFit(10)); //设置距离上 左 下 右
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    
    [collectionView registerClass:[XZ_CollectionCell class] forCellWithReuseIdentifier:@"detailCollectCell"];
    collectionView.backgroundColor = HPUIColorWithRGB(0xffffff, 1.0);
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
    
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imgArr != 0 ? self.imgArr.count : 0;
}
    
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XZ_CollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"detailCollectCell" forIndexPath:indexPath];
    
//    cell.title.text = self.dataArray[indexPath.item];
    
    cell.bgImg.image = [UIImage imageNamed:self.imgArr[indexPath.item]];
    
    return cell;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:@"白羊座",@"金牛座",@"双子座",@"巨蟹座",@"狮子座",@"处女座",@"天秤座",@"天蝎座",@"射手座",@"摩羯座",@"水瓶座",@"双鱼座", nil];
    }
    return _dataArray;
}
  
- (NSMutableArray *)imgArr {
    if (!_imgArr) {
        _imgArr = [NSMutableArray arrayWithObjects:@"by.png",@"jn.jpg",@"sz.jpg",@"jx.jpg",@"sz.jpg",@"cn.jpg",@"tc.jpg",@"tx.jpg",@"ss.jpg",@"mj.jpg",@"sp.jpg",@"sy.jpg",@"1.jpg",@"2.png",@"3.png", nil];
    }
    return _imgArr;
}
    
@end
