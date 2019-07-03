//
//  HP_UserTool.m
//  HuPiao
//
//  Created by a on 2019/6/27.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_UserTool.h"

@implementation HP_UserTool

+(HP_UserTool *)sharedUserHelper {
    static HP_UserTool *_userHelper = nil;
    static dispatch_once_t configsOnce;
    dispatch_once(&configsOnce, ^{
        _userHelper = [[HP_UserTool alloc] init];
    });
    return _userHelper;
}

+ (void)saveUserInfo:(MUser *)userInfo {
    NSUserDefaults * tokenUDF = [NSUserDefaults standardUserDefaults];
    [tokenUDF setValue:userInfo.strAccount forKey:@"strAccount"];
    [tokenUDF setValue:userInfo.iMemberNo forKey:@"iMemberNo"];
    [tokenUDF setValue:userInfo.strPhone forKey:@"strPhone"];
    [tokenUDF setValue:userInfo.strHeaderImg forKey:@"strHeaderImg"];
    [tokenUDF setValue:userInfo.strUserId forKey:@"strUserId"];
    [tokenUDF setValue:userInfo.strDisplayName forKey:@"strDisplayName"];
    [tokenUDF setValue:userInfo.iFollowCount forKey:@"iFollowCount"];
    [tokenUDF synchronize];
}

- (void)saveUser {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.strAccount = [defaults objectForKey:@"strAccount"];
    self.iMemberNo = [defaults objectForKey:@"iMemberNo"];
    self.strPhone = [defaults objectForKey:@"strPhone"];
    self.strHeaderImg = [defaults objectForKey:@"strHeaderImg"];
    self.strUserId = [defaults objectForKey:@"strUserId"];
    self.strDisplayName = [defaults objectForKey:@"strDisplayName"];
    self.iFollowCount = [defaults objectForKey:@"iFollowCount"];
}

//- (MUser *) user {
//    if (_user == nil) {
//        _user = [[MUser alloc] init];
//        _user.username = @"Bay、栢";// 名字
//        _user.userID = @"li-bokun";// ID
//        _user.avatarURL = @"0.jpg";// 图片
//    }
//    return _user;
//}

@end
