//
//  HP_TouchIDCell.h
//  HuPiao
//
//  Created by a on 2019/6/21.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HP_TouchIDCell : UITableViewCell

+(instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier;

@property (nonatomic , strong) UILabel * title;

@end

NS_ASSUME_NONNULL_END
