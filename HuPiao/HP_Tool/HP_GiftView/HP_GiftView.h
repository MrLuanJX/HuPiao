//
//  HP_GiftView.h
//  HuPiao
//
//  Created by a on 2019/6/11.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HP_GiftCell: UICollectionViewCell

@end

@interface HP_GiftContentView : UIView

@end

@interface HP_GiftView : UIView

@property (nonatomic , strong) NSMutableArray * dataArray;

+ (instancetype)showGiftView;

- (void)show ;

@end

NS_ASSUME_NONNULL_END
