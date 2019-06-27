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
/*
+ (NSString *)md5:(NSString *)string {
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }
    return result;
}
*/

/**
 *  32位md5加密算法
 *
 *  @param str 传入要加密的字符串
 *
 *  @return NSString
 */
+ (NSString *)md5:(NSString *)string
{
    const char *cStr = [string UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end
