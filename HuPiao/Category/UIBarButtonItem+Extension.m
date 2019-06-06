//
//  UIBarButtonItem+Extension.m

//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
/**
 *  创建一个item
 *  
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param image     图片
 *  @param highImage 高亮的图片
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage isLeftBtn:(BOOL)isLeftBtn {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置尺寸
//    btn.size = btn.currentImage.size;
    if (isLeftBtn == YES) {
        btn.size = CGSizeMake(btn.currentImage.size.width + HPFit(15), btn.currentImage.size.height + HPFit(15));
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -HPFit(30), 0, 0);
    }else {
        btn.size = CGSizeMake(btn.currentImage.size.width + HPFit(15), btn.currentImage.size.height + HPFit(15));
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, HPFit(5), 0, 0);
    }
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

/**
 *  创建一个item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action Title:(NSString *)title TitleColor:(UIColor *)titleColor{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];  // ANMZHThemeColor
    [btn setTitleColor:[UIColor colorWithWhite:0.5 alpha:0.5] forState:UIControlStateHighlighted];  // ANMUIColorWithRGB(0xf8c112,0.6)
    btn.titleLabel.font = HPFontSize(16);
    [btn sizeToFit];
    
    // 设置尺寸
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
