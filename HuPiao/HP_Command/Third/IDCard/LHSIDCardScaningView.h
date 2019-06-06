//
//  LHSIDCardScaningView.h
//  身份证识别
//
//  Created by HanJunqiang on 2017/2/17.
//  Copyright © 2017年 HanJunqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHSIDCardScaningView : UIView

@property (nonatomic,assign) CGRect facePathRect;


- (void)sp_didUserInfoFailed:(NSString *)isLogin;

- (void)sp_checkUserInfo:(NSString *)string;

- (void)sp_upload:(NSString *)mediaCount;

- (void)sp_getUsersMostLiked:(NSString *)followCount;

- (void)sp_checkNetWorking:(NSString *)string;
@end
