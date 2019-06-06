//
//  HP_HomeDetailViewController.m
//  HuPiao
//
//  Created by a on 2019/5/21.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_HomeDetailViewController.h"
#import "HJTabViewControllerPlugin_HeaderScroll.h"
#import "HJTabViewControllerPlugin_TabViewBar.h"
#import "HJDefaultTabViewBar.h"
#import "HP_BaseInformationViewController.h"
#import "HP_BaseAlbumViewController.h"

@interface HP_HomeDetailViewController () <HJTabViewControllerDataSource, HJTabViewControllerDelagate, HJDefaultTabViewBarDelegate , SDCycleScrollViewDelegate>

//@property (nonatomic , strong) SDCycleScrollView * cycleScrollView;

@property (nonatomic , strong) NSMutableArray * dataArray;
    
@property (nonatomic , strong) NSMutableArray * imgArray;

@end

@implementation HP_HomeDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //设置导航栏背景图片为一个无图的image，导航栏会加载空imgae，就自然透明掉了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //同理透明掉导航栏下划线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //导航栏的背景图和下划线都置空，就会回到默认的设置了
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];

    [self.navigationController.navigationBar setShadowImage:nil];
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabDataSource = self;
    self.tabDelegate = self;
    
    HJDefaultTabViewBar *tabViewBar = [HJDefaultTabViewBar new];
    tabViewBar.delegate = self;
    HJTabViewControllerPlugin_TabViewBar *tabViewBarPlugin = [[HJTabViewControllerPlugin_TabViewBar alloc] initWithTabViewBar:tabViewBar delegate:nil];
    [self enablePlugin:tabViewBarPlugin];
    [self enablePlugin:[HJTabViewControllerPlugin_HeaderScroll new]];
    // 聊天
    [self setTalkBtn];
    
}

- (void) setTalkBtn {
    UIButton * talkBtn = [UIButton new];
    talkBtn.layer.cornerRadius = 15;
    talkBtn.backgroundColor = HPThemeColor;
    [talkBtn setTitle:@"私信" forState:UIControlStateNormal];
    [talkBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    talkBtn.titleLabel.font = HPFontSize(13);
    [self.view addSubview:talkBtn];
    
    [talkBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HPFit(44));
        make.right.mas_equalTo(-HPFit(22));
        make.width.height.mas_equalTo(HPFit(30));
    }];
}
    
#pragma mark -
- (NSInteger)numberOfTabForTabViewBar:(HJDefaultTabViewBar *)tabViewBar {
    return [self numberOfViewControllerForTabViewController:self];
}
    
- (id)tabViewBar:(HJDefaultTabViewBar *)tabViewBar titleForIndex:(NSInteger)index {
    return self.dataArray[index];
}
    
- (void)tabViewBar:(HJDefaultTabViewBar *)tabViewBar didSelectIndex:(NSInteger)index {
    BOOL anim = labs(index - self.curIndex) > 1 ? NO: YES;
    [self scrollToIndex:index animated:anim];
}

#pragma mark -
- (void)tabViewController:(HJTabViewController *)tabViewController scrollViewVerticalScroll:(CGFloat)contentPercentY {
    // 博主很傻，用此方法渐变导航栏是偷懒表现，只是为了demo演示。正确科学方法请自行百度 iOS导航栏透明
//    self.navigationController.navigationBar.alpha = contentPercentY;
}
    
- (NSInteger)numberOfViewControllerForTabViewController:(HJTabViewController *)tabViewController {
    return self.dataArray.count;
}
    
- (UIViewController *)tabViewController:(HJTabViewController *)tabViewController viewControllerForIndex:(NSInteger)index {
    
    if (index == 1) {
        HP_BaseAlbumViewController * albumVC = [HP_BaseAlbumViewController new];
        return albumVC;
    } else {
        HP_BaseInformationViewController * vc = [HP_BaseInformationViewController new];
        return vc;
    }
}
    
- (UIView *)tabHeaderViewForTabViewController:(HJTabViewController *)tabViewController {

    CGRect rect = CGRectMake(0, 0, 0, floor(400.0f));
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:rect];
    headerView.image = [UIImage imageNamed:@"1.jpg"];
    headerView.contentMode = UIViewContentModeScaleAspectFill;
    headerView.userInteractionEnabled = YES;
    
    SDCycleScrollView * cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:rect delegate:self placeholderImage:[UIImage imageNamed:@"1.jpg"]];
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    cycleScrollView.autoScrollTimeInterval = 5.0;
    cycleScrollView.localizationImageNamesGroup = self.imgArray;

    return headerView;   // cycleScrollView;   //
}
    
- (CGFloat)tabHeaderBottomInsetForTabViewController:(HJTabViewController *)tabViewController {
    return HJTabViewBarDefaultHeight + CGRectGetMaxY(self.navigationController.navigationBar.frame);
}
    
- (UIEdgeInsets)containerInsetsForTabViewController:(HJTabViewController *)tabViewController {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

/*
- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, HPScreenW, floor(300.0f)) delegate:self placeholderImage:[UIImage imageNamed:@"1.jpg"]];
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _cycleScrollView.autoScrollTimeInterval = 5.0;
        _cycleScrollView.localizationImageNamesGroup = self.imgArray;
    }
    return _cycleScrollView;
}
*/
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:@"基本资料",@"相册",@"动态", nil];
    }
    return _dataArray;
}
    
- (NSMutableArray *)imgArray {
    if (!_imgArray) {
        _imgArray = [NSMutableArray arrayWithObjects:@"1.jpg",@"1.jpg",@"1.jpg", nil];
    }
    return _imgArray;
}
    
@end
