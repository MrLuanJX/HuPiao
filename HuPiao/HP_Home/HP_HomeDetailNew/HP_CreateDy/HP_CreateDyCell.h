//
//  HP_CreateDyCell.h
//  HuPiao
//
//  Created by a on 2019/6/18.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HP_CreateDyCollectCell : UICollectionViewCell

@end

@interface HP_CreateDyCell : UITableViewCell

+(instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier;

@property (nonatomic , strong) NSMutableArray * selectedPhotos;

@property (nonatomic , strong) NSMutableArray * selectedAssets;

//@property (nonatomic , copy) void (^photoClickAction) (NSMutableArray * selectedArray,NSMutableArray * selectedPhotoArray , UICollectionView * collectionView);

@property (nonatomic , strong) UICollectionView * collectionView;

@property (nonatomic , copy) void (^photoClickAction) (NSIndexPath * index);

@property (nonatomic , copy) void (^photoPreviewAction) (NSIndexPath * index , NSMutableArray * photos , NSMutableArray * assets);


- (void) reload;

@end

NS_ASSUME_NONNULL_END
