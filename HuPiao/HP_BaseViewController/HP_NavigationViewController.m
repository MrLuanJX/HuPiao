//
//  HP_NavigationViewController.m
//  HuPiao
//
//  Created by 栾金鑫 on 2019/5/19.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "HP_NavigationViewController.h"

@interface HP_NavigationViewController ()

@end

@implementation HP_NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (void)initialize{
    [self setupNavigationBar];
    [self setupBarBtnItem];
}
    
+(void)setupNavigationBar{
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.barTintColor = [UIColor colorWithWhite:1 alpha:0.7];
    //修改NavigationBar黑线的颜色
    [navBar setShadowImage:[UIImage imageWithColor:HPLineColor size:CGSizeMake(HPScreenW, 0.5)]];
    // title
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSForegroundColorAttributeName] = HPUIColorWithRGB(0x282828,1.0);
    attrDict[NSFontAttributeName] = HPFontSize(18);
    [navBar setTitleTextAttributes:attrDict];
}
    
+(void)setupBarBtnItem{
    UIBarButtonItem *barBtnItem = [UIBarButtonItem appearance];
    // nor
    NSMutableDictionary *norAttrDict = [NSMutableDictionary dictionary];
    norAttrDict[NSForegroundColorAttributeName] = HPUIColorWithRGB(0x323232,1.0);
    [barBtnItem setTitleTextAttributes:norAttrDict forState:UIControlStateNormal];
}
    
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count > 0) {
        // 默认每个push进来的控制器左右都有返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"lefterbackicon_titlebar_24x24_" highImage:@"lefterbackicon_titlebar_24x24_" isLeftBtn:YES];
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
    
#pragma mark 隐藏导航的评价
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
}
    
-(void)back{
    [self popViewControllerAnimated:YES];
    
}
    
-(void)backToMainMenu {
    [self popToRootViewControllerAnimated:YES];
}
    
    
#pragma mark 边缘手势处理
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count <= 1 ) {
        return NO;
    }
    
    return YES;
}


@end
