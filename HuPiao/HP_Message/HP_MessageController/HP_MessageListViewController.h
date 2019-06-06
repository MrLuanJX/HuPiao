//
//  HP_MessageListViewController.h
//  HuPiao
//
//  Created by a on 2019/6/3.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HP_Message.h"

NS_ASSUME_NONNULL_BEGIN

@interface HP_MessageListViewController : UIViewController

@end

@interface HP_MessageCell : UITableViewCell

@property (nonatomic, strong) HP_Message * message;

@end

NS_ASSUME_NONNULL_END
