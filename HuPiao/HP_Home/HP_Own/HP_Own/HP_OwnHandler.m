//
//  HP_OwnHandler.m
//  HuPiao
//
//  Created by 栾金鑫 on 2019/6/29.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "HP_OwnHandler.h"

@implementation HP_OwnHandler

+(void)executeAnchorOwnRequestWithIndexNO:(NSString *)indexNO Success:(Success)success Fail:(Failed)fail {
    NSDictionary * dict = @{
                            @"anchor_no" : indexNO,
                            @"member_no" : [HP_UserTool sharedUserHelper].iMemberNo,
                            @"t" : [HPDivisableTool getNowTimeTimestamp],
                            @"sign" : [NSString md5:[NSString stringWithFormat:@"%@%@%@%@",indexNO,[HP_UserTool sharedUserHelper].iMemberNo,[HPDivisableTool getNowTimeTimestamp],HPKey]],
                            };
    
    [DJZJ_RequestTool LJX_requestWithType:LJX_POST URL:HP_Anchor params:dict successBlock:^(id obj) {
        NSLog(@"anchorOBJ ---- %@",obj);
        if ([obj[@"errorCode"] integerValue] == 0) {
            success(obj);
        } else {
            fail(obj);
        }
    } failureBlock:^(NSError *error) {
        fail(error);
    }];
}

@end
