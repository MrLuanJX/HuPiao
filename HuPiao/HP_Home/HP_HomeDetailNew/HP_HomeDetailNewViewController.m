//
//  HP_HomeDetailNewViewController.m
//  HuPiao
//
//  Created by a on 2019/5/23.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_HomeDetailNewViewController.h"
#import "HP_OwnDetailViewController.h"
#import "HP_PhotoDetailViewController.h"
#import "HP_DyViewController.h"
#import "HP_HomeDetailOwnHeadView.h"

@interface HP_HomeDetailNewViewController () <YNPageViewControllerDataSource, YNPageViewControllerDelegate, SDCycleScrollViewDelegate>
    
@property (nonatomic, copy) NSArray *imagesURLs;
    
@property (nonatomic, copy) NSArray *cacheKeyArray;
 
@property (nonatomic , strong) NSMutableArray * imgArray;

@property (nonatomic , strong) UIButton * backBtn;

@property (nonatomic , strong) UIButton * careBtn;                  // 关注

@property (nonatomic , assign) BOOL isCared;

@property (nonatomic , strong) HP_HomeDetailOwnHeadView * ownHeadView;

@property (nonatomic , strong) UIButton * createDyBtn;

@property (nonatomic , strong) UIButton * talkBtn;

@property (nonatomic , assign) CGFloat contentY;

@end

@implementation HP_HomeDetailNewViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.alpha = 0;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.alpha = 1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isCared = NO;
    
    [self setupBackBtn];
}

- (void) setupBackBtn {
    [self.view addSubview: self.careBtn];
    [self.view addSubview: self.createDyBtn];
    [self.view addSubview: self.backBtn];
    [self.view addSubview: self.talkBtn];
    // 返回
    [self.backBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (self.navigationController.navigationBar.height);
        make.left.mas_equalTo (10);
        make.width.height.mas_equalTo (40);
    }];
    // 关注
    [self.careBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo (- HPFit(60));
        make.centerX.mas_equalTo (self.view.mas_centerX).multipliedBy(0.5);
        make.height.mas_equalTo (HPFit(30));
        make.width.mas_equalTo (HPFit(150));
    }];
    // 聊天
    [self.talkBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo (- HPFit(60));
        make.centerX.mas_equalTo (self.view.mas_centerX).multipliedBy(1.5);
        make.height.mas_equalTo (HPFit(30));
        make.width.mas_equalTo (HPFit(150));
    }];
    // 发布动态
    [self.createDyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo (- HPFit(60));
        make.centerX.mas_equalTo (self.view.mas_centerX);
        make.height.mas_equalTo (HPFit(30));
        make.width.mas_equalTo (HPFit(150));
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.createDyBtn setBorderWithCornerRadius:self.createDyBtn.height/2 borderWidth:0 borderColor:[UIColor clearColor] type:UIRectCornerAllCorners];
     [self.careBtn setBorderWithCornerRadius:self.careBtn.height/2 borderWidth:0 borderColor:[UIColor clearColor] type:UIRectCornerAllCorners];
    [self.talkBtn setBorderWithCornerRadius:self.talkBtn.height/2 borderWidth:0 borderColor:[UIColor clearColor] type:UIRectCornerAllCorners];
}

#pragma mark - Public Function
+ (instancetype)suspendCenterPageVCWithUser:(MUser *)user IsOwn:(BOOL)isOwn{
    
    YNPageConfigration *configration = [YNPageConfigration defaultConfig];
    configration.pageStyle = YNPageStyleSuspensionCenter;
    configration.headerViewCouldScale = YES;
    configration.headerViewScaleMode = YNPageHeaderViewScaleModeTop;
    configration.showTabbar = NO;
    configration.showNavigation = NO;
    configration.scrollMenu = NO;
    configration.aligmentModeCenter = NO;
    configration.lineWidthEqualFontWidth = true;
    configration.showBottomLine = NO;
    configration.showGradientColor = YES;
    configration.bounces = YES;
    configration.suspenOffsetY = 88;
    configration.itemFont = HPFontSize(14);
    configration.selectedItemFont = HPFontSize(16);
    configration.selectedItemColor = HPUIColorWithRGB(0x3D79FD, 1.0);
    configration.normalItemColor = HPUIColorWithRGB(0x3D79FD, 1.0);
    configration.lineColor = configration.selectedItemColor;
    return [self suspendCenterPageVCWithConfig:configration WithUser:user IsOwn:isOwn];
}
    
+ (instancetype)suspendCenterPageVCWithConfig:(YNPageConfigration *)config WithUser:(MUser *)user IsOwn:(BOOL)isOwn{
    
    HP_HomeDetailNewViewController *vc = [HP_HomeDetailNewViewController pageViewControllerWithControllers:[self getArrayVCsWithUser:user isOwn:isOwn] titles:[self getArrayTitles] config:config];
    vc.dataSource = vc;
    vc.delegate = vc;
    
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HPScreenW, HPFit(500))];
    headView.backgroundColor = [UIColor redColor];
    
    SDCycleScrollView * autoScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, HPScreenW,HPFit(400)) delegate:vc placeholderImage:[UIImage imageNamed:@"1.jpg"]];  // floor(400.0f)
    autoScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    autoScrollView.autoScrollTimeInterval = 5.0;
    autoScrollView.localizationImageNamesGroup = vc.imgArray;
    autoScrollView.clipsToBounds = YES;
    [headView addSubview:autoScrollView];
    
    vc.ownHeadView.frame = CGRectMake(0, CGRectGetMaxY(autoScrollView.frame), HPScreenW, HPFit(100));
    vc.ownHeadView.user = user;
    [headView addSubview: vc.ownHeadView];
    
    vc.headerView = headView;
    /// 指定默认选择index 页面
    vc.pageIndex = 0;
    
    if (isOwn == YES) {
        vc.careBtn.hidden = YES;
        vc.talkBtn.hidden = YES;
        vc.createDyBtn.hidden = NO;
    } else {
        vc.createDyBtn.hidden = YES;
        vc.careBtn.hidden = NO;
        vc.talkBtn.hidden = NO;
    }
    
    return vc;
}
    
+ (NSArray *)getArrayVCsWithUser:(MUser *)user isOwn:(BOOL)isOwn{
    
    HP_OwnDetailViewController * ownVC = [[HP_OwnDetailViewController alloc] init];
    ownVC.user = user;
    HP_PhotoDetailViewController * photoVC = [[HP_PhotoDetailViewController alloc] init];
    photoVC.user = user;
    HP_DyViewController * dyVC = [[HP_DyViewController alloc] init];
    dyVC.user = user;
    dyVC.isOwn = isOwn;
    return @[ownVC, photoVC, dyVC];
}

#pragma mark - YNPageViewControllerDataSource
- (UIScrollView *)pageViewController:(YNPageViewController *)pageViewController pageForIndex:(NSInteger)index {
    UIViewController *vc = pageViewController.controllersM[index];
    if ([vc isKindOfClass:[HP_OwnDetailViewController class]]) {
        return [(HP_OwnDetailViewController *)vc tableView];
    } else if ([vc isKindOfClass:[HP_DyViewController class]]) {
        return [(HP_DyViewController *)vc tableView];
    } else {
        return [(HP_PhotoDetailViewController *)vc collectionView];
    }
}
#pragma mark - YNPageViewControllerDelegate
- (void)pageViewController:(YNPageViewController *)pageViewController contentOffsetY:(CGFloat)contentOffset progress:(CGFloat)progress {
    
//    NSLog(@"--- contentOffset = %f,    progress = %f", contentOffset, progress);
    self.navigationController.navigationBar.alpha = progress;
}
    
/// 返回列表的高度 默认是控制器的高度大小
//- (CGFloat)pageViewController:(YNPageViewController *)pageViewController heightForScrollViewAtIndex:(NSInteger)index {
//    return 400;
//}
    
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"----click 轮播图 index %ld", index);
}
    
//- (NSString *)pageViewController:(YNPageViewController *)pageViewController customCacheKeyForIndex:(NSInteger)index {
//    return self.cacheKeyArray[index];
//}
    
- (void)pageViewController:(YNPageViewController *)pageViewController didScrollMenuItem:(UIButton *)itemButton index:(NSInteger)index {
    NSLog(@"didScrollMenuItem index %ld", index);
}


#pragma mark - Getter and Setter
- (NSArray *)cacheKeyArray {
    if (!_cacheKeyArray) {
        _cacheKeyArray = @[@"1", @"2", @"3"];
    }
    return _cacheKeyArray;
}
- (NSMutableArray *)imgArray {
    if (!_imgArray) {
        _imgArray = [NSMutableArray arrayWithObjects:@"1.jpg",@"2.png",@"3.png", nil];
    }
    return _imgArray;
}
  
+ (NSArray *)getArrayTitles {
    return @[@"资料", @"相册", @"动态"];
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton new];
        _backBtn.backgroundColor = HPUIColorWithRGB(0x000000, 0.5);
        [_backBtn setImage:[UIImage imageNamed:@"leftbackicon_white_titlebar_24x24_"] forState:UIControlStateNormal];
        _backBtn.layer.cornerRadius = 20;
        _backBtn.layer.masksToBounds = YES;
        [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (void) backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (HP_HomeDetailOwnHeadView *)ownHeadView {
    if (!_ownHeadView) {
        _ownHeadView = [HP_HomeDetailOwnHeadView new];
        _ownHeadView.backgroundColor = [UIColor whiteColor];
    }
    return _ownHeadView;
}

- (UIButton *) careBtn {
    if (!_careBtn) {
        _careBtn = [UIButton new];
        _careBtn.backgroundColor = kSetUpCololor(61, 121, 253, 0.8);
        [_careBtn setTitle:@"关 注" forState:UIControlStateNormal];
        [_careBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _careBtn.titleLabel.font = HPFontSize(15);
        [_careBtn addTarget:self action:@selector(careAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _careBtn;
}

- (UIButton *)createDyBtn {
    if (!_createDyBtn) {
        _createDyBtn = [UIButton new];
        _createDyBtn.backgroundColor = kSetUpCololor(61, 121, 253, 0.8);
        [_createDyBtn setTitle:@"发 布" forState:UIControlStateNormal];
        [_createDyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _createDyBtn.titleLabel.font = HPFontSize(15);
        _createDyBtn.hidden = YES;
    }
    return _createDyBtn;
}

- (UIButton *) talkBtn {
    if (!_talkBtn) {
        _talkBtn = [UIButton new];
        _talkBtn.backgroundColor = kSetUpCololor(61, 121, 253, 0.8);
        [_talkBtn setTitle:@"聊 天" forState:UIControlStateNormal];
        [_talkBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _talkBtn.titleLabel.font = HPFontSize(15);
    }
    return _talkBtn;
}

- (void) careAction : (UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        NSLog(@"Button关注");
        sender.backgroundColor = HPUIColorWithRGB(0x000000, 0.3);
        [sender setTitle:@"已关注" forState:UIControlStateNormal];

    } else {
        NSLog(@"Button取消关注");
        sender.backgroundColor = kSetUpCololor(61, 121, 253, 0.8);
        [sender setTitle:@"关 注" forState:UIControlStateNormal];
    }
}



@end
