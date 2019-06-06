//
//  INMRefreshGifHeader.m
//  ainanming
//
//  Created by 盛世智源 on 2018/11/23.
//  Copyright © 2018年 陆义金. All rights reserved.
//

#import "INMRefreshGifHeader.h"

@implementation INMRefreshGifHeader

- (void)prepare{
    
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 2; i <= 5; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"group_%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 7; i <= 3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"group_%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    // 隐藏状态
    self.stateLabel.hidden = YES;
    // 隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
}

@end
