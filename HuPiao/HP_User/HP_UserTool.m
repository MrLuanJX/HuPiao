//
//  HP_UserTool.m
//  HuPiao
//
//  Created by a on 2019/6/27.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_UserTool.h"

static HP_UserTool *userHelper = nil;

@implementation HP_UserTool

+ (HP_UserTool *)sharedUserHelper {
    if (userHelper == nil) {
        userHelper = [[HP_UserTool alloc] init];
    }
    return userHelper;
}

- (MUser *) user {
    if (_user == nil) {
        _user = [[MUser alloc] init];
        _user.username = @"Bay、栢";// 名字
        _user.userID = @"li-bokun";// ID
        _user.avatarURL = @"0.jpg";// 图片
    }
    return _user;
}

@end
