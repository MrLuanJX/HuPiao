//
//  NSString+KJTime.m
//  HuPiao
//
//  Created by 栾金鑫 on 2019/7/3.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "NSString+KJTime.h"

@implementation NSString (KJTime)

//时间戳--->时间
+(NSString *)transToTime:(NSString *)timsp{
    
    NSTimeInterval time=[timsp doubleValue];//如果不使用本地时区,因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];//设置本地时区
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM/dd HH:mm"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    return currentDateStr;
}

//时间戳--->日期
+(NSString *)transToDate:(NSString *)timsp{
    
    NSTimeInterval time=[timsp doubleValue];//如果不使用本地时区,因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];//设置本地时区
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM月dd日"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    return currentDateStr;
}

//时间---->时间戳
+(NSString *)transTotimeSp:(NSString *)time{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]]; //设置本地时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [dateFormatter dateFromString:time];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];//时间戳
    return timeSp;
}

+ (NSString *)time_dateToString:(NSDate *)date{
    
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    
    [dateFormat setDateFormat:@"HH:mm"];
    
    NSString* string=[dateFormat stringFromDate:date];
    
    return string;
}

+ (NSString *)time_dateToStringWithInterval:(NSTimeInterval )interval{
    
    NSInteger min = interval/60;
    
    NSInteger sec = (NSInteger)interval%60;
    
    return [NSString stringWithFormat:@"%.2ld:%.2ld",min,sec];
}

@end
