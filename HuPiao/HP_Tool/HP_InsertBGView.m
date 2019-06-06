//
//  HP_InsertBGView.m
//  HuPiao
//
//  Created by a on 2019/5/28.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_InsertBGView.h"

@implementation HP_InsertBGView

+ (void)addRefreshBGView:(UIView *)BGView ColorArray:(NSArray *)colorArray Locations:(NSArray *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectOffset(BGView.bounds, 0, -BGView.bounds.size.height)];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];  // 设置渐变效果
    gradientLayer.bounds = bgView.bounds;
    gradientLayer.borderWidth = 0;
    gradientLayer.frame = bgView.bounds;
    gradientLayer.colors = colorArray;/*[NSArray arrayWithObjects:
                                       (id)[kSetUpCololor(61, 121, 253, 1) CGColor],
                                       (id)[kSetUpCololor(61, 121, 253, 1) CGColor], nil]; // INMUIColorWithRGB(0x42a7ff, 1.0)*/
    gradientLayer.locations = locations;
    gradientLayer.startPoint = startPoint;//CGPointMake(0.5, 0.3);
    gradientLayer.endPoint = endPoint;//CGPointMake(0.5, 1.0);
    [bgView.layer insertSublayer:gradientLayer atIndex:0];
    [BGView insertSubview:bgView atIndex:0];
}

@end
