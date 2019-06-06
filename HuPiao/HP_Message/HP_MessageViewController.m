//
//  HP_MessageViewController.m
//  HuPiao
//
//  Created by 栾金鑫 on 2019/5/19.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "HP_MessageViewController.h"
#import "HP_MineViewController.h"
#import "HP_MessageListViewController.h"
#import "HP_ContactsViewController.h"

@interface HP_MessageViewController () <WMPageControllerDataSource,WMPageControllerDelegate>

@property (nonatomic , strong) NSMutableArray * models;
    
@property (nonatomic , assign) NSInteger currentIndex;
    
@end

@implementation HP_MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (instancetype)init {
    if (self = [super init]) {
        
        self.delegate = self;
        self.dataSource = self;
        self.showOnNavigationBar = YES;
        self.menuViewStyle = WMMenuViewStyleFlood;
        self.progressColor = HPUIColorWithRGB(0x3D79FD, 1.0);
        self.titleColorNormal = HPUIColorWithRGB(0x3D79FD, 1.0);
        self.titleColorSelected = HPUIColorWithRGB(0xffffff, 1.0);
        self.itemMargin = 10;
        self.menuItemWidth = HPFit(80);
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
    
    HP_MessageListViewController * detailVC = [[HP_MessageListViewController alloc]init];
    HP_ContactsViewController * contactsVC = [HP_ContactsViewController new];
    return  index == 0 ? detailVC : contactsVC;
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
        _models = [NSMutableArray arrayWithObjects:@"消息",@"通讯录", nil];
    }
    return _models;
}
@end
