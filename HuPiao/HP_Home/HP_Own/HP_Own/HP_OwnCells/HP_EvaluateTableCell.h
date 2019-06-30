//
//  HP_EvaluateTableCell.h
//  HuPiao
//
//  Created by a on 2019/6/10.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HP_CsoCommentLColl.h"

NS_ASSUME_NONNULL_BEGIN

@interface HP_EvaluateTableCell : UITableViewCell

+(instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier;

@property (nonatomic , strong) HP_CsoCommentLColl * commentModel;


@end

NS_ASSUME_NONNULL_END
