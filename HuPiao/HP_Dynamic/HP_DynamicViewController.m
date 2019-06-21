//
//  HP_DynamicViewController.m
//  HuPiao
//
//  Created by a on 2019/5/23.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_DynamicViewController.h"
#import "HP_MineViewController.h"
#import "HP_DyViewController.h"

@interface HP_DynamicViewController () <WMPageControllerDataSource,WMPageControllerDelegate>
    
@property (nonatomic , strong) NSMutableArray * models;
    
@property (nonatomic , assign) NSInteger currentIndex;

@end

@implementation HP_DynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (instancetype)init {
    if (self = [super init]) {
        
        self.delegate = self;
        self.dataSource = self;
        self.showOnNavigationBar = YES;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.progressColor = HPUIColorWithRGB(0x3D79FD, 1.0);
        self.titleColorNormal = HPUIColorWithRGB(0x3D79FD, 1.0);//HPUIColorWithRGB(0xffffff, 1.0);
        self.titleColorSelected = HPUIColorWithRGB(0x3D79FD, 1.0);
        self.itemMargin = 10;
        self.menuItemWidth = HPFit(80);
        self.progressViewIsNaughty = YES;
        self.progressWidth = 10;
    }
    return self;
}

#pragma mark - WMPageController 的代理方法
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    if (self.models.count == 0 || !self.models) {
        return 0;
    }
    return self.models.count;
}
    
- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    HP_DyViewController * detailVC = [[HP_DyViewController alloc]init];
    detailVC.isOwn = index == 0 ? @"Dy" : @"";
    return detailVC;
}
    
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.models[index];
}
    
- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}
    
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
    return CGRectMake(leftMargin, originY, self.view.frame.size.width - 2*leftMargin, 44);
}
    
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}
    
#pragma mark - WMMenuView 的代理方法
- (void)menuView:(WMMenuView *)menu didSelesctedIndex:(NSInteger)index currentIndex:(NSInteger)currentIndex {
    [super menuView:menu didSelesctedIndex:index currentIndex:currentIndex];
}
    
-(NSMutableArray *)models{
    if (!_models) {
        _models = [NSMutableArray arrayWithObjects:@"推荐",@"关注", nil];
    }
    return _models;
}
@end
