//
//  HP_SignViewController.h
//  HuPiao
//
//  Created by a on 2019/6/6.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HP_SignViewController : UIViewController

@property (nonatomic , assign) int maxLength;

@property (nonatomic , assign) BOOL feedBack;

@property (nonatomic , copy) NSString * sendBtnTitle;

@end

NS_ASSUME_NONNULL_END
