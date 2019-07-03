//
//  HP_OwnHandler.h
//  HuPiao
//
//  Created by 栾金鑫 on 2019/6/29.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HP_OwnHandler : HP_BaseHandler
// 个人主页
+(void)executeAnchorOwnRequestWithIndexNO:(NSString *)indexNO Success:(Success)success Fail:(Failed)fail;

// 关注/取消关注
+(void)executeFollowRequestWithIndexNO:(NSString *)indexNO Type:(NSInteger)type Success:(Success)success Fail:(Failed)fail;


@end

NS_ASSUME_NONNULL_END
