//
//  Lyy_ImagePickerController.h
//  ainanming
//
//  Created by 陆义金 on 2018/11/8.
//  Copyright © 2018年 陆义金. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^takePhotoFinish)(UIImage *img,PHAsset *asset);

@interface Lyy_ImagePickerController : UIImagePickerController

@property(nonatomic,copy)takePhotoFinish finishCallback;
@property(nonatomic,weak)UIViewController *presentViewController;

-(void)takePhoto;

@end

NS_ASSUME_NONNULL_END
