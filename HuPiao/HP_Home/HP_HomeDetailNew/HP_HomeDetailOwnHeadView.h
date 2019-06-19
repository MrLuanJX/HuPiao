//
//  HP_HomeDetailOwnHeadView.h
//  HuPiao
//
//  Created by a on 2019/5/31.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface HP_HomeDetailOwnHeadView : UIView

@property (nonatomic , copy) void(^weChatActionBlock)(void);

@property (nonatomic , strong) MUser * user;

@property (nonatomic , strong) UIButton * weChatBtn;                // 微信

@end

NS_ASSUME_NONNULL_END
