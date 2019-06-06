//
//  HP_MineHeadView.h
//  HuPiao
//
//  Created by a on 2019/6/4.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HP_MineHeadView : UIImageView

@property (nonatomic , copy) void(^jumpOwnPage)(void);

@property (nonatomic , copy) void(^jumpOwnMessagePage)(void);

@property (nonatomic , copy) void(^followAction)(NSInteger tag);

@property (nonatomic, strong) HP_ImageView * backImageView;

@property (nonatomic , strong) MUser * user;

@end

NS_ASSUME_NONNULL_END
