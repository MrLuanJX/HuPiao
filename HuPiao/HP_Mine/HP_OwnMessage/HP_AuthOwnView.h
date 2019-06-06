//
//  HP_AuthOwnView.h
//  HuPiao
//
//  Created by a on 2019/6/5.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HP_AuthOwnView : UIView

@property (nonatomic , copy) void(^cellSeleteBlock)(NSIndexPath * index, UITableViewCell * cell);

@property (nonatomic , strong) MUser * user;

@end

NS_ASSUME_NONNULL_END
