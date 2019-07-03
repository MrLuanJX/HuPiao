//
//  URLDefine.h
//  HuPiao
//
//  Created by a on 2019/6/27.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#ifndef URLDefine_h
#define URLDefine_h


#define HP_BaseURL @"http://api.camgou.com/"

#define HP_MemberURL [NSString stringWithFormat:@"%@%@",HP_BaseURL,@"common/interface/Member/"]

#define HP_Regist [NSString stringWithFormat:@"%@%@",HP_MemberURL,@"Register.aspx"]

#define HP_PhoneCode [NSString stringWithFormat:@"%@%@",HP_MemberURL,@"phoneCode.aspx"]

#define HP_Login [NSString stringWithFormat:@"%@%@",HP_MemberURL,@"login.aspx"]

// 首页
#define HP_Home [NSString stringWithFormat:@"%@%@",HP_BaseURL,@"common/interface/index/getlist.aspx"]
// 个人主页
#define HP_Anchor [NSString stringWithFormat:@"%@%@",HP_BaseURL,@"common/interface/Anchor/detail.aspx"]
// 关注/取消关注
#define HP_Follow [NSString stringWithFormat:@"%@%@",HP_BaseURL,@"common/interface/Anchor/Follow.aspx"]

#endif /* URLDefine_h */
