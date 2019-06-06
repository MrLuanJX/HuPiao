//
//  UIButton+Extension.m
//  魔颜
//
//  Created by Meiyue on 15/12/16.
//  Copyright © 2015年 abc. All rights reserved.
//

#import "UIButton+Extension.h"

#pragma mark 内部类 MYExButton
@interface MYExButton : UIButton
@property (copy, nonatomic) TapButtonActionBlock action;
@end



@implementation MYExButton

- (instancetype)init{
    
    if(self = [super init]){
        
        [self addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        [self addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)btnClick:(UIButton *)button{
    
    if(self.action){
        
        self.action(self);
    }
}


@end

@implementation UIButton (MYExtension)

#pragma mark 创建计时器按钮

- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color {
    
    // 倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        // 倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{

                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:title];
                [str addAttribute:NSForegroundColorAttributeName value:mColor range:NSMakeRange(0,title.length)];
                [self setAttributedTitle:str forState:UIControlStateNormal];
                
                self.userInteractionEnabled = YES;
            });
            
        } else {
            int seconds = timeOut % 60;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2d", seconds==0? 60: seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString * title=[NSString stringWithFormat:@"%@%@", timeStr, subTitle];
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:title];
                [str addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0,title.length)];
                [self setAttributedTitle:str forState:UIControlStateNormal];

                self.userInteractionEnabled = NO;
            });
            
            timeOut--;
        }
    });
    
    dispatch_resume(_timer);
}



//  创建普通按钮
+ (instancetype)addCustomButtonWithFrame:(CGRect)frame
                                         title:(NSString *)title
                               backgroundColor:(UIColor *)backgroundColor
                                    titleColor:(UIColor *)titleColor
                                     tapAction:(TapButtonActionBlock)tapAction{
    
    MYExButton *btn = [MYExButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.backgroundColor = backgroundColor;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.clipsToBounds = YES;
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.action = tapAction;
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;

    return btn;
}

//  创建图片按钮
+ (instancetype)addSystemButtonWithFrame:(CGRect)frame
                   NormalBackgroundImageString:(NSString *)imageString
                                     tapAction:(TapButtonActionBlock)tapAction{
    
    MYExButton *btn = [[MYExButton alloc] init];
    btn.frame = frame;
    if (imageString) {
        [btn setBackgroundImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
    }
    btn.clipsToBounds = YES;
    btn.action = tapAction;
    
    return btn;
}

//创建文字和图片按钮
+ (instancetype)addButtonWithFrame:(CGRect)frame
                             title:(NSString *)title
                        titleColor:(UIColor *)titleColor
                              font:(UIFont *)font
                             image:(NSString *)image
                         highImage:(NSString *)highImage
                   backgroundColor:(UIColor *)backgroundColor
                     tapAction:(TapButtonActionBlock)tapAction{
    
    MYExButton *btn = [MYExButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.backgroundColor = backgroundColor;
    
    //设置文字
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;
    
    // 设置图片
    if (image) {
         [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    if (highImage) {

        [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateSelected];
    }
    
    btn.action = tapAction;
    btn.clipsToBounds = YES;
    return btn;    
}

//  创建普通按钮
+ (instancetype)addNoRadiuButtonWithFrame:(CGRect)frame
                                    title:(NSString *)title
                                     font:(UIFont *)font
                          backgroundColor:(UIColor *)backgroundColor
                               titleColor:(UIColor *)titleColor
                                tapAction:(TapButtonActionBlock)tapAction{
    
    MYExButton *btn = [MYExButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.backgroundColor = backgroundColor;
    btn.titleLabel.font = font;
    btn.layer.masksToBounds = YES;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.action = tapAction;
    
    return btn;
}

@end
