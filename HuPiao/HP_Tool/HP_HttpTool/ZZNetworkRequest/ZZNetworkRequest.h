//
//  ZZNetworkRequest.h
//  ZZNetworkRequest
//
//  Created by gleen on 2017/9/5.
//  Copyright © 2017年 gleen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "YYCache.h"

/**
 * AFNetworking 和 YYCache 的网络请求
 */

/** 数据请求类型枚举 */
typedef enum {
    GET = 0,
    POST,
}REQUESTTYPE;

typedef NS_ENUM(NSUInteger, ZZRequestSerializer) {
    ZZRequestSerializerJSON, /** 设置请求数据为JSON格式*/
    ZZRequestSerializerHTTP, /** 设置请求数据为二进制格式*/
};

typedef NS_ENUM(NSUInteger, ZZResponseSerializer) {
    ZZResponseSerializerJSON, /** 设置响应数据为JSON格式*/
    ZZResponseSerializerHTTP, /** 设置响应数据为二进制格式*/
};

/* 使用枚举NS_ENUM:区别可判断编译器是否支持新式枚举,支持就使用新的,否则使用旧的 */
typedef NS_ENUM(NSUInteger, ZZNetworkStatus) {
    ZZNetworkStatusUnknown           = 0,       /* 未知网络 */
    ZZNetworkStatusNotReachable,                /* 没有网络 */
    ZZNetworkStatusReachableViaWWAN,       /* 手机 3G/4G 网络 */
    ZZNetworkStatusReachableViaWiFi            /* wifi 网络 */
};

/** 实时监测网络状态的 block */
typedef void(^ZJNetworkStatusBlock)(ZZNetworkStatus status);

/** 请求成功的Block */
typedef void(^ZZRequestSuccess)(id responseObject);

/** 请求失败的Block */
typedef void(^ZZRequestFailed)(NSError *error);

/**请求失败的Block 还有url*/
typedef void(^LYJ_ZZRequestFailed)(NSError *error,NSString *url);

/** 缓存的Block */
typedef void(^ZZRequestCache)(id responseCache);

/** 下载进度block */
typedef void(^ZZDownloadProgress)(int64_t bytesProgress,int64_t totalBytesProgress);

/** 上传进度block */
typedef void(^ZZUploadProgress)(int64_t bytesProgress,int64_t totalBytesProgress);

#pragma mark -
@interface ZZNetworkRequest : NSObject

/**
 *  实时获取网络状态,通过Block回调实时获取(此方法可多次调用)
 */
+ (void)zz_networkStatusWithBlock:(ZJNetworkStatusBlock)networkStatus;

/**
 *  一次性获取当前网络状态,有网YES,无网:NO
 */
+ (BOOL)currentNetworkStatus;

/**
 获取全局唯一的网络请求实例单列方法
 @return 网络请求类的ZZNetworkRequest单列
 */
+ (ZZNetworkRequest *)shareManager;


/**
 网络请求数据方法  无缓存请求
 
 @param type 请求类型
 @param url 请求地址
 @param parameters 请求参数
 @param successBlock 请求成功回调
 @param failureBlock 请求失败回调
 @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)zz_requestType:(REQUESTTYPE)type URL:(NSString *)url
                          parameters:(NSDictionary *)parameters
                     successBlock:(ZZRequestSuccess)successBlock
                        failureBlock:(ZZRequestFailed)failureBlock;


/**
 网络请求数据方法  自动缓存请求
 
 @param type 请求地址
 @param url 请求地址
 @param parameters 请求参数
 @param successBlock 请求成功回调
 @param failureBlock 请求失败回调
 @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)zz_requestType:(REQUESTTYPE)type URL:(NSString *)url
                           parameters:(NSDictionary *)parameters
                       responseCache:(ZZRequestCache)responseCache
                        successBlock:(ZZRequestSuccess)successBlock
                        failureBlock:(ZZRequestFailed)failureBlock;

/**
 *  上传图片文件
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param images     图片数组
 *  @param name       文件对应服务器上的字段
 *  @param fileName   文件名
 *  @param mimeType   图片文件的类型,例:png、jpeg(默认类型)....
 *  @param progress   上传进度信息 Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)zz_uploadWithURL:(NSString *)URL
                                  parameters:(NSDictionary *)parameters
                                      images:(NSArray<UIImage *> *)images
                                        name:(NSString *)name
                                    fileName:(NSString *)fileName
                                    mimeType:(NSString *)mimeType
                                    progress:(ZZUploadProgress)progress
                                     success:(ZZRequestSuccess)success
                                     failure:(ZZRequestFailed)failure;

/**
 *  上传图片文件
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param mimeType   图片文件的类型,例:png、jpeg(默认类型)....
 *  @param progress   上传进度信息 Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)zz_uploadListWithURL:(NSString *)URL
                                parameters:(NSDictionary *)parameters
                                mimeType:(NSString *)mimeType
                                  progress:(ZZUploadProgress)progress
                                   success:(ZZRequestSuccess)success
                                   failure:(ZZRequestFailed)failure;

/**
 *  下载文件
 *
 *  @param URL      请求地址
 *  @param fileDirectory  文件存储目录(默认存储目录为Download)
 *  @param progress 文件下载的进度信息
 *  @param success  下载成功的回调(回调参数filePath:文件的路径)
 *  @param failure  下载失败的回调
 *
 *  @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，开始下载调用resume方法
 */
+ (NSURLSessionTask *)zz_downloadWithURL:(NSString *)URL
                                       fileDirectory:(NSString *)fileDirectory
                                      progress:(ZZDownloadProgress)progress
                                       success:(void(^)(NSString *filePath))success
                                       failure:(ZZRequestFailed)failure;


/**
 *  下载文件
 *
 *  @param URL      请求地址
 *  @param fileDirectory  文件存储目录(默认存储目录为Download)
 *  @param progress 文件下载的进度信息
 *  @param success  下载成功的回调(回调参数filePath:保存的文件的路径, downloadPath 下载文件的路劲,filename文件的名字)
 *  @param failure  下载失败的回调
 *
 *  @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，开始下载调用resume方法
 */
+ (NSURLSessionTask *)lyj_zz_downloadWithURL:(NSString *)URL
                           fileDirectory:(NSString *)fileDirectory
                                progress:(ZZDownloadProgress)progress
                                 success:(void(^)(NSString *filePath,NSString *downloadPath,NSString *filename))success
                                 failure:(LYJ_ZZRequestFailed)failure;



/*
 *  视频上传
 *
 *  @param parameters   上传视频预留参数---视具体情况而定 可移除
 *  @param videoPath    上传视频的本地沙河路径
 *  @param URL     上传的url
 *  @param successBlock 成功的回调
 *  @param failureBlock 失败的回调
 *  @param progress     上传的进度
 */
+ (void)zz_uploadVideoURL:(NSString *)URL
                         parameters:(NSDictionary *)parameters
                          videoPath:(NSString *)videoPath
                       successBlock:(ZZRequestSuccess)successBlock
                       failureBlock:(ZZRequestFailed)failureBlock
                     uploadProgress:(ZZUploadProgress)progress;



#pragma mark - 重置AFHTTPSessionManager相关属性
/**
 *  设置网络请求参数的格式:默认为JSON格式
 *  @param requestSerializer ZZRequestSerializerJSON(JSON格式),ZZRequestSerializerHTTP(二进制格式),
 */
+ (void)setRequestSerializer:(ZZRequestSerializer)requestSerializer;

/**
 *  设置服务器响应数据格式:默认为JSON格式
 *  @param responseSerializer ZZResponseSerializerJSON(JSON格式),ZZResponseSerializerHTTP(二进制格式)
 */
+ (void)setResponseSerializer:(ZZResponseSerializer)responseSerializer;

/**
 *  设置请求超时时间:默认为30S
 *  @param time 时长
 */
+ (void)setRequestTimeoutInterval:(NSTimeInterval)time;

/** 
 *  设置请求头
 */
+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;

/**
 *  是否打开网络状态转圈菊花:默认打开
 *  @param open YES(打开), NO(关闭)
 */
+ (void)openNetworkActivityIndicator:(BOOL)open;


@end



#pragma mark - 网络数据缓存类
@interface ZZNetworkCache : NSObject

/**
 *  缓存网络数据,根据请求的 URL与parameters
 *  做KEY存储数据, 这样就能缓存多级页面的数据
 *
 *  @param httpData   服务器返回的数据
 *  @param URL        请求的URL地址
 *  @param parameters 请求的参数
 */
+ (void)setHttpCache:(id)httpData URL:(NSString *)URL parameters:(NSDictionary *)parameters;

/**
 *  根据请求的 URL与parameters 取出缓存数据
 *
 *  @param URL        请求的URL
 *  @param parameters 请求的参数
 *
 *  @return 缓存的服务器数据
 */
+ (id)httpCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters;

/**
 *  获取网络缓存的总大小 bytes(字节)
 */
+ (NSInteger)getAllHttpCacheSize;

/**
 *  删除所有网络缓存,
 */
+ (void)removeAllHttpCache;


@end
















