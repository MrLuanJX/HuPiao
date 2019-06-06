//
//  HP_DyViewController.h
//  HuPiao
//
//  Created by a on 2019/5/31.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface HP_DyViewController : UIViewController

@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) MUser * user;

@property (nonatomic , assign) BOOL isOwn;

@end

NS_ASSUME_NONNULL_END