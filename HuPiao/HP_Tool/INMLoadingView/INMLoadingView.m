//
//  INMLoadingView.m
//  ainanming
//
//  Created by 盛世智源 on 2018/11/23.
//  Copyright © 2018年 陆义金. All rights reserved.
//

#import "INMLoadingView.h"

@interface INMLoadingView ()

@property (nonatomic,weak) UIImageView *imageView;
@property (nonatomic,strong) NSMutableArray *imageArray;

@end

@implementation INMLoadingView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f  blue:0.94f  alpha:1.00f];
    }
    return  self;
}

- (void)showInView:(UIView *)view {
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    [view addSubview:self];
    self.frame = view.bounds;
    self.imageView.frame  = CGRectMake(0, 0, 70, 100);
    self.imageView.center = self.center;
    
    [self.imageView startAnimating];
}

- (void)dismiss {
    [_imageArray removeAllObjects];
    [_imageView stopAnimating];
    [_imageView removeFromSuperview];
    [self removeFromSuperview];
}

- (NSMutableArray *)imageArray {
    
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return  _imageArray;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        
        UIImageView *img = [[UIImageView alloc]init];
        [self addSubview:img];
        _imageView = img;
        for (NSInteger i = 2; i < 5; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"group_%ld", i]];
            [self.imageArray addObject:image];
        }
        self.imageView.animationDuration = 1.0;
        self.imageView.animationRepeatCount = 0;
        self.imageView.animationImages = self.imageArray;
    }
    return _imageView;
}

@end
