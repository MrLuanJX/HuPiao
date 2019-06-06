//
//  INMHomeRefreshHeader.m
//  ainanming
//
//  Created by 盛世智源 on 2018/12/12.
//  Copyright © 2018年 陆义金. All rights reserved.
//

#import "INMHomeRefreshHeader.h"

@implementation INMHomeRefreshHeader

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state{
    
    MJRefreshCheckState;
    
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.textColor = [UIColor whiteColor];
    switch (state) {
        case MJRefreshStateIdle:
            /** 普通闲置状态 */
            //在这里设置子控件在普通闲置状态的界面展示
            self.stateLabel.text = @"爱南明竭诚为您服务";
            break;
        case MJRefreshStatePulling:
            /** 松开就可以进行刷新的状态 */
            //在这里设置子控件在松开就可以进行刷新的状态的界面展示
            self.stateLabel.text = @"华电科技";
            break;
        case MJRefreshStateRefreshing:
            /** 正在刷新中的状态 */
            //在这里设置子控件在正在刷新中的状态的界面展示
            self.stateLabel.text = @"爱南明正在为您刷新数据";
            break;
        default:
            break;
    }
}

@end
