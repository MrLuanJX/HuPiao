//
//  HPCircleCollectionCell.h
//  HuPiao
//
//  Created by a on 2019/6/10.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HP_CsoGiftSendMemberColl.h"

NS_ASSUME_NONNULL_BEGIN

@interface HP_CircleCollectionCell : UICollectionViewCell

@end

@interface HP_CircleTableCell : UITableViewCell

+(instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier;


@property(nonatomic,copy)NSArray <HP_CsoGiftSendMemberColl *>* csoGiftSendMemberColl;

@end

NS_ASSUME_NONNULL_END
