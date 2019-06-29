//
//  HP_HomeHandler.m
//  HuPiao
//
//  Created by 栾金鑫 on 2019/6/29.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "HP_HomeHandler.h"

@implementation HP_HomeHandler

+(void)executeHomeRequestWithIndex:(NSInteger)currentIndex CurrentPage:(NSInteger)currentPage MemberNO:(NSString *)memberNo Success:(Success)success Fail:(Failed)fail {
    
    NSDictionary * dict = @{
                            @"op" : [NSString stringWithFormat:@"%ld",currentIndex],
                            @"top" : @"10",
                            @"page" : [NSString stringWithFormat:@"%ld",currentPage],
                            @"member_no" : memberNo,
                            @"t" : [HPDivisableTool getNowTimeTimestamp],
                            @"sign" : [NSString md5:[NSString stringWithFormat:@"%@%@%@%@%@%@",memberNo,[NSString stringWithFormat:@"%ld",currentIndex],[NSString stringWithFormat:@"%ld",currentPage],[HPDivisableTool getNowTimeTimestamp],@"10",HPKey]],
                            };
    NSLog(@"dict =   %@----%@",dict,HP_Home);
    
    [DJZJ_RequestTool LJX_requestWithType:LJX_POST URL:HP_Home params:dict successBlock:^(id obj) {
        NSLog(@"homeObj = %@",obj);
        
        if ([obj[@"errorCode"] integerValue] == 0) {
            success(obj);
        } else {
            fail(obj);
        }
    } failureBlock:^(NSError *error) {
        fail(error);
        NSLog(@"error = %@",error);
    }];
}

@end
