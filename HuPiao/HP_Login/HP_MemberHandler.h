//
//  HP_MemberHandler.h
//  HuPiao
//
//  Created by a on 2019/6/27.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_BaseHandler.h"

NS_ASSUME_NONNULL_BEGIN

@interface HP_MemberHandler : HP_BaseHandler

/**
 登录
 @param param 登录参数
 @param success 成功
 @param fail 失败
 */
+(void)executeLogInWithType:(NSString*)type UserName:(NSString *)userName Password:(NSString *)password loginCode:(NSString *)loginCode Success:(Success)success Fail:(Failed)fail;

/**
 注册
 @param param 注册参数
 @param success 成功
 @param fail 失败
 */
+(void)executeRegistWithiInvitationCode:(NSString *)invitationCode UserName:(NSString *)userName Password:(NSString *)password PhoneCode:(NSString *)phoneCode NickName:(NSString *)nickName Success:(Success)success Fail:(Failed)fail;

/**
 发送验证码

 @param phoneNum 参数
 @param type 参数     register forgetpwd login
 @param success 成功
 @param fail 失败
 */
+(void)executeGetCodeWithReuqestPhoneNum:(NSString *)phoneNum type:(NSString *)type Success:(Success)success Fail:(Failed)fail;


@end

NS_ASSUME_NONNULL_END
