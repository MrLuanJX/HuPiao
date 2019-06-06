//
//  HP_SeleteViewController.h
//  HuPiao
//
//  Created by a on 2019/6/6.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HP_SeleteCell : UITableViewCell

@end

@interface HP_SeleteViewController : UIViewController

@property (nonatomic , copy) void(^jobSeleteBlock)(NSIndexPath * index , NSString * seleteTitle);

@property (nonatomic , copy) void(^interestSeleteBlock)(NSArray * seleteTitles);

@property (nonatomic , strong) NSMutableArray * dataArray;

@property (nonatomic , strong) UITableViewCell * cell;

@property (nonatomic , assign) BOOL isJob;

@end

NS_ASSUME_NONNULL_END
