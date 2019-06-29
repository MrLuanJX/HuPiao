//
//  HP_HomeModel.m
//  HuPiao
//
//  Created by 栾金鑫 on 2019/6/29.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "HP_HomeModel.h"

@implementation HP_HomeModel

- (NSString *)time {
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:self.BIRTHDAY.longLongValue];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    return [df stringFromDate:time];
}

@end
