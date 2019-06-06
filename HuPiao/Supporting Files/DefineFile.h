//
//  DefineFile.h
//  HuPiao
//
//  Created by 栾金鑫 on 2019/5/19.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#ifndef DefineFile_h
#define DefineFile_h

#define SAFE_AREA_INSETS_TOP safeAreaInsets().top
#define SAFE_AREA_INSETS_BOTTOM safeAreaInsets().bottom
/** 程序版本号 */
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
// 弱引用
#define WS(wSelf)               __weak typeof(self) wSelf = self
// 顶部和底部的留白
#define kBlank                  15
// 右侧留白
#define kRightMargin            15
// 头像视图的宽、高
#define kAvatarWidth            40
// 主色调高亮颜色（暗蓝色）
#define kHLTextColor            [UIColor colorWithRed:0.28 green:0.35 blue:0.54 alpha:1.0]

// 状态栏高度
#define k_status_height         [[UIApplication sharedApplication] statusBarFrame].size.height
// 导航栏高度
#define k_nav_height            self.navigationController.navigationBar.height
// 顶部整体高度
#define k_top_height            (k_status_height + k_nav_height)
// iPhone X系列
#define k_iphone_x              (HPScreenH >= 812.0f)
// tabbar高度
#define k_bar_height            (k_iphone_x ? 83.0 : 49.0)

//16进制颜色设置
#define HPUIColorWithRGB(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:alphaValue]
// 按住背景颜色
#define kHLBgColor              [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0]
// 背景颜色
#define k_background_color      [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.0]
//RGB颜色设置
#define kSetUpCololor(RED,GREEN,BLUE,ALPHA) [UIColor colorWithRed:RED/255.0 green:GREEN/255.0 blue:BLUE/255.0 alpha:ALPHA]
//主题色
#define HPThemeColor  HPUIColorWithRGB(0xf8c112,1.0)
//线的颜色
#define HPLineColor  HPUIColorWithRGB(0xeff3f6,1.0)
//透明色
#define HPClearColor [UIColor clearColor]
#define HPSubTitleColor   HPUIColorWithRGB(0x676767,1.0) //子标题的颜色
#define HPBackgroundColor HPUIColorWithRGB(0xeff3f6,1.0)//底灰
//主题色
#define HPZHThemeColor  HPUIColorWithRGB(0xf8c112,1.0)

/********************屏幕宽和高*******************/
#define HPScreenW [UIScreen mainScreen].bounds.size.width
#define HPScreenH [UIScreen mainScreen].bounds.size.height
#define HPkWindowFrame [[UIScreen mainScreen] bounds]
//根据屏幕宽度计算对应View的高
#define HPFit(value) ((value * HPScreenW) / 375.0f)

#define iOS7Later ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f)
#define iOS8Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)

/**字体*/
#define HPFontSize(x) [UIFont systemFontOfSize:(HPScreenW > 374 ? (HPScreenW > 375 ? x * 1.1 : x ) : x / 1.1)]
#define Kfont(R) NAFit(R)  //这里是6sp屏幕字体
/**加粗字体*/
#define HPFontBoldSize(x) [UIFont boldSystemFontOfSize:(HPScreenW > 374 ? (CGFloat)x  : (CGFloat)x / 1.1)]

/**判断字符串是否为空*/
#define HPNULLString(string) ((string == nil) ||[string isEqualToString:@""] ||([string length] == 0)  || [string isKindOfClass:[NSNull class]] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0 ||[string isEqual:[NSNull null]])

#endif /* DefineFile_h */