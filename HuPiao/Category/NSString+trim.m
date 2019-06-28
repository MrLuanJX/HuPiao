//
//  NSString+trim.m
//  类别
//
//  Created by 栾金鑫 on 15/4/24.
//  Copyright (c) 2015年 luanjinxin. All rights reserved.
//

#import "NSString+trim.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (trim)

-(NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/**
 *  32位md5加密算法
 *
 *  @param str 传入要加密的字符串
 *
 *  @return NSString
 */
+ (NSString *)md5:(NSString *)string
{
#pragma mark - MD5加密 32位 大写
    //要进行UTF8的转码
    const char* input = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    return digest;
}
@end
