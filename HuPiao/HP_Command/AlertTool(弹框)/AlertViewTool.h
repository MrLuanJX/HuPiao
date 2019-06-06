//
//  ZKAlertView.h
//  ZKAlertViewDemo
//
//  Created by 王文壮 on 16/1/13.
//  Copyright © 2016年 ZKTeam. All rights reserved.
//

/*
 *******************************************************
 *                                                      *
 * 感谢您的支持，如果下载的代码在使用过程中出现 Bug 或者其他问题   *
 * 您可以发邮件到1020304029@qq.com 或者到                     *
 * https://github.com/WangWenzhuang/ZKAlertView 提交问题   *
 *                                                      *
 *******************************************************
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^ZKClickAtIndexBlock)(UIAlertView *alertView, NSInteger buttonIndex);
@interface AlertViewTool : NSObject <UIAlertViewDelegate>


/**
 
UIAlertControllerStyle
 @param title 标题
 @param message 描述内容
 @param actionTitles 按钮数组
 @param preferredStyle 处理
 @param handler 处理
 */
+ (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message actionTitles:(NSArray *)actionTitles  preferredStyle:(UIAlertControllerStyle)preferredStyle handler:(void(^)(NSUInteger buttonIndex, NSString *buttonTitle))handler;

/**
 *  显示一个按钮，包含回调 Block
 *
 *  @param title       标题
 *  @param messge      消息
 *  @param block       回调 Block
 *  @param buttonTitle 按钮标题
 *
 *  @return UIAlertView
 */
+ (UIAlertView *)showAlertWithTitle:(NSString*)title message:(NSString *)messge clickAtIndex:(ZKClickAtIndexBlock) block buttonTitle:(NSString*)buttonTitle;

/**
 *  显示多个按钮，包含回调 Block
 *
 *  @param title             标题
 *  @param messge            消息
 *  @param block             回调 Block
 *  @param cancleButtonTitle 取消按钮标题
 *  @param otherButtonTitles 按钮标题，可输入 N 个
 *
 *  @return UIAlertView
 */
+ (UIAlertView *)showAlertWithTitle:(NSString*)title message:(NSString *)messge clickAtIndex:(ZKClickAtIndexBlock) block cancleButtonTitle:(NSString *)cancleButtonTitle otherButtonTitles:(NSString*)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 *  显示一个按钮，用于提示，不包含 Block
 *
 *  @param title       标题
 *  @param messge      消息
 *  @param buttonTitle 按钮标题
 *
 *  @return UIAlertView
 */
+ (UIAlertView *)showAlertWithTitle:(NSString*)title message:(NSString *)messge buttonTitle:(NSString*)buttonTitle;


/**自定义UIAlertView*/
+ (void)showAlertView:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelButtonTitle otherTitle:(NSString *)otherButtonTitle cancelBlock:(void (^)())cancle confrimBlock:(void (^)())confirm;

@end
