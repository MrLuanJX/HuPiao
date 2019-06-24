//
//  HP_OwnDetailViewController.h
//  HuPiao
//
//  Created by a on 2019/5/23.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface HP_OwnDetailViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSString *cellTitle;

@property (nonatomic , strong) MUser * user;

@end

NS_ASSUME_NONNULL_END