//
//  DJZJ_RequestTool.h
//  DJZJ
//
//  Created by a on 2019/6/12.
//  Copyright © 2019 a. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    LJX_POST = 0,
    LJX_GET,
} LJXRequestType;

typedef void (^LJXSuccessBlock) (id obj);

typedef void (^LJXFailureBlock) (NSError * error);

/**     上传进度block             */
typedef void(^LJXUploadProgress)(int64_t bytesProgress,int64_t totalBytesProgress);

@interface DJZJ_RequestTool : NSObject

+ (void) LJX_requestWithType:(LJXRequestType)type URL:(NSString *)url params:(NSDictionary *)params successBlock:(LJXSuccessBlock)successBlock failureBlock:(LJXFailureBlock)failureBlock;

/* 批量上传图片 */
+ (void)LJX_uploadPicWithURL:(NSString *)URL
              parameters:(NSDictionary *)parameters
                  images:(NSArray<UIImage *> *)images
                    name:(NSString *)name
                fileName:(NSString *)fileName
                mimeType:(NSString *)mimeType
                progress:(LJXUploadProgress)progressBlock
                 success:(LJXSuccessBlock)successBlock
                 failure:(LJXFailureBlock)failureBlock;

/*
 *  上传单张图片
 */
+ (void )uploadPicAloneWithURL:(NSString *)URL
                    parameters:(NSDictionary *)parameters
                      mimeType:(NSString *)mimeType
                      progress:(LJXUploadProgress)progressBlock
                       success:(LJXSuccessBlock)successBlock
                       failure:(LJXFailureBlock)failureBlock;

@end
