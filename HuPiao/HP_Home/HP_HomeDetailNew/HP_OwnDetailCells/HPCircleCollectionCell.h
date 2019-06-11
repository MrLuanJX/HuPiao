//
//  HPCircleCollectionCell.h
//  HuPiao
//
//  Created by a on 2019/6/10.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HP_CircleCollectionCell : UITableViewCell

+(instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier;


@end

NS_ASSUME_NONNULL_END
