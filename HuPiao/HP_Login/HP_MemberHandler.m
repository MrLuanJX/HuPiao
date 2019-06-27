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
+(void)executeLogIn:(NSDictionary*)param Success:(Success)success Fail:(Failed)fail{
    
    
}

/**
 发送验证码
 
 @param param 参数
 @param success 成功
 @param fail 失败
 */
+(void)executeGetCode:(NSDictionary*)param Success:(Success)success Fail:(Failed)fail{
    
    NSLog(@"HP_PhoneCode = %@----%@",HP_PhoneCode,param);
    
    
    [HP_HttpTool INMRequestWithType:POST_INM URL:HP_PhoneCode Paramer:param SuccessBlock:^(id  _Nonnull obj) {
        NSLog(@"phoneCodeObj - %@",obj);
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [WHToast showMessage:@"短信验证码已发送" duration:1.5 finishHandler:nil];
        });
        success(obj);
    } FailureBlock:^(NSError * _Nonnull error) {
         NSLog(@"phoneCodeError - %@",error);
        
    } IsCache:NO];
}

@end
