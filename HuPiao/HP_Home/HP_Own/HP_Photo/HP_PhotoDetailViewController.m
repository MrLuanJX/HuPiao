//
//  HP_PhotoDetailViewController.m
//  HuPiao
//
//  Created by a on 2019/5/23.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_PhotoDetailViewController.h"
#import "HZPhotoBrowser.h"

@interface HP_PhotoCollectionCell()

@property (nonatomic , strong) UIImageView * bgImg;

@end

@implementation HP_PhotoCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.bgImg];
        
        [self.bgImg mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.top.left.mas_equalTo(0);
        }];
    }
    return self;
}

- (UIImageView *)bgImg {
    if (!_bgImg) {
        _bgImg = [[UIImageView alloc]init];
        _bgImg.contentMode = UIViewContentModeScaleAspectFill;
        [_bgImg setClipsToBounds:YES];
    }
    return _bgImg;
}

@end

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
    [self.collectionView registerClass:[HP_PhotoCollectionCell class] forCellWithReuseIdentifier:@"photoCell"];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo (0);
    }];
    
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
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
    
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imgArr.count > 0 ? self.imgArr.count : 0;
}
    
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    HP_PhotoCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    
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
        // 行间距
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake((HPScreenW - 40)/3, (HPScreenW - 40)/3);
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10); //设置距离上 左 下 右
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
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
    }
    return _imgArr;
}

#pragma mark - 相册预览
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
        
        NSMutableArray * textArray = @[].mutableCopy;
        for (int i = 0; i < imgArr.count; i++) {
        if (i < imgArr.count - 1) {
            NSMutableArray * arr = @[].mutableCopy;
            NSString * str = imgArr[i];
            [arr addObject:str];
            [textArray addObjectsFromArray:arr];
        }
            if (i == imgArr.count - 1) {
                [textArray addObject:@"理科类691分以上有22人，684分以上累计有50人。理科高分优先投档线495分以上累计有77056人，理科本科线390分以上累计有208357人。\n25日12时前考生如对本人某科成绩有疑问，可携带准考证到所在中学或当地县(市、区)招生办公室(考试中心)提出复查分数的书面申请；29日8时起，考生可通过广东省教育考试院官微小程序或粤省事小程序自行下载并打印成绩证书。\n根据时间安排，高考放榜后，6月25日考生开始网上填报志愿，7月2日填报志愿结束，7月7日录取工作正式开始。请考生密切关注广东省教育厅官网(edu.gd.gov.cn)及官微(gdsjyt)，广东省教育考试院官网(eea.gd.gov.cn)及官微(gdsksy)和广东教育考试服务网(www.eesc.com.cn)，及时跟踪高考成绩、志愿填报、高校录取等信息发布动态。广东省教育考试院提醒，请考生按照广东省教育考试院提供的正规渠道查询成绩和录取结果，谨防通过非正规渠道查询导致个人信息泄露的风险或被误导，以免上当受骗。(完)"];
            }
        }
        
        browser.textArray = textArray;

    }
    [browser show];
}

@end
