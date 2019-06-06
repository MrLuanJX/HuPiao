//
//  HP_TabbarViewController.m
//  HuPiao
//
//  Created by 栾金鑫 on 2019/5/19.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "HP_TabbarViewController.h"
#import "HP_NavigationViewController.h"
#import "HP_MessageViewController.h"
#import "HP_MineViewController.h"
#import "HP_DynamicViewController.h"
#import "HP_HomeViewController.h"

#import "HP_HomeBaseViewController.h"
#import "MomentUtil.h"

@interface HP_TabbarViewController () <UITabBarControllerDelegate>

@end

@implementation HP_TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTab];

    // 初始化
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [MomentUtil initMomentData];
    });
}

-(void) createTab{
    HP_HomeViewController * homeVC = [HP_HomeViewController new];
//    HP_HomeBaseViewController  * homeVC=[HP_HomeBaseViewController new];
    HP_MineViewController * mineVC = [HP_MineViewController new];
    HP_MessageViewController * messageVC = [HP_MessageViewController new];
    HP_DynamicViewController * dynamicVC = [HP_DynamicViewController new];
    
    HP_NavigationViewController * homeNav=[self createVC:homeVC Title:@"广场" imageName:@"home_normal" SelectImageName:@"home_highlight"];
    HP_NavigationViewController * dyNav=[self createVC:dynamicVC Title:@"动态" imageName:@"fishpond_normal" SelectImageName:@"fishpond_highlight"];
    HP_NavigationViewController * xxNav=[self createVC:messageVC Title:@"消息" imageName:@"message_normal" SelectImageName:@"message_highlight"];
    HP_NavigationViewController * mineNav=[self createVC:mineVC Title:@"我的" imageName:@"account_normal" SelectImageName:@"account_highlight"];
    
    self.viewControllers = @[homeNav,dyNav,xxNav,mineNav];
    
    [self.tabBar setShadowImage:[UIImage imageWithColor:HPUIColorWithRGB(0xE0E0E0, 1.0)]];
    
    [self.tabBar setBackgroundImage:[[UIImage alloc]init]];
    
    [self setItems];
    
    self.delegate = self;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
}

#pragma mark 判断是否登录若没登录跳转到登录页面
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
//    if([viewController.tabBarItem.title isEqualToString:@"我的"]){
//
//        return NO;
//    }
    return YES;
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    NSInteger index = [self.tabBar.items indexOfObject:item];
    
    [self animationWithIndex:index];
}
    
- (void)animationWithIndex:(NSInteger) index {
    
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    
    for (UIView *tabBarButton in self.tabBar.subviews) {
        
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.2;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    [[tabbarbuttonArray[index] layer]
     addAnimation:pulse forKey:nil];
}
    
#pragma mark - 修改TabBar高度
- (void)viewWillLayoutSubviews{
    
    CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
    tabFrame.size.height = 55;
    tabFrame.origin.y = HPScreenH- 55;
    
    if ((void)(SAFE_AREA_INSETS_BOTTOM),safeAreaInsets().bottom > 0.0) {
        tabFrame.size.height=89;
        tabFrame.origin.y = HPScreenH- 89;
    }
    self.tabBar.frame = tabFrame;
    self.tabBar.backgroundColor=[UIColor whiteColor];
}

#pragma mark - private method
- (HP_NavigationViewController *)createVC:(UIViewController *)vc Title:(NSString *)title imageName:(NSString *)imageName SelectImageName:(NSString*)selectName{
    
    HP_NavigationViewController * NVI = [[HP_NavigationViewController alloc]initWithRootViewController:vc];
    vc.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return NVI;
}

/**
 *  设置item文字属性
 */
- (void)setItems{
    //设置文字属性
    NSMutableDictionary *attrsNomal = [NSMutableDictionary dictionary];
    //文字颜色
    attrsNomal[NSForegroundColorAttributeName] =  HPUIColorWithRGB(0x333333, 1.0);
    //文字大小
    attrsNomal[NSFontAttributeName] = HPFontSize(10);
    NSMutableDictionary *attrsSelected = [NSMutableDictionary dictionary];
    //选中文字颜色
    attrsSelected[NSForegroundColorAttributeName] = HPThemeColor;
    //统一整体设置
    UITabBarItem *item = [UITabBarItem appearance]; //拿到底部的tabBarItem
    [item setTitleTextAttributes:attrsNomal forState:UIControlStateNormal];
    [item setTitleTextAttributes:attrsSelected forState:UIControlStateSelected];
}


@end
