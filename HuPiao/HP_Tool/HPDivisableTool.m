//
//  HPDivisableTool.m
//  HuPiao
//
//  Created by a on 2019/6/3.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HPDivisableTool.h"

@implementation HPDivisableTool

/**
 *  判断两个浮点数是否整除
 *
 *  @param firstNumber  第一个浮点数(被除数)
 *  @param secondNumber 第二个浮点数(除数,不能为0)
 *
 *  @return 返回值可判定是否整除
 */
-(BOOL)judgeDivisibleWithFirstNumber:(CGFloat)firstNumber andSecondNumber:(CGFloat)secondNumber {
    // 默认记录为整除
    BOOL isDivisible = YES;
    
    if (secondNumber == 0) {
        return NO;
    }
    
    CGFloat result = firstNumber / secondNumber;
    NSString * resultStr = [NSString stringWithFormat:@"%f", result];
    NSRange range = [resultStr rangeOfString:@"."];
    NSString * subStr = [resultStr substringFromIndex:range.location + 1];
    
    for (NSInteger index = 0; index < subStr.length; index ++) {
        unichar ch = [subStr characterAtIndex:index];
        
        // 后面的字符中只要有一个不为0，就可判定不能整除，跳出循环
        if ('0' != ch) {
            //            NSLog(@"不能整除");
            isDivisible = NO;
            break;
        }
    }
    // NSLog(@"可以整除");
    return isDivisible;
}

// 图片改变颜色  kSetUpCololor(225, 225, 225, 1.0)
+(UIImage*)getDarkImageWithImage:(UIImage*)image WithColor:(UIColor *)color{
    if(![image isKindOfClass:[UIImage class]]) {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(image.size,NO, [UIScreen mainScreen].scale);
    //颜色填充
    [color setFill];
    CGRect bounds =CGRectMake(0,0, image.size.width, image.size.height);
    UIRectFill(bounds);
    [image drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    UIImage*highlighted =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return highlighted;
}


#pragma mark - 隔4位空格
+(NSString *)stringByStitchingSpace:(NSString *)string{
    
    NSMutableArray *numberArr = [NSMutableArray array];
    int length = string.length % 4 == 0 ? (int)(string.length / 4) : (int)(string.length / 4 + 1);
    for (int i = 0; i < length; i++) {
        int begin = i * 4;
        int end = (i * 4 + 4) > (int) string.length ? (int)(string.length) : (i * 4 + 4);
        NSString *subString = [string substringWithRange:NSMakeRange(begin, end - begin)];
        [numberArr addObject:subString];
    }
    NSString *cardnbr = @"";
    for (int i = 0; i < length; i++) {
        cardnbr = [cardnbr stringByAppendingFormat:@"%@", [NSString stringWithFormat:@"%@ ",numberArr[i]]];
    }
    
    return cardnbr;
}

+(NSString *)stringByPhoneNumber:(NSString *)phoneNumber{
    NSMutableString * newPhoneNumber = [[NSMutableString alloc]initWithString:phoneNumber];
    [newPhoneNumber insertString:@" " atIndex:3];   //把一个字符串插入另一个字符串中的某一个位置
    [newPhoneNumber insertString:@" " atIndex:8];   //把一个字符串插入另一个字符串中的某一个位置
    NSLog(@"newPhoneNumber: %@",newPhoneNumber);
    
    return newPhoneNumber;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

// 将JSON串转化为字典或者数组
+ (id)toArrayOrNSDictionary:(NSData *)jsonData{
    
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:nil];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
}

/**
 *  字典转换为字符串
 *
 *  @param dic 字典
 *
 *  @return 返回字符串
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}


+ (void) btnActionAnimationWithBtn:(UIButton *)sender FromValue:(CGFloat)fromValue ToValue:(CGFloat)toValue Duration:(CGFloat)duration RepeatCount:(long)repeatCount {
    
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = duration;
    pulse.repeatCount= repeatCount;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:fromValue];
    pulse.toValue= [NSNumber numberWithFloat:toValue];
    pulse.removedOnCompletion = NO;
    [[sender.titleLabel layer] addAnimation:pulse forKey:nil];
    [[sender.imageView layer] addAnimation:pulse forKey:nil];
}

// 获取当前时间戳
+(NSString *)getNowTimeTimestamp {
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a=[dat timeIntervalSince1970];
    
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    
    return timeString;
    
}

+(NSString *)currentdateInterval{
    
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)([datenow timeIntervalSince1970]*1000)];
    
    return timeSp;
    
}




@end
