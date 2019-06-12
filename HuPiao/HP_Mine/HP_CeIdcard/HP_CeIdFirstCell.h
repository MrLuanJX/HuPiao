//
//  HP_CeIdFirstCell.h
//  HuPiao
//
//  Created by a on 2019/6/11.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HP_CashWithdrawalModel.h"

NS_ASSUME_NONNULL_BEGIN
@class HP_CeIdFirstCell;

//设置一个代理，用于将textField中d输入的值传递到Ccontroller中去处理
@protocol HP_CeIdFirstCellDelegate <NSObject>

@optional

- (void)textFieldCellText:(NSString *)text index:(NSIndexPath *)index;

@end

@interface HP_CeIdFirstCell : UITableViewCell

+(instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier;

@property (nonatomic , strong) NSIndexPath * indexPath;

//声明代理
@property (nonatomic , weak) id<HP_CeIdFirstCellDelegate> delegate;

//创建model对象
@property (nonatomic , strong) HP_CashWithdrawalModel * model;


@end

NS_ASSUME_NONNULL_END
