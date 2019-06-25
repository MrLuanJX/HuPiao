//
//  HP_AuthOwnView.h
//  HuPiao
//
//  Created by a on 2019/6/5.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HP_AuthMessageHeadView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HP_AuthOwnView : UIView

@property (nonatomic , copy) void(^cellSeleteBlock)(NSIndexPath * index, UITableViewCell * cell);

@property (nonatomic , copy) void(^collectSeleteBlock)(NSIndexPath * index, HP_AuthCollectCell * cell);

@property (nonatomic , strong) MUser * user;

@property (nonatomic , strong) NSMutableArray * dataSource;

@end

NS_ASSUME_NONNULL_END
