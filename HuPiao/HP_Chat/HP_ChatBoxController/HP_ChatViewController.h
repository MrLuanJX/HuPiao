//
//  HP_ChatViewController.h
//  HuPiao
//
//  Created by a on 2019/6/27.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HP_ChatViewController : HP_BaseViewController
/**
 *  聊天用户数据模型
 */
@property (nonatomic , strong) HP_HomeModel * user;
@property (nonatomic , copy) NSString * navTitle;

@end

NS_ASSUME_NONNULL_END
