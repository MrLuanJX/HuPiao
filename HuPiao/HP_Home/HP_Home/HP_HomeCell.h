//
//  HP_HomeCell.h
//  HuPiao
//
//  Created by a on 2019/5/20.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUser.h"
#import "HP_HomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HP_HomeCell : UITableViewCell

+ (instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier;

@property (nonatomic , strong) HP_HomeModel * homeModel;

@end

NS_ASSUME_NONNULL_END
