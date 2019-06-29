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
#import "HP_GiftView.h"
#import "HP_RechargeViewController.h"
#import "HP_CreateDyViewController.h"
#import "HP_ChatViewController.h"

@interface HP_HomeDetailNewViewController () <YNPageViewControllerDataSource, YNPageViewControllerDelegate, SDCycleScrollViewDelegate,TZImagePickerControllerDelegate>
    
@property (nonatomic, copy) NSArray *imagesURLs;
    
@property (nonatomic, copy) NSArray *cacheKeyArray;
 
@property (nonatomic , strong) NSMutableArray * imgArray;

@property (nonatomic , strong) UIButton * backBtn;

@property (nonatomic , strong) UIButton * careBtn;                  // 关注

@property (nonatomic , assign) BOOL isCared;                        // 是否已关注

@property (nonatomic , strong) HP_HomeDetailOwnHeadView * ownHeadView;

@property (nonatomic , strong) UIButton * createDyBtn;

@property (nonatomic , strong) UIButton * talkBtn;

@property (nonatomic , assign) CGFloat contentY;
// 礼物
@property (nonatomic , strong) UIButton * giftBtn;
@property (nonatomic , strong) UIButton * navGiftBtn;

@property (nonatomic , assign) CGFloat currentY;

@property (nonatomic , strong) NSString * isOwn;
// 相册
@property(nonatomic , strong) TZImagePickerController * photoalbum;


@property(nonatomic , strong) UIView * navBGView;

@end

@implementation HP_HomeDetailNewViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.navigationController.navigationBar.hidden = YES;
    
    self.navBGView.alpha = 0;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
    self.isCared = NO;
    
    [self setupBackBtn];
//    [self setupRightNav];
        
    [self navBar];
}

- (void) setupRightNav {
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(giftAction ) image:@"discover_3_0" highImage:@"discover_3_0" isLeftBtn:NO];
}

#pragma mark - 礼物
- (void) giftAction {
    NSLog(@"礼物");
    WS(wSelf);
    HP_RechargeViewController * rechargeVC = [HP_RechargeViewController new];
    rechargeVC.title = @"充值";
    HP_GiftView * giftView = [HP_GiftView new];
    giftView.rechargeBlock = ^{
        [wSelf.navigationController pushViewController:rechargeVC animated:YES];
    };
    [giftView show];
}

#pragma mark - 发布动态
- (void) createDyAction {
    [self jumpCreateDyVC];
}

#pragma mark - 聊天
- (void) talkAction {
    NSLog(@"聊天");
    HP_ChatViewController * chatVC = [HP_ChatViewController new];
//    chatVC.navTitle = self.user.name;
//    chatVC.user = self.user;
    [self.navigationController pushViewController:chatVC animated:YES];
}

#pragma mark - 关注
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

#pragma mark - 创建视图
- (void) setupBackBtn {
    [self.view addSubview: self.careBtn];
    [self.view addSubview: self.createDyBtn];
    [self.view addSubview: self.backBtn];
    [self.view addSubview: self.talkBtn];
    [self.view addSubview: self.giftBtn];
    // 礼物
    [self.giftBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo (-HPFit(15));
        make.top.mas_equalTo (k_status_height);
        make.width.height.mas_equalTo (40);
    }];
    
    // 返回
    [self.backBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (k_status_height);
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
+ (instancetype)suspendCenterPageVCWithUser:(HP_HomeModel *)user IsOwn:(NSString *)isOwn{
    
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
    configration.tempTopHeight = 0;
    configration.bounces = YES;
    if ((void)(SAFE_AREA_INSETS_BOTTOM),safeAreaInsets().bottom > 0.0) {
        configration.suspenOffsetY = 88;
    } else {
        configration.suspenOffsetY = 64;
    }

    configration.itemFont = HPFontSize(14);
    configration.selectedItemFont = HPFontSize(16);
    configration.selectedItemColor = HPUIColorWithRGB(0x3D79FD, 1.0);
    configration.normalItemColor = HPUIColorWithRGB(0x3D79FD, 1.0);
    configration.lineColor = configration.selectedItemColor;
    return [self suspendCenterPageVCWithConfig:configration WithUser:user IsOwn:isOwn];
}
    
+ (instancetype)suspendCenterPageVCWithConfig:(YNPageConfigration *)config WithUser:(HP_HomeModel *)user IsOwn:(NSString *)isOwn{
//    WS(wSelf);
    
    HP_HomeDetailNewViewController *vc = [HP_HomeDetailNewViewController pageViewControllerWithControllers:[self getArrayVCsWithUser:user isOwn:isOwn] titles:[self getArrayTitles] config:config];
    vc.dataSource = vc;
    vc.delegate = vc;
    
    vc.user = user;
    
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HPScreenW, HPFit(500))];
    headView.backgroundColor = [UIColor redColor];
    
    SDCycleScrollView * autoScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, HPScreenW,HPFit(400)) delegate:vc placeholderImage:[UIImage imageNamed:@"1.jpg"]];
    autoScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    autoScrollView.autoScrollTimeInterval = 5.0;
//    autoScrollView.localizationImageNamesGroup = vc.imgArray;
    autoScrollView.imageURLStringsGroup = @[user.HRADER_IMG];
    autoScrollView.clipsToBounds = YES;
    [headView addSubview:autoScrollView];
    
    vc.ownHeadView.frame = CGRectMake(0, CGRectGetMaxY(autoScrollView.frame), HPScreenW, HPFit(100));
    vc.ownHeadView.user = user;
    
   __weak HP_HomeDetailNewViewController* wself = vc;
#pragma mark - 微信
    /* 微信Action */
    vc.ownHeadView.weChatActionBlock = ^{
        NSLog(@"微信");
        [wself alertShow:user];
    };
    [headView addSubview: vc.ownHeadView];
    
    vc.headerView = headView;
    /// 指定默认选择index 页面
    vc.pageIndex = 0;
    
    vc.isOwn = isOwn;
    if ([isOwn isEqualToString:@"Own"]) {
        vc.ownHeadView.weChatBtn.hidden = YES;
        vc.navGiftBtn.hidden = YES;
        vc.giftBtn.hidden = YES;
        vc.careBtn.hidden = YES;
        vc.talkBtn.hidden = YES;
        vc.createDyBtn.hidden = NO;
    } else {
        vc.ownHeadView.weChatBtn.hidden = NO;
        vc.createDyBtn.hidden = YES;
        vc.careBtn.hidden = NO;
        vc.talkBtn.hidden = NO;
        vc.navGiftBtn.hidden = NO;
        vc.giftBtn.hidden = NO;
    }
    
    return vc;
}

+ (NSArray *)getArrayVCsWithUser:(HP_HomeModel *)user isOwn:(NSString *)isOwn{
    
    HP_OwnDetailViewController * ownVC = [[HP_OwnDetailViewController alloc] init];
    ownVC.user = user;
    HP_PhotoDetailViewController * photoVC = [[HP_PhotoDetailViewController alloc] init];
    photoVC.user = user;
    HP_DyViewController * dyVC = [[HP_DyViewController alloc] init];
    dyVC.user = user;
    
    NSLog(@"isOwn = %@",isOwn);
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
    
    if ([self.isOwn isEqualToString:@"Home"]) {
        if (self.currentY < contentOffset) {
            self.careBtn.hidden = YES ;
            self.talkBtn.hidden = YES;
        } else {
            self.careBtn.hidden = NO;
            self.talkBtn.hidden = NO;
        }
        
        if (contentOffset <= -596.00) {
            self.careBtn.hidden = NO;
            self.talkBtn.hidden = NO;
        }
        
        self.currentY = contentOffset;
    } else if ([self.isOwn isEqualToString:@"Own"]) {
        if (self.currentY < contentOffset) {
            self.createDyBtn.hidden = YES ;
        } else {
            self.createDyBtn.hidden = NO ;
        }
        if (contentOffset <= -596.00) {
            self.createDyBtn.hidden = NO ;
        }
        
        self.currentY = contentOffset;
    }
    
    self.navBGView.alpha = progress;
}
    
// 返回列表的高度 默认是控制器的高度大小
//- (CGFloat)pageViewController:(YNPageViewController *)pageViewController heightForScrollViewAtIndex:(NSInteger)index {
//
//    return 400;
//}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"----click 轮播图 index %ld", (long)index);
}
    
//- (NSString *)pageViewController:(YNPageViewController *)pageViewController customCacheKeyForIndex:(NSInteger)index {
//    return self.cacheKeyArray[index];
//}
    
- (void)pageViewController:(YNPageViewController *)pageViewController didScrollMenuItem:(UIButton *)itemButton index:(NSInteger)index {
    NSLog(@"didScrollMenuItem index %ld", (long)index);
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

// 返回
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
// 关注
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
// 发布动态
- (UIButton *)createDyBtn {
    if (!_createDyBtn) {
        _createDyBtn = [UIButton new];
        _createDyBtn.backgroundColor = kSetUpCololor(61, 121, 253, 0.8);
        [_createDyBtn setTitle:@"发 布" forState:UIControlStateNormal];
        [_createDyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _createDyBtn.titleLabel.font = HPFontSize(15);
        _createDyBtn.hidden = YES;
        [_createDyBtn addTarget:self action:@selector(createDyAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _createDyBtn;
}
// 聊天
- (UIButton *) talkBtn {
    if (!_talkBtn) {
        _talkBtn = [UIButton new];
        _talkBtn.backgroundColor = kSetUpCololor(61, 121, 253, 0.8);
        [_talkBtn setTitle:@"聊 天" forState:UIControlStateNormal];
        [_talkBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _talkBtn.titleLabel.font = HPFontSize(15);
        [_talkBtn addTarget:self action:@selector(talkAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _talkBtn;
}

// 礼物
- (UIButton *)giftBtn {
    if(!_giftBtn) {
        _giftBtn = [UIButton new];
        _giftBtn.backgroundColor = HPUIColorWithRGB(0x000000, 0.5);
        _giftBtn.layer.cornerRadius = 20;
        _giftBtn.layer.masksToBounds = YES;
        [_giftBtn setImage:[UIImage imageNamed:@"discover_3_0"] forState:UIControlStateNormal];
        [_giftBtn addTarget:self action:@selector(giftAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _giftBtn;
}

- (void) alertShow: (HP_HomeModel *) user {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"购买 %@ 联系方式需要消耗您 %@ H币",HPNULLString(user.nickname) ? user.NICKNAME : user.nickname,@"108"] preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击确认");
    }]];
    // 由于它是一个控制器 直接modal出来就好了
    [self presentViewController:alertController animated:YES completion:nil];
}

// 发布动态
-(void) jumpCreateDyVC {
    __weak typeof (self) weakSelf = self;
    HP_CreateDyViewController * createDyVC = [HP_CreateDyViewController new];
    HP_NavigationViewController * createDyNav = [[HP_NavigationViewController alloc] initWithRootViewController:createDyVC];
     [weakSelf presentViewController:createDyNav animated:YES completion:nil];
}

- (void) navBar {
    self.navBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HPScreenW, k_top_height)];
    self.navBGView.backgroundColor = [UIColor whiteColor];
    
    UILabel * titleLabel = [UILabel new];
    titleLabel.font = HPFontSize(18);
    titleLabel.textColor = HPUIColorWithRGB(0x282828,1.0);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = HPNULLString(self.user.nickname) ? self.user.NICKNAME : self.user.nickname;
    [self.navBGView addSubview:titleLabel];
    
    UIButton * backBtn = [[UIButton alloc] init];
    [backBtn setImage:[UIImage imageNamed:@"lefterbackicon_titlebar_24x24_"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navBGView addSubview:backBtn];
    
    self.navGiftBtn = [[UIButton alloc] init];
    [self.navGiftBtn setImage:[UIImage imageNamed:@"discover_3_0"] forState:UIControlStateNormal];
    [self.navGiftBtn addTarget:self action:@selector(giftAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navBGView addSubview:self.navGiftBtn];
    
    [backBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (HPFit(17));
        make.bottom.mas_equalTo (-HPFit(11));
        make.width.height.mas_equalTo (HPFit(20));
    }];
    
    [self.navGiftBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo (-HPFit(24));
        make.width.height.bottom.mas_equalTo (backBtn);
    }];
    
    [titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (backBtn.mas_right).offset(HPFit(15));
        make.right.mas_equalTo (self.navGiftBtn.mas_left) .offset (-HPFit(15));
        make.centerY.mas_equalTo (backBtn.mas_centerY);
    }];
    
    [self.view addSubview:self.navBGView];
}

@end
