//
//  Header.h
//  LJXAlertView
//
//  Created by 栾金鑫 on 2019/8/26.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define SAFE_AREA_INSETS_BOTTOM safeAreaInsets().bottom

#import <Masonry.h>
#import "LJXAlertBaseView.h"
#import "LJXAlertView.h"
#import "LJXContentLabel.h"

//16进制颜色设置
#define LJXUIColorWithRGB(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:alphaValue]

/********************屏幕宽和高*******************/
#define LJXScreenW [UIScreen mainScreen].bounds.size.width
#define LJXScreenH [UIScreen mainScreen].bounds.size.height
#define LJXkWindowFrame [[UIScreen mainScreen] bounds]
//window窗口
#define kWindow [UIApplication sharedApplication].keyWindow

//根据屏幕宽度计算对应View的高
#define LJXFit(value) ((value * LJXScreenW) / 375.0f)

/**字体*/
#define LJXFontSize(x) [UIFont systemFontOfSize:(LJXScreenW > 374 ? (LJXScreenW > 375 ? x * 1.1 : x ) : x / 1.1)]
/**加粗字体*/
#define LJXFontBoldSize(x) [UIFont boldSystemFontOfSize:(LJXScreenW > 374 ? (CGFloat)x  : (CGFloat)x / 1.1)]


#endif /* Header_h */
