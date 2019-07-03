//
//  NSString+KJTime.h
//  HuPiao
//
//  Created by 栾金鑫 on 2019/7/3.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KJTime)

//时间戳--->时间
+(NSString *)transToTime:(NSString *)timsp;

//时间戳--->日期
+(NSString *)transToDate:(NSString *)timsp;

//时间---->时间戳
+(NSString *)transTotimeSp:(NSString *)time;

+ (NSString *)time_dateToString:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
