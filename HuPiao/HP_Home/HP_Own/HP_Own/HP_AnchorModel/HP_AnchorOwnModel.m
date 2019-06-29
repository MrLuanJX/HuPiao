//
//  HP_AnchorOwnModel.m
//  HuPiao
//
//  Created by 栾金鑫 on 2019/6/29.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "HP_AnchorOwnModel.h"

@implementation HP_AnchorOwnModel

+ (NSDictionary *)objectClassInArray{
    return @{
             @"csoCommentLColl" : @"HP_CsoCommentLColl",
             @"csoGiftSendMemberColl" : @"HP_CsoGiftSendMemberColl",
             @"csoFreeImageColl" : @"HP_CsoFreeImageColl",
             @"csoImageColl" : @"HP_CsoImageColl",
             @"csoGiftColl" : @"HP_CsoGiftColl",
             };
}

@end
