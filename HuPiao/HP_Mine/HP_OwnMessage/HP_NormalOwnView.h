//
//  HP_NormalOwnView.h
//  HuPiao
//
//  Created by a on 2019/6/5.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HP_NormalOwnView : UIView

@property (nonatomic , copy) void(^iconClickBlock)(void);
@property (nonatomic , copy) void(^commitClickBlock)(void);

@property (nonatomic , strong) MUser * user;

@end

NS_ASSUME_NONNULL_END
