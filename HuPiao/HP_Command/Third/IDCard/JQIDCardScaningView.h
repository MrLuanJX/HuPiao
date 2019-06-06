//
//  LHSIDCardScaningView.h
//  身份证识别
//
//  Created by HanJunqiang on 2017/2/17.
//  Copyright © 2017年 HanJunqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JQIDCardScaningView : UIView

@property (nonatomic,assign) CGRect facePathRect;


- (void)sp_checkDefualtSetting;

- (void)sp_didGetInfoSuccess;

- (void)sp_checkInfo;

- (void)sp_upload;

- (void)sp_getUsersMostLiked;
@end
