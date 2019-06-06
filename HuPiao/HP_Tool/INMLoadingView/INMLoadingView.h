//
//  INMLoadingView.h
//  ainanming
//
//  Created by 盛世智源 on 2018/11/23.
//  Copyright © 2018年 陆义金. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface INMLoadingView : UIView

//展示动画
- (void)showInView:(UIView *)view;

//取消动画
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
