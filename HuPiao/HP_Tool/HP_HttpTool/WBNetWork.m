//
//  WBNetWork.m
//  WatermelonBabyNew
//
//  Created by gleen on 2017/8/30.
//  Copyright © 2017年 Fu Rong Technology. All rights reserved.
//


#import "WBNetWork.h"
#import "ZZNetworkRequest.h"

@implementation WBNetWork

#pragma mark - GET请求
+ (NSURLSessionTask *)wb_GET_URL:(NSString *)URL parameters:(NSDictionary *)parameters
                           successBlock:(WBRequestSuccess)successBlock
                        failureBlock:(WBRequestFailed)failureBlock IsCache:(BOOL)isCache{
   return [self wb_requestType:GET URL:URL parameters:parameters successBlock:successBlock failureBlock:failureBlock IsCache:isCache];
}

#pragma mark - POST请求
+ (NSURLSessionTask *)wb_POST_URL:(NSString *)URL parameters:(NSDictionary *)parameters
  successBlock:(WBRequestSuccess)successBlock
  failureBlock:(WBRequestFailed)failureBlock IsCache:(BOOL)isCache {
   return  [self wb_requestType:POST URL:URL parameters:parameters successBlock:successBlock failureBlock:failureBlock IsCache:isCache];
}


#pragma mark - 请求处理方法
+ (NSURLSessionTask *)wb_requestType:(REQUESTTYPE)type URL:(NSString *)URL parameters:(NSDictionary *)parameters
                        successBlock:(WBRequestSuccess)successBlock
                        failureBlock:(WBRequestFailed)failureBlock IsCache:(BOOL)isCache{
    if ([parameters isEqual:[NSNull class]] || parameters == nil) {
        parameters = [NSMutableDictionary dictionary];
    }
    if (isCache != YES) { //无缓存
        [SVProgressHUD show];
        NSURLSessionTask *task = [ZZNetworkRequest zz_requestType:type URL:URL parameters:parameters successBlock:^(id responseObject) {
            [SVProgressHUD popActivity];            
            successBlock(responseObject);
        } failureBlock:^(NSError *error) {
            [SVProgressHUD popActivity];
            failureBlock(error);
        }];
        return task;
    }else { //自动缓存
        NSURLSessionTask *task = [ZZNetworkRequest zz_requestType:type URL:URL parameters:parameters responseCache:^(id responseCache) {
            [SVProgressHUD popActivity];
            successBlock(responseCache);
            
        } successBlock:^(id responseObject) {
            [SVProgressHUD popActivity];
            successBlock(responseObject);
            
        } failureBlock:^(NSError *error) {
            [SVProgressHUD popActivity];
            failureBlock(error);
        }];
        return task;
    }
}

#pragma mark - 图片上传
+ (NSURLSessionTask *)wb_uploadWithURL:(NSString *)URL
                            parameters:(NSDictionary *)parameters
                                images:(NSArray<UIImage *> *)images
                                  name:(NSString *)name
                              fileName:(NSString *)fileName
                              mimeType:(NSString *)mimeType
                              progress:(WBUploadProgress)progress
                               success:(WBRequestSuccess)success
                               failure:(WBRequestFailed)failure {
    
    if ([parameters isEqual:[NSNull class]] || parameters == nil) {
        parameters = [NSMutableDictionary dictionary];
    }
    
    /**     统一加密方法      */
    [SVProgressHUD show];
    NSURLSessionTask *task = [ZZNetworkRequest zz_uploadWithURL:URL parameters:parameters images:images name:name fileName:fileName mimeType:mimeType progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        progress(bytesProgress,totalBytesProgress);
        
    } success:^(id responseObject) {
        [SVProgressHUD popActivity];
        success(responseObject);
        
    } failure:^(NSError *error) {
        [SVProgressHUD popActivity];
        failure(error);
    }];
    return task;
}

#pragma mark - 图片上传
+ (NSURLSessionTask *)wb_uploadWithURL:(NSString *)URL
                            parameters:(NSDictionary *)parameters
                              mimeType:(NSString *)mimeType
                              progress:(WBUploadProgress)progress
                               success:(WBRequestSuccess)success
                               failure:(WBRequestFailed)failure {
    
    if ([parameters isEqual:[NSNull class]] || parameters == nil) {
        parameters = [NSMutableDictionary dictionary];
    }
    
    /**     统一加密方法      */
    //[SVProgressHUD show];
    NSURLSessionTask *task = [ZZNetworkRequest zz_uploadListWithURL:URL parameters:parameters mimeType:mimeType progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        progress(bytesProgress,totalBytesProgress);
    } success:^(id responseObject) {
        //[SVProgressHUD popActivity];
        success(responseObject);
    } failure:^(NSError *error) {
        //[SVProgressHUD popActivity];
        failure(error);
    }];
    return task;
}

@end
