//
//  HP_HomeCell.h
//  HuPiao
//
//  Created by a on 2019/5/20.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface HP_HomeCell : UITableViewCell

+ (instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier;
    
@property (nonatomic , strong) NSIndexPath * index;

@property (nonatomic , copy) void(^likeBtnActionBlock)(UIButton * button);

@property (nonatomic , strong) MUser * user;

@property (nonatomic , copy) NSString * address;

@end

NS_ASSUME_NONNULL_END
