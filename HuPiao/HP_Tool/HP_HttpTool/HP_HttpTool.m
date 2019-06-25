//
//  HP_HttpTool.m
//  HuPiao
//
//  Created by a on 2019/6/19.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_HttpTool.h"

@interface HP_HttpTool()

@end

@implementation HP_HttpTool

+ (void)INMRequestWithType:(INMREQUEST_TYPE)requestType URL:(NSString *)url Paramer:(NSDictionary *)paramer SuccessBlock:(INMRequestSuccess)successBlock FailureBlock:(INMRequestFailed)failureBlock IsCache:(BOOL)isCache{
    
    if (requestType == GET_INM) {
        [WBNetWork wb_GET_URL:url parameters:paramer successBlock:^(id response) {
            [HP_HttpTool stopNetworkActivity];
            [SVProgressHUD popActivity];
            successBlock(response);
            
        } failureBlock:^(NSError *error) {
            [SVProgressHUD popActivity];
            failureBlock(error);
        } IsCache:isCache];
    }else if(requestType == POST_INM){
        [WBNetWork wb_POST_URL:url parameters:paramer successBlock:^(id response) {
            [SVProgressHUD popActivity];
            
            successBlock(response);
            
        } failureBlock:^(NSError *error) {
            [SVProgressHUD popActivity];
            failureBlock(error);
        } IsCache:isCache];
    }
}
#pragma mark - 图片上传
+ (void)uploadPicWithURL:(NSString *)URL
              parameters:(NSDictionary *)parameters
                  images:(NSArray<UIImage *> *)images
                    name:(NSString *)name
                fileName:(NSString *)fileName
                mimeType:(NSString *)mimeType
                progress:(INMUploadProgress)progressBlock
                 success:(INMRequestSuccess)successBlock
                 failure:(INMRequestFailed)failureBlock{
    
    [WBNetWork wb_uploadWithURL:URL parameters:parameters images:images name:name fileName:fileName mimeType:mimeType progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    } success:^(id response) {
        successBlock(response);
        [SVProgressHUD dismiss];
       
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        failureBlock(error);
    }];
    

}

#pragma mark - 图片上传
+ (void )uploadPicAloneWithURL:(NSString *)URL
                            parameters:(NSDictionary *)parameters
                              mimeType:(NSString *)mimeType
                              progress:(INMUploadProgress)progressBlock
                               success:(INMRequestSuccess)successBlock
                               failure:(INMRequestFailed)failureBlock{

    [WBNetWork wb_uploadWithURL:URL parameters:parameters mimeType:mimeType progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {

        progressBlock(bytesProgress,totalBytesProgress);
        
    } success:^(id response) {
        [SVProgressHUD dismiss];
        successBlock(response);
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        failureBlock(error);
    }];
}

#pragma mark - 文件下载
+ (NSURLSessionTask *)lyj_zz_downloadWithURL:(NSString *)URL
                               fileDirectory:(NSString *)fileDirectory
                                    progress:(INMDownloadProgress)downProgress
                                     success:(INMDownloadSuccess)downSuccess
                                     failure:(INMDownloadFailed)downFailure {
    if ([fileDirectory isEqual:[NSNull class]] || fileDirectory == nil) {
        fileDirectory = @"";
    }
    
    NSURLSessionTask *task = [ZZNetworkRequest lyj_zz_downloadWithURL:URL fileDirectory:fileDirectory progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
        downProgress(bytesProgress , totalBytesProgress);
    
    } success:^(NSString *filePath, NSString *downloadPath, NSString *filename) {
        [SVProgressHUD dismiss];
       
        downSuccess(filename , downloadPath , filename);
        
    } failure:^(NSError *error, NSString *url) {
        downFailure(error , url);
    }];
    return task;
}

#pragma mark - 开启网络指示器
+(void)startNetworkActivity{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    });
}

#pragma mark - 关闭网络指示器
+(void)stopNetworkActivity{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    });
}

/* 网络检测 */
+ (void)netWorkingStatusSuccess:(void(^)(void))success failure:(void(^)(void))failure {
    [HP_HttpTool netWorkingStatusNotReachable:^{
        if (failure) {
            failure();
        }
    } ReachableViaWWAN:^{
        if (success) {
            success();
        }
        
    } ReachableViaWiFi:^{
        if (success) {
            success();
        }
    }];
}

+ (void)netWorkingStatusNotReachable:(void (^)(void))NotReachable ReachableViaWWAN:(void (^)(void))ReachableViaWWAN ReachableViaWiFi:(void (^)(void))ReachableViaWiFi {
    
    /** 网络状态
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 没有网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
     */
    
    // 获取网络管理者单例
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    // 设置网络状态改变调用的代码
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                if (NotReachable) {
                    NotReachable();
                }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                if (ReachableViaWWAN) {
                    ReachableViaWWAN();
                }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                if (ReachableViaWiFi) {
                    ReachableViaWiFi();
                }
                break;
            default:
                break;
        }
    }];
    
    // 开始监听网络状态
    [manager startMonitoring];
}

@end
