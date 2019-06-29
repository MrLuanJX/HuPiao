//
//  HP_UserTool.h
//  HuPiao
//
//  Created by a on 2019/6/27.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface HP_UserTool : NSObject

//@property (nonatomic, strong) MUser *user;

+ (HP_UserTool *)sharedUserHelper;

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

- (void)saveUser;

+ (void)saveUserInfo:(MUser *)userInfo;

@end

NS_ASSUME_NONNULL_END
