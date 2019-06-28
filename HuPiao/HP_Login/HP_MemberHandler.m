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
+(void)executeLogIn:(NSDictionary*)param Success:(Success)success Fail:(Failed)fail {
    
    
}

/**
 注册
 @param param 注册参数
 @param success 成功
 @param fail 失败
 */
+(void)executeRegist:(NSDictionary*)param Success:(Success)success Fail:(Failed)fail {
    
    [DJZJ_RequestTool LJX_requestWithType:LJX_POST URL:HP_Regist params:param successBlock:^(id obj) {
        NSLog(@"obj = %@",obj);
        
        if ([obj[@"errorCode"] integerValue] == 0) {
            success(obj);
        } else {
            fail(obj);
        }
    } failureBlock:^(NSError *error) {
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
    
    [DJZJ_RequestTool LJX_requestWithType:LJX_POST URL:HP_PhoneCode params:dict successBlock:^(id obj) {
        NSLog(@"obj = %@",obj);
        if ([obj[@"errorCode"] integerValue] == 0) {
            [WHToast showMessage:@"短信验证码已发送" duration:1.5 finishHandler:nil];
            success(obj);
        } else {
            [WHToast showMessage:@"短信验证码发送失败，请稍后再试" duration:1.5 finishHandler:nil];
            fail(obj);
        }
    } failureBlock:^(NSError *error) {
        fail(error);
    }];
}

@end
