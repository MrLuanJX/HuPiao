//
//  HP_ImpressionTableCell.h
//  HuPiao
//
//  Created by a on 2019/6/10.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HP_ImpressionCollectionCell : UICollectionViewCell

@end


@interface HP_ImpressionTableCell : UITableViewCell

+(instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier;


@end

NS_ASSUME_NONNULL_END
