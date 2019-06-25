//
//  HP_AuthMessageHeadView.h
//  HuPiao
//
//  Created by a on 2019/6/5.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HP_AuthCollectCell : UICollectionViewCell

@property (nonatomic , strong) UIImageView * image;

@end

@interface HP_AuthMessageHeadView : UIView

@property (nonatomic , copy) void(^collectSeleteBlock)(NSIndexPath * index, HP_AuthCollectCell * cell);

@property (nonatomic , strong) NSMutableArray * dataSource;

@end

NS_ASSUME_NONNULL_END
