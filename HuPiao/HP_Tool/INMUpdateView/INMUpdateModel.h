//
//  INMUpdateModel.h
//  ainanming
//
//  Created by 盛世智源 on 2018/11/15.
//  Copyright © 2018年 陆义金. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum :NSInteger{
    canCancelType,      // 非强制更新
    forceUpdateType     // 强制更新
} INMUpdateType;

@interface INMUpdateModel : NSObject

@property (nonatomic , copy) NSString * content;                // 更新内容

@property (nonatomic , copy) NSString * versionCode;            // versionCode

@property (nonatomic , assign) INMUpdateType type;              // updateType

@end

NS_ASSUME_NONNULL_END
