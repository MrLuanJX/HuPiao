//
//  WBNetWork.h
//  WatermelonBabyNew
//
//  Created by gleen on 2017/8/30.
//  Copyright © 2017年 Fu Rong Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/** 数据请求类型枚举 */
typedef enum {
    GET_WB = 0,
    POST_WB,
}REQUEST_HTTP_TYPE;


/**     请求数据成功的block        */
typedef void(^WBRequestSuccess)(id response);
/**     请求数据失败的block        */
typedef void(^WBRequestFailed)(NSError *error);

/** 上传进度block */
typedef void(^WBUploadProgress)(int64_t bytesProgress,int64_t totalBytesProgress);

@interface WBNetWork : NSObject

//get 请求
+ (NSURLSessionTask *)wb_GET_URL:(NSString *)URL parameters:(NSDictionary *)parameters
                successBlock:(WBRequestSuccess)successBlock
                failureBlock:(WBRequestFailed)failureBlock IsCache:(BOOL)isCache;

//post请求
+ (NSURLSessionTask *)wb_POST_URL:(NSString *)URL parameters:(NSDictionary *)parameters
                 successBlock:(WBRequestSuccess)successBlock
                 failureBlock:(WBRequestFailed)failureBlock IsCache:(BOOL)isCache;


//upload image 图片上传
+ (NSURLSessionTask *)wb_uploadWithURL:(NSString *)URL
                            parameters:(NSDictionary *)parameters
                                images:(NSArray<UIImage *> *)images
                                  name:(NSString *)name
                              fileName:(NSString *)fileName
                              mimeType:(NSString *)mimeType
                              progress:(WBUploadProgress)progress
                               success:(WBRequestSuccess)success
                               failure:(WBRequestFailed)failure;



//upload image 表单形式图片上传
+ (NSURLSessionTask *)wb_uploadWithURL:(NSString *)URL
                            parameters:(NSDictionary *)parameters
                              mimeType:(NSString *)mimeType
                              progress:(WBUploadProgress)progress
                               success:(WBRequestSuccess)success
                               failure:(WBRequestFailed)failure;

@end
