//
//  HP_DyCell.h
//  HuPiao
//
//  Created by a on 2019/5/31.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HP_DyModel.h"
#import "MUser.h"
#import "HP_DyModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HP_DyCell : UITableViewCell

+(instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier;

@property (nonatomic , strong) NSIndexPath * index;

@property (nonatomic , strong) HP_DyModel * dyModel;

@property (nonatomic , strong) MUser * user;

@property (nonatomic , copy) void(^cellImgListBlock)(NSInteger index , HP_DyModel * dyModel);

@property (nonatomic , strong) UIButton * deleteBtn;    // 删除

@property (nonatomic , strong) UIButton * careBtn;      // 关注

@end

NS_ASSUME_NONNULL_END
