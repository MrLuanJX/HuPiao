//
//  HP_AnchorOwnModel.h
//  HuPiao
//
//  Created by 栾金鑫 on 2019/6/29.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HP_CsoGiftSendMemberColl.h"
#import "HP_CsoCommentLColl.h"
#import "HP_CsoFreeImageColl.h"
#import "HP_CsoImageColl.h"
#import "HP_CsoGiftColl.h"

NS_ASSUME_NONNULL_BEGIN

@interface HP_AnchorOwnModel : NSObject

@property (nonatomic, copy) NSString * strProfile;
@property (nonatomic, copy) NSString * strNickName;        // 昵称
@property (nonatomic, copy) NSString * strBirthday;        
@property (nonatomic, copy) NSString * iFollowCount;
@property (nonatomic, copy) NSString * iBean;
@property (nonatomic, assign) BOOL  bOnLine;
@property (nonatomic, copy) NSString * strWechatPatLastTime;
@property (nonatomic, copy) NSString * strHraderimg;
@property (nonatomic, copy) NSString * strWeight;
@property (nonatomic, copy) NSString * strHeight;
@property (nonatomic, copy) NSString * iWechatPrice;
@property (nonatomic, copy) NSString * strId;
@property (nonatomic, copy) NSString * strMeasurement;
@property (nonatomic, copy) NSString * strAccount;
@property (nonatomic, copy) NSString * strConstellation;
@property (nonatomic, copy) NSString * strTypeId;
@property (nonatomic, copy) NSString * strSex;
@property (nonatomic, assign) BOOL bCheckWechat;
@property (nonatomic, copy) NSString * iOrder;
@property (nonatomic, copy) NSString * strLastLoginTime;
@property (nonatomic, copy) NSString * strAge;
@property (nonatomic, assign) BOOL bIsFollow;
@property (nonatomic, copy) NSString * strEducation;
@property (nonatomic, copy) NSString * iIndex;
@property (nonatomic, copy) NSString * strCity;
@property (nonatomic, copy) NSString * strLikeCount;
@property (nonatomic, copy) NSString * strNotLikeCount;

@property (nonatomic, copy) NSArray * csoLabelColl;
@property (nonatomic, copy) NSString * csoLableText;

@property(nonatomic,copy)NSArray <HP_CsoGiftSendMemberColl *>* csoGiftSendMemberColl;
@property(nonatomic,copy)NSArray <HP_CsoCommentLColl *>* csoCommentLColl;
@property(nonatomic,copy)NSArray <HP_CsoFreeImageColl *>* csoFreeImageColl;
@property(nonatomic,copy)NSArray <HP_CsoImageColl *>* csoImageColl;
@property(nonatomic,copy)NSArray <HP_CsoGiftColl *>* csoGiftColl;

@end

NS_ASSUME_NONNULL_END
