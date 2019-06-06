//
//  NSString+trim.m
//  类别
//
//  Created by 栾金鑫 on 15/4/24.
//  Copyright (c) 2015年 luanjinxin. All rights reserved.
//

#import "NSString+trim.h"

@implementation NSString (trim)

-(NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
