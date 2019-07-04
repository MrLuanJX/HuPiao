//
//  HP_PhotoDetailViewController.h
//  HuPiao
//
//  Created by a on 2019/5/23.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface HP_PhotoCollectionCell : UICollectionViewCell

@end

@interface HP_PhotoDetailViewController : UIViewController
    
@property (nonatomic, strong) UICollectionView * collectionView;

@property (nonatomic, strong) HP_HomeModel * user;

@property (nonatomic , strong) HP_AnchorOwnModel * ownModel;

@end

NS_ASSUME_NONNULL_END
