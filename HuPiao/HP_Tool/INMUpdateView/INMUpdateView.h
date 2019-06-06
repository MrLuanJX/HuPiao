//
//  INMUpdateView.h
//  ainanming
//
//  Created by 盛世智源 on 2018/11/14.
//  Copyright © 2018年 陆义金. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "INMUpdateModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface INMUpdateView : UIView

@property (nonatomic , copy) void(^updateBlcok)(void);

@property (nonatomic , strong) INMUpdateModel * updateModel;

+ (instancetype)showUpdateView;

- (void)show ;

@end

NS_ASSUME_NONNULL_END
