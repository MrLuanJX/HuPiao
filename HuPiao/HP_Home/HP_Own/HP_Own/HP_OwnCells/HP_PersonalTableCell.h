//
//  HP_PersonalTableCell.h
//  HuPiao
//
//  Created by a on 2019/6/10.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HP_PersonalCollectionCell : UICollectionViewCell

@property (nonatomic , strong) UILabel * title;

@end

@interface HP_PersonalTableCell : UITableViewCell

+(instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier;

@property (nonatomic , strong) NSMutableArray * dataSource;

@property (nonatomic , copy) void (^collectHeight) (NSInteger height);

@end

NS_ASSUME_NONNULL_END
