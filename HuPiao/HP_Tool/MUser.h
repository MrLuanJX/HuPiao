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


@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *nikename;
@property (nonatomic, strong) NSString *avatarURL;
@property (nonatomic, strong) NSString *motto;
@property (nonatomic, strong) NSString *phoneNumber;

@property (nonatomic, strong) NSString *pinyin;
@property (nonatomic, strong) NSString *initial;

@end

