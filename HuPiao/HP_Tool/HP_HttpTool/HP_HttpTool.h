//
//  HP_HttpTool.h
//  HuPiao
//
//  Created by a on 2019/6/19.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBNetWork.h"
#import "ZZNetworkRequest.h"

/** 数据请求类型枚举 */
typedef enum {
    GET_INM = 0,
    POST_INM,
}INMREQUEST_TYPE;

NS_ASSUME_NONNULL_BEGIN

/**     请求数据成功的block        */
typedef void(^INMRequestSuccess)(id obj);
/**     请求数据失败的block        */
typedef void(^INMRequestFailed)(NSError *error);
/**     没网的block               */
typedef void (^NetFailureBlocks)(NSError *netFail);
/**     下载进度block             */
typedef void(^INMDownloadProgress)(int64_t bytesProgress,int64_t totalBytesProgress);
/**     下载进度成功block          */
typedef void(^INMDownloadSuccess)(NSString *filePath, NSString *downloadPath, NSString *filename);
/**     下载进度失败block          */
typedef void(^INMDownloadFailed)(NSError *error,NSString *url);
/**     上传进度block             */
typedef void(^INMUploadProgress)(int64_t bytesProgress,int64_t totalBytesProgress);

@interface HP_HttpTool : NSObject

/* 网络请求 */
+ (void)INMRequestWithType:(INMREQUEST_TYPE)requestType URL:(NSString *)url Paramer:(NSDictionary *)paramer SuccessBlock:(INMRequestSuccess)successBlock FailureBlock:(INMRequestFailed)failureBlock IsCache:(BOOL)isCache;

/* 批量上传图片 */
+ (void)uploadPicWithURL:(NSString *)URL
            parameters:(NSDictionary *)parameters
                  images:(NSArray<UIImage *> *)images
                    name:(NSString *)name
                fileName:(NSString *)fileName
                mimeType:(NSString *)mimeType
                progress:(INMUploadProgress)progressBlock
                 success:(INMRequestSuccess)successBlock
                 failure:(INMRequestFailed)failureBlock;

/* 单张上传图片 */
+ (void )uploadPicAloneWithURL:(NSString *)URL
               parameters:(NSDictionary *)parameters
                 mimeType:(NSString *)mimeType
                 progress:(INMUploadProgress)progressBlock
                  success:(INMRequestSuccess)successBlock
                  failure:(INMRequestFailed)failureBlock;

/**
 *  下载文件
 *
 *  @param URL      请求地址
 *  @param fileDirectory  文件存储目录(默认存储目录为Download)
 *  @param progress 文件下载的进度信息
 *  @param downSuccess  下载成功的回调(回调参数filePath:保存的文件的路径, downloadPath 下载文件的路劲,filename文件的名字)
 *  @param downFailure  下载失败的回调
 *
 *  @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，开始下载调用resume方法
 */
+ (NSURLSessionTask *)lyj_zz_downloadWithURL:(NSString *)URL
                               fileDirectory:(NSString *)fileDirectory
                                    progress:(INMDownloadProgress)progress
                                     success:(INMDownloadSuccess)downSuccess
                                     failure:(INMDownloadFailed)downFailure;

/**
 *  检测网络状态
 *
 *  @param success 有网络
 *  @param failure 无网络
 */
+ (void)netWorkingStatusSuccess:(void(^)(void))success failure:(void(^)(void))failure;

@end

NS_ASSUME_NONNULL_END
