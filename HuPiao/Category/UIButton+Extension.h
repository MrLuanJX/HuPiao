//
//  UIButton+Extension.h
//  魔颜
//
//  Created by Meiyue on 15/12/16.
//  Copyright © 2015年 abc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapButtonActionBlock) (UIButton *button) ;

@interface UIButton (MYExtension)
//  创建普通按钮
+ (instancetype)addNoRadiuButtonWithFrame:(CGRect)frame
                                    title:(NSString *)title
                                     font:(UIFont *)font
                          backgroundColor:(UIColor *)backgroundColor
                               titleColor:(UIColor *)titleColor
                                tapAction:(TapButtonActionBlock)tapAction;


/*
 *    倒计时按钮
 *    @param timeLine  倒计时总时间
 *    @param title     还没倒计时的title
 *    @param subTitle  倒计时的子名字 如：时、分
 *    @param mColor    还没倒计时的颜色
 *    @param color     倒计时的颜色
 */

- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;


/**
 *  快速创建文字Button
 *
 *  @param frame           frame
 *  @param title           title
 *  @param backgroundColor 背景颜色
 *  @param titleColor      文字颜色
 *  @param tapAction       回调
 */
+ (instancetype)addCustomButtonWithFrame:(CGRect)frame
                                         title:(NSString *)title
                               backgroundColor:(UIColor *)backgroundColor
                                    titleColor:(UIColor *)titleColor
                                     tapAction:(TapButtonActionBlock)tapAction;
/**
 *   快速创建图片Button
 *
 *  @param frame       frame
 *  @param imageString 按钮的背景图片
 *  @param tapAction   回调
 */
+ (instancetype)addSystemButtonWithFrame:(CGRect)frame
                   NormalBackgroundImageString:(NSString *)imageString
                                     tapAction:(TapButtonActionBlock)tapAction;

/**
 *   快速创建文字和图片Button
 *
 *  @param frame       frame
 *  @param image       按钮的正常图片
 *  @param highImage   高亮状态的图片
 *  @param tapAction   回调
 */
+ (instancetype)addButtonWithFrame:(CGRect)frame
                             title:(NSString *)title
                        titleColor:(UIColor *)titleColor
                              font:(UIFont *)font
                             image:(NSString *)image
                         highImage:(NSString *)highImage
                   backgroundColor:(UIColor *)backgroundColor
                         tapAction:(TapButtonActionBlock)tapAction;





@end
