//
//  HP_ReceivedGiftViewController.h
//  HuPiao
//
//  Created by a on 2019/6/24.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HP_ReceivedGiftModel : NSObject

@property (nonatomic , copy) NSString * icon;

@property (nonatomic , copy) NSString * name;

@property (nonatomic , copy) NSString * count;

@end

@interface HP_ReceivedGiftCell : UICollectionViewCell

@end

@interface HP_ReceivedGiftViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
