//
//  HP_CreateDyViewController.h
//  HuPiao
//
//  Created by a on 2019/6/18.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HP_CreateDyViewController : UIViewController

@property (nonatomic , strong) NSMutableArray * selectedPhotos;

@property (nonatomic , strong) NSMutableArray * selectedAssets;

// 相册
@property(nonatomic , strong) TZImagePickerController * againPhotoalbum;

@end

NS_ASSUME_NONNULL_END
