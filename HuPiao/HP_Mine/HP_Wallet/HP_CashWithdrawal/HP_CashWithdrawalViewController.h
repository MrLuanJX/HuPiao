//
//  HP_CashWithdrawalViewController.h
//  HuPiao
//
//  Created by a on 2019/6/12.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HP_CashWithdrawalModel.h"

NS_ASSUME_NONNULL_BEGIN
//设置一个代理，用于将textField中d输入的值传递到Ccontroller中去处理
@protocol HP_CashWithdrawalCellDelegate <NSObject>

@optional

- (void)textFieldCellText:(NSString *)text index:(NSIndexPath *)index;

@end

@interface HP_CashWithdrawalCell : UITableViewCell

//声明代理
@property (nonatomic , weak) id<HP_CashWithdrawalCellDelegate> delegate;

//创建model对象
@property (nonatomic , strong) HP_CashWithdrawalModel * model;

@end

@interface HP_CashWithdrawalViewController : HP_BaseViewController

@end

NS_ASSUME_NONNULL_END
