//
//  HPDivisableTool.h
//  HuPiao
//
//  Created by a on 2019/6/3.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HPDivisableTool : NSObject
@property (nonatomic , copy) void (^actionBlock) (void);
@property (nonatomic , copy) void (^openpHotoalbumBlock) (void);

// 是否能被整除
-(BOOL)judgeDivisibleWithFirstNumber:(CGFloat)firstNumber andSecondNumber:(CGFloat)secondNumber;
// 图片改变颜色
+(UIImage*)getDarkImageWithImage:(UIImage*)image WithColor:(UIColor *)color;
// 4位拼空格
+(NSString *)stringByStitchingSpace:(NSString *)string;
// 手机号加空格
+(NSString *)stringByPhoneNumber:(NSString *)phoneNumber;
// 字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

+ (id)toArrayOrNSDictionary:(NSData *)jsonData;

// UIButton点击放大效果
+(void) btnActionAnimationWithBtn:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
