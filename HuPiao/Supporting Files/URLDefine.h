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

#endif /* URLDefine_h */
