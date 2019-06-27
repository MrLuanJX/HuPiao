//
//  HP_UserTool.h
//  HuPiao
//
//  Created by a on 2019/6/27.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface HP_UserTool : NSObject

@property (nonatomic, strong) MUser *user;

+ (HP_UserTool *)sharedUserHelper;


@end

NS_ASSUME_NONNULL_END
