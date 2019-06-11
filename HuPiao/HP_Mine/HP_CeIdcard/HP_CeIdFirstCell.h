//
//  HP_CeIdFirstCell.h
//  HuPiao
//
//  Created by a on 2019/6/11.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HP_CeIdFirstCell : UITableViewCell

+(instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier;

@property (nonatomic , strong) NSIndexPath * indexPath;

@property (nonatomic , copy) void(^textFieldChangedBlock)(UITextField * textField , NSInteger tag , NSString * text);

@end

NS_ASSUME_NONNULL_END
