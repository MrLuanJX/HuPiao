//
//  HP_HomeModel.h
//  HuPiao
//
//  Created by 栾金鑫 on 2019/6/29.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HP_HomeModel : NSObject

@property (nonatomic, copy) NSString * sex;
@property (nonatomic, assign) BOOL LOGIN_FLAG;
@property (nonatomic, copy) NSString * PROFILE;         // 个性签名
@property (nonatomic, copy) NSString * MEASUREMENT;     // 三围
@property (nonatomic, copy) NSString * QQ;
@property (nonatomic, copy) NSString * NICKNAME;        // 昵称
@property (nonatomic, copy) NSString * nickname;        // 昵称
@property (nonatomic, copy) NSString * HRADER_IMG;      // 头像
@property (nonatomic, assign) BOOL ONLINE_FLAG;         // 是否在线
@property (nonatomic, copy) NSString * LIKE_COUNT;      // 喜欢数量
@property (nonatomic, copy) NSString * C_DATATIME;      // 创建时间
@property (nonatomic, copy) NSString * HEIGHT;          // 身高
@property (nonatomic, copy) NSString * E_DATATIME;
@property (nonatomic, copy) NSString * CHANNEL_NO;
@property (nonatomic, copy) NSString * LAST_LOGINTIME;  // 上次登录时间
@property (nonatomic, copy) NSString * CONSTELLATION;
@property (nonatomic, copy) NSString * AGE;             // 年龄
@property (nonatomic, copy) NSString * CITY;            // 城市
@property (nonatomic, assign) BOOL WECHAT_VALIDATE;      //
@property (nonatomic, assign) BOOL QQ_VALIDATE;
@property (nonatomic, copy) NSString * BIRTHDAY;        // 出生日期
@property (nonatomic, copy) NSString * INDEX_NO;
@property (nonatomic, copy) NSString * WEIGHT;           // 体重
@property (nonatomic, copy) NSString * PHONE;
@property (nonatomic, copy) NSString * WECHAT;
@property (nonatomic, copy) NSString * EMAIL;
@property (nonatomic, copy) NSString * ALIPAY;
@property (nonatomic, assign) BOOL ALIPAY_VALIDATE;
@property (nonatomic, copy) NSString * EDUCATION;           // 学历
@property (nonatomic, copy) NSString * ACCOUNT;
@property (nonatomic, copy) NSString * FOLLOW_COUNT;        // 粉丝数
@property (nonatomic, assign) BOOL INVALID_FLAG;
@property (nonatomic, assign) BOOL EMAIL_VALIDATE;
@property (nonatomic, copy) NSString * time;            // 出生日期格式化

@property (nonatomic, assign) NSInteger cellHeight;            


@end

NS_ASSUME_NONNULL_END
