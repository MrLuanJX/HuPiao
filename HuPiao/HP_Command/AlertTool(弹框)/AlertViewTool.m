//
//  ZKAlertView.m
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

#import "AlertViewTool.h"

#define kRootViewController [UIApplication sharedApplication].keyWindow.rootViewController

@interface AlertViewTool ()

@property(copy,nonatomic)void (^cancelClicked)(void);

@property(copy,nonatomic)void (^confirmClicked)(void);

@end


static ZKClickAtIndexBlock ClickAtIndexBlock;

@implementation AlertViewTool

+ (UIAlertView *)showAlertWithTitle:(NSString *)title message:(NSString *)messge buttonTitle:(NSString *)buttonTitle {
    return [self showAlertWithTitle:title message:messge clickAtIndex:nil buttonTitle:buttonTitle];
}

+ (UIAlertView *)showAlertWithTitle:(NSString *)title message:(NSString *)messge clickAtIndex:(ZKClickAtIndexBlock)block buttonTitle:(NSString *)buttonTitle {
    return [self showAlertWithTitle:title message:messge clickAtIndex:block cancleButtonTitle:buttonTitle otherButtonTitles:nil];
}

+ (UIAlertView *)showAlertWithTitle:(NSString *)title message:(NSString *)messge clickAtIndex:(ZKClickAtIndexBlock)block cancleButtonTitle:(NSString *)cancleButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    UIAlertView  *alertView = [[UIAlertView alloc] initWithTitle:title message:messge delegate:self cancelButtonTitle:cancleButtonTitle otherButtonTitles: nil];
    if (block) {
        ClickAtIndexBlock = [block copy];
    }
    if (otherButtonTitles) {
        id eachObject;
        va_list argumentList;
        if (otherButtonTitles) {
            [alertView addButtonWithTitle:otherButtonTitles];
            va_start(argumentList, otherButtonTitles);
            while ((eachObject = va_arg(argumentList, id))) {
                [alertView addButtonWithTitle:eachObject];
            }
            va_end(argumentList);
        }
    }
    [alertView show];
    return alertView;
}

#pragma mark   UIAlertViewDelegate
+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (ClickAtIndexBlock) {
        ClickAtIndexBlock(alertView, buttonIndex);
    }
}
+ (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    ClickAtIndexBlock = nil;
}

/** Alert  任意多个按键 返回选中的 buttonIndex 和 buttonTitle */
+ (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message actionTitles:(NSArray *)actionTitles  preferredStyle:(UIAlertControllerStyle)preferredStyle handler:(void(^)(NSUInteger buttonIndex, NSString *buttonTitle))handler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    
    if (title) {
        NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:title];
        [alertControllerStr addAttribute:NSForegroundColorAttributeName value:HPUIColorWithRGB(0x323232,1.0) range:NSMakeRange(0, title.length)];
        [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, title.length)];
        [alert setValue:alertControllerStr forKey:@"attributedTitle"];
    }

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        handler(0, @"取消");
    }];
    [alert addAction:cancelAction];
    
    for (int i = 0; i < actionTitles.count; i ++) {
        
        UIAlertAction *confimAction = [UIAlertAction actionWithTitle:actionTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            handler((i + 1), actionTitles[i]);
        }];
        [alert addAction:confimAction];
    }
    
    [kRootViewController presentViewController:alert animated:YES completion:nil];
}

+ (void)showAlertView:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelButtonTitle otherTitle:(NSString *)otherButtonTitle cancelBlock:(void (^)())cancle confrimBlock:(void (^)())confirm {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    // Create the actions.
    
    UIAlertAction *cancelAction;
    if (cancelButtonTitle) {
        
        cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            cancle();
            
        }];
        
        [alertController addAction:cancelAction];
    }
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        confirm();
    }];
    
    // Add the actions.
    
    [alertController addAction:otherAction];
    [viewController presentViewController:alertController animated:YES completion:nil];
}


@end
