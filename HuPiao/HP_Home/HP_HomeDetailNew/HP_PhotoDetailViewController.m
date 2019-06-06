//
//  HP_PhotoDetailViewController.m
//  HuPiao
//
//  Created by a on 2019/5/23.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_PhotoDetailViewController.h"
#import "XZ_CollectionCell.h"
#import "HZPhotoBrowser.h"

@interface HP_PhotoDetailViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
   
@property (nonatomic , strong) NSMutableArray * imgArr;

@end

@implementation HP_PhotoDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSLog(@"photoUser = %@",self.user);
    
    [self.imgArr removeAllObjects];
    [self.imgArr addObjectsFromArray:[MUser findAll]];
    [self.collectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addCollectionView];
}

- (void) addCollectionView {
    [self.collectionView registerClass:[XZ_CollectionCell class] forCellWithReuseIdentifier:@"id"];
//    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderID];
//    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FooterID];
    [self.view addSubview:self.collectionView];
    [self addCollectionViewRefresh];
}
    
- (void)addCollectionViewRefresh {
    __weak typeof (self) weakSelf = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.collectionView.mj_header endRefreshing];
        });
    }];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.collectionView.mj_footer endRefreshing];
        });
    }];
}
    
#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
/*
    static NSString *HeaderID = @"header";
    static NSString *FooterID = @"footer";

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderID forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor blueColor];
        return headerView;
    } else {
        UICollectionReusableView *footerView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FooterID forIndexPath:indexPath];
        
        footerView.backgroundColor = [UIColor greenColor];
        return footerView;
    }
}

/// collectinView section header 在高版本存在系统BUG，需要设置zPosition = 0.0
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    view.layer.zPosition = 0.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return (CGSize){HPScreenW * 0.5, 22};
}
    
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return (CGSize){HPScreenW, 22};
}
*/
    
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
    
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imgArr.count > 0 ? self.imgArr.count : 0;
}
    
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    XZ_CollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"id" forIndexPath:indexPath];
    
    MUser * user = self.imgArr[indexPath.item];
    
    [cell.bgImg sd_setImageWithURL:[NSURL URLWithString:HPNULLString(user.portrait) ? @"" : user.portrait] placeholderImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MUser * user = self.imgArr[indexPath.item];
    if (!HPNULLString(user.portrait)) {
        [self photoBrowserURLArray:self.imgArr WithIndex:(int)indexPath.item ];
    }
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.itemSize = CGSizeMake(100, 100);
         layout.itemSize = CGSizeMake((HPScreenW - HPFit(40))/3, (HPScreenW - HPFit(40))/3);
        layout.sectionInset = UIEdgeInsetsMake( HPFit(10), HPFit(10), HPFit(30), HPFit(10)); //设置距离上 左 下 右
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}
    
- (void)dealloc {
    NSLog(@"----- %@ delloc", self.class);
}
    
- (NSMutableArray *)imgArr {
    if (!_imgArr) {
        _imgArr = @[].mutableCopy;
        //[NSMutableArray arrayWithObjects:@"1.jpg",@"2.png",@"3.png",@"2.png",@"1.jpg",@"3.png",@"3.png",@"1.jpg",@"2.png",@"2.png",@"1.jpg",@"2.png",@"3.png",@"1.jpg",@"3.png",@"1.jpg",@"3.png",@"2.png", nil];
        //@"by.png",@"jn.jpg",@"sz.jpg",@"jx.jpg",@"sz.jpg",@"cn.jpg",@"tc.jpg",@"tx.jpg",@"ss.jpg",@"mj.jpg",@"sp.jpg",@"sy.jpg",
    }
    return _imgArr;
}

- (void) photoBrowserURLArray:(NSMutableArray *)urlArr WithIndex:(int)index {
    HZPhotoBrowser *browser = [[HZPhotoBrowser alloc] init];
    browser.isFullWidthForLandScape = YES;
    browser.isNeedLandscape = YES;
    browser.currentImageIndex = index;
    if (urlArr.count > 0) {
        NSMutableArray * imgArr = @[].mutableCopy;
        for (MUser * user in urlArr) {
            if (!HPNULLString(user.portrait)) {
                [imgArr addObject:user.portrait];
            }
        }
        browser.imageArray = imgArr;
    }
    [browser show];
}

@end
