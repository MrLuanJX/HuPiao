//
//  MUser.h
//  MomentKit
//
//  Created by LEA on 2019/2/28.
//  Copyright © 2019 LEA. All rights reserved.
//
//  用户Model
//

#import <UIKit/UIKit.h>
#import "JKDBModel.h"

@interface MUser : JKDBModel

// 用户类型 1：自己 0：其他人
@property (nonatomic, assign) int type;
// 名字
@property (nonatomic, copy) NSString * name;
// 账号
@property (nonatomic, copy) NSString * account;
// 头像路径
@property (nonatomic, copy) NSString * portrait;
// 区域
@property (nonatomic, copy) NSString * region;


@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *nikename;
@property (nonatomic, copy) NSString *avatarURL;
@property (nonatomic, copy) NSString *motto;
@property (nonatomic, copy) NSString *phoneNumber;

@property (nonatomic, copy) NSString *pinyin;
@property (nonatomic, copy) NSString *initial;
/*
 *  HP_User
 */
@property (nonatomic, copy) NSString *strMail;
@property (nonatomic, copy) NSString *iGender;
@property (nonatomic, copy) NSString *strPassword;
@property (nonatomic, copy) NSString *iBranch;
@property (nonatomic, copy) NSString *dtLastLoginTime;
@property (nonatomic, copy) NSString *iBean;
@property (nonatomic, copy) NSString *strDisplayName;
@property (nonatomic, copy) NSString *iChannelNo;
@property (nonatomic, copy) NSString *strUserId;
@property (nonatomic, copy) NSString *dtCreateTime;
@property (nonatomic, copy) NSString *strHeaderImg;
@property (nonatomic, copy) NSString *strAccount;
@property (nonatomic, copy) NSString *bIsLogin;
@property (nonatomic, copy) NSString *strPhone;
@property (nonatomic, copy) NSString *bIsVip;
@property (nonatomic, copy) NSString *iMemberNo;
@property (nonatomic, copy) NSString *iFollowCount;

@end

