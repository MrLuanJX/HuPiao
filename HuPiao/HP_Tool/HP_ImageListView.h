//
//  HP_ImageListView.h
//  HuPiao
//
//  Created by a on 2019/5/31.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HP_DyModel.h"

NS_ASSUME_NONNULL_BEGIN

@class HP_ImageView;

@interface HP_ImageListView : UIView
// 动态
@property (nonatomic , strong) HP_DyModel * moment;
// 点击小图
@property (nonatomic , copy) void (^singleTapHandler)(HP_ImageView *imageView);

@end

//### 单个小图显示视图
@interface HP_ImageView : UIImageView

// 点击小图
@property (nonatomic, copy) void (^clickHandler)(HP_ImageView *imageView);

@end

NS_ASSUME_NONNULL_END
