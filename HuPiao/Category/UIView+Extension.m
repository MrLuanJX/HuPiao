//
//  UIView+Extension.m
//  01-黑酷
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setLeft:(CGFloat)left
{
    self.x = left;
}

- (CGFloat)left
{
    return self.x;
}

- (void)setTop:(CGFloat)top
{
    self.y = top;
}

- (CGFloat)top
{
    return self.y;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)right
{
    return CGRectGetMaxX(self.frame);
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return CGRectGetMaxY(self.frame);
}

+ (UIView *)addLineWithFrame:(CGRect)frame WithView:(UIView *)view
{
    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    lineView.backgroundColor = HPLineColor;
    [view addSubview:lineView];
    
    return lineView;
}

+ (UIView *)addLineBackGroundWithFrame:(CGRect)frame color:(UIColor*)color WithView:(UIView *)view
{
    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    lineView.backgroundColor = color;
    [view addSubview:lineView];
    
    return lineView;
}

///创建一个view的对象
+(UIView*)CreateViewWithFrame:(CGRect)frame BackgroundColor:(UIColor*)color InteractionEnabled:(BOOL)enabled{
    
    UIView * view=[[UIView alloc]initWithFrame:frame];
    view.backgroundColor=color;
    view.userInteractionEnabled=enabled;
    return view;
}

- (void)showNoDataImageInView:(UIView *)view withImage:(NSString *)imageName title:(NSString *)title{
    
    [self removeImageView:view];
    
    view.backgroundColor = HPBackgroundColor;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, HPFit(115), HPFit(150), HPFit(150))];
    imageView.size = CGSizeMake(HPFit(150), HPFit(150));
    imageView.centerX = view.centerX;
    imageView.image=[UIImage imageNamed:imageName];
    [view addSubview:imageView];
    imageView.tag=1000;
    
    UILabel *lable = [[UILabel alloc] init];
    lable.text = imageName;
    lable.tag = 1000;
    lable.textColor = HPSubTitleColor;
    lable.font = HPFontSize(18);
    [lable sizeToFit];
    lable.centerX = view.centerX;
    lable.centerY = imageView.bottom + HPFit(15);
    [view addSubview:lable];
    
    UILabel *subLabel = [[UILabel alloc] init];
    subLabel.text = title;
    subLabel.tag = 1000;
    subLabel.textColor = [UIColor lightGrayColor];
    subLabel.font = HPFontSize(15);
    [subLabel sizeToFit];
    subLabel.centerX = view.centerX;
    subLabel.centerY = lable.bottom + HPFit(20);
    [view addSubview:subLabel];

}

- (void)hideNoDataImageInView:(UIView *)view{
    
    [self removeImageView:view];
    
}

- (void)removeImageView:(UIView *)view{
    
    //按照tag值进行移除
    for (UIImageView *subView in view.subviews) {
        
        if (subView.tag == 1000) {
            
            [subView removeFromSuperview];
        }
    }
}

+ (void) getGradientWithFirstColor:(UIColor *)firstColor SecondColor:(UIColor *)secondColor WithView:(UIView *)view {
    CAGradientLayer * gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = @[(id)firstColor.CGColor,(id)secondColor.CGColor];
    gradient.startPoint = CGPointMake(0, 1);
    gradient.endPoint = CGPointMake(1, 0);
    [view.layer addSublayer:gradient];
}

+ (void)addRefreshBGView:(UIView *)BGView ColorArray:(NSArray *)colorArray Locations:(NSArray *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectOffset(BGView.bounds, 0, -BGView.bounds.size.height)];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];  // 设置渐变效果
    gradientLayer.bounds = bgView.bounds;
    gradientLayer.borderWidth = 0;
    gradientLayer.frame = bgView.bounds;
    gradientLayer.colors = colorArray;
    gradientLayer.locations = locations;
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    [bgView.layer insertSublayer:gradientLayer atIndex:0];
    [BGView insertSubview:bgView atIndex:0];
}

/*
 * shadowColor 阴影颜色
 *
 * shadowOpacity 阴影透明度，默认0
 *
 * shadowRadius  阴影半径，默认3
 *
 * shadowPathSide 设置哪一侧的阴影，
 * shadowPathWidth 阴影的宽度，
 */

+ (void)LJX_AddShadowToView:(UIView *)theView SetShadowPathWith:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowSide:(LJXShadowPathSide)shadowPathSide shadowPathWidth:(CGFloat)shadowPathWidth{
    
    theView.layer.masksToBounds = NO;
    theView.layer.shadowColor = shadowColor.CGColor;
    theView.layer.shadowOpacity = shadowOpacity;
    theView.layer.shadowRadius =  shadowRadius;
    theView.layer.shadowOffset = CGSizeZero;
    CGRect shadowRect;
    CGFloat originX = 0;
    CGFloat originY = 0;
    CGFloat originW = theView.bounds.size.width;
    CGFloat originH = theView.bounds.size.height;
    
    switch (shadowPathSide) {
        case LJXShadowPathTop:
            shadowRect  = CGRectMake(originX, originY - shadowPathWidth/2, originW,  shadowPathWidth);
            break;
        case LJXShadowPathBottom:
            shadowRect  = CGRectMake(originX, originH -shadowPathWidth/2, originW, shadowPathWidth);
            break;
            
        case LJXShadowPathLeft:
            shadowRect  = CGRectMake(originX - shadowPathWidth/2, originY, shadowPathWidth, originH);
            break;
            
        case LJXShadowPathRight:
            shadowRect  = CGRectMake(originW - shadowPathWidth/2, originY, shadowPathWidth, originH);
            break;
        case LJXShadowPathNoTop:
            shadowRect  = CGRectMake(originX -shadowPathWidth/2, originY +1, originW +shadowPathWidth,originH + shadowPathWidth/2 );
            break;
        case LJXShadowPathAllSide:
            shadowRect  = CGRectMake(originX - shadowPathWidth/2, originY - shadowPathWidth/2, originW +  shadowPathWidth, originH + shadowPathWidth);
            break;
    }
    UIBezierPath *path =[UIBezierPath bezierPathWithRect:shadowRect];
    theView.layer.shadowPath = path.CGPath;
}


@end
