//
//  HP_FollowAndFansViewController.h
//  HuPiao
//
//  Created by a on 2019/6/6.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HP_FollowAndFansCell : UITableViewCell

@property (nonatomic, strong) MUser * user;

@property (nonatomic , copy) void (^isCaredBlock) (UIButton * isCaredBtn);

@end

@interface HP_FollowAndFansViewController : UIViewController

@property (nonatomic , assign) BOOL fans;

@end

NS_ASSUME_NONNULL_END
