//
//  HP_MemberHandler.m
//  HuPiao
//
//  Created by a on 2019/6/27.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_MemberHandler.h"

@implementation HP_MemberHandler


/**
 登录
 @param param 登录参数
 @param success 成功
 @param fail 失败
 */
+(void)executeLogInWithType:(NSString*)type UserName:(NSString *)userName Password:(NSString *)password loginCode:(NSString *)loginCode Success:(Success)success Fail:(Failed)fail {
    
    NSDictionary * param = @{
                            @"username" : userName,
                            @"password" : password,
                            @"loginCode" : loginCode,
                            @"type" : type,
                            @"t" : [HPDivisableTool getNowTimeTimestamp],
                            @"sign" : [NSString md5:[NSString stringWithFormat:@"%@%@%@%@%@%@",loginCode,password,[HPDivisableTool getNowTimeTimestamp],type,userName,HPKey]],
                            };
    
    [DJZJ_RequestTool LJX_requestWithType:LJX_POST URL:HP_Login params:param successBlock:^(id obj) {
        NSLog(@"loginObj = %@",obj);

//        if ([obj[@"errorCode"] integerValue] == 0) {
//            MUser * user = [MUser mj_objectWithKeyValues:obj[@"data"]];
//            NSLog(@"user ------ %@",user);
//            success(user);
//        } else {
            success(obj);
//        }
    } failureBlock:^(NSError *error) {
        
        NSLog(@"errorObj = %@",error);

        fail(error);
        
    }];
}

/**
 注册
 @param param 注册参数
 @param success 成功
 @param fail 失败
 */
+(void)executeRegistWithiInvitationCode:(NSString *)invitationCode UserName:(NSString *)userName Password:(NSString *)password PhoneCode:(NSString *)phoneCode NickName:(NSString *)nickName Success:(Success)success Fail:(Failed)fail {

    NSDictionary * param = @{
                            @"username" : userName,
                            @"password" : password,
                            @"phoneCode" : phoneCode,
                            @"nickname" : nickName,
                            @"invitationCode" : invitationCode,
                            @"t" : [HPDivisableTool getNowTimeTimestamp],
                            @"sign" : [NSString md5:[NSString stringWithFormat:@"%@%@%@%@%@%@%@",invitationCode,nickName,password,phoneCode,[HPDivisableTool getNowTimeTimestamp],userName,HPKey]],
                            };
    NSLog(@"param ---- %@---%@",param,[NSString stringWithFormat:@"%@%@%@%@%@%@%@",invitationCode,nickName,password,phoneCode,[HPDivisableTool getNowTimeTimestamp],userName,HPKey]);
    [DJZJ_RequestTool LJX_requestWithType:LJX_POST URL:HP_Regist params:param successBlock:^(id obj) {
        NSLog(@"registObj === %@",obj);
        
        if ([obj[@"errorCode"] integerValue] == 0) {
            MUser * user = [MUser mj_objectWithKeyValues:obj[@"data"]];
            success(user);
        } else {
            NSLog(@"errorMessage === %@",obj[@"errorMessage"]);
            fail(obj);
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"error --- %@",error);
        fail(error);
    }];
}

/**
 发送验证码
 @param phoneNum 参数
 @param type 参数     register forgetpwd login
 @param success 成功
 @param fail 失败
 */
+(void)executeGetCodeWithReuqestPhoneNum:(NSString *)phoneNum type:(NSString *)type Success:(Success)success Fail:(Failed)fail {
    NSDictionary * dict = @{
                            @"phoneNumber" : [phoneNum trim],
                            @"type" : type,
                            @"t" : [HPDivisableTool currentdateInterval],
                            @"code" : @"",
                            @"sign" : [NSString md5:[NSString stringWithFormat:@"%@%@%@%@%@",@"",[phoneNum trim],[HPDivisableTool currentdateInterval],type,HPKey]],
                            };
    
    NSLog(@"dict-----%@-----",dict);
    [DJZJ_RequestTool LJX_requestWithType:LJX_POST URL:HP_PhoneCode params:dict successBlock:^(id obj) {
        NSLog(@"obj = %@",obj);
        if ([obj[@"errorCode"] integerValue] == 0) {
            [WHToast showMessage:@"短信验证码已发送" duration:1.5 finishHandler:nil];
            success(obj);
        } else {
            [WHToast showMessage:obj[@"errorMessage"] duration:1.5 finishHandler:nil];
            fail(obj); // @"短信验证码发送失败，请稍后再试"
        }
    } failureBlock:^(NSError *error) {
        fail(error);
    }];
}

// 极光用户登录
+ (void) loginJGIMUser {
    [JMSGUser loginWithUsername:[HP_UserTool sharedUserHelper].strDisplayName password:[HP_UserTool sharedUserHelper].strDisplayName completionHandler:^(id resultObject, NSError *error) {
        NSLog(@"login --- %@-----%@", resultObject, error);
        // 查看自己IM的个人信息
        JMSGUser * jgUser = [JMSGUser myInfo];
        NSLog(@"jgUser ------ %@",jgUser);
        if (error != nil) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [HP_MemberHandler loginJGIMUser];
            });
        }
        NSLog(@"loginError = %@",error);
    }];
}

// 极光用户注册
// 极光用户注册
+ (void) registJGIMUser { // [HP_UserTool sharedUserHelper].strDisplayName @"11111"
    
    NSLog(@"strDisplayName ----- %@",[HP_UserTool sharedUserHelper].strDisplayName);
    
    [JMSGUser registerWithUsername:[HP_UserTool sharedUserHelper].strDisplayName password:[HP_UserTool sharedUserHelper].strDisplayName completionHandler:^(id resultObject, NSError *error) {
        NSLog(@"resultObject --- %@===%@",resultObject,error);
        if (!HPNULLString(resultObject)) {
            [HP_MemberHandler loginJGIMUser];
        }
    }];
}



@end
