//
//  HP_Message.h
//  HuPiao
//
//  Created by a on 2019/6/3.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKDBModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HP_Message : JKDBModel

// 名字
@property (nonatomic, copy) NSString * userName;
// 头像路径
@property (nonatomic, copy) NSString * userPortrait;
// 聊天内容
@property (nonatomic, copy) NSString * content;
// 时间戳
@property (nonatomic, assign) long long time;

@end

NS_ASSUME_NONNULL_END
