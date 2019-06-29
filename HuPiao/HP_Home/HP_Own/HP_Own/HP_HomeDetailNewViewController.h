//
//  HP_HomeDetailNewViewController.h
//  HuPiao
//
//  Created by a on 2019/5/23.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface HP_HomeDetailNewViewController : YNPageViewController
    
+ (instancetype)suspendCenterPageVCWithUser:(HP_HomeModel *)user IsOwn:(NSString *)isOwn;

+ (instancetype)suspendCenterPageVCWithConfig:(YNPageConfigration *)config WithUser:(HP_HomeModel *)user IsOwn:(NSString *)isOwn;

@property(nonatomic , strong) HP_HomeModel * user;

@end

NS_ASSUME_NONNULL_END
