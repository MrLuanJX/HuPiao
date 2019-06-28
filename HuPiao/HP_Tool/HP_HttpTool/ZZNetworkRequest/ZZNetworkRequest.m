//
//  ZZNetworkRequest.m
//  ZZNetworkRequest
//
//  Created by gleen on 2017/9/5.
//  Copyright © 2017年 gleen. All rights reserved.
//

#import "ZZNetworkRequest.h"
#import "AFNetworkActivityIndicatorManager.h"
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetExportSession.h>
#import <AVFoundation/AVMediaFormat.h>

static AFHTTPSessionManager *_sessionManager;

@implementation ZZNetworkRequest

+ (ZZNetworkRequest *)shareManager {
    static ZZNetworkRequest *netRequest = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netRequest = [[ZZNetworkRequest alloc] init];
    });
    return netRequest;
}

//初始化请求管理者
+ (void)initialize {

    _sessionManager = [AFHTTPSessionManager manager];

    //设置请求参数的类型:JSON (AFJSONRequestSerializer,AFHTTPRequestSerializer)
//    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    /*! 这里是去掉了键值对里空对象的键值 */
    //response.removesKeysWithNullValues = YES;
//    _sessionManager.responseSerializer = response;
//    _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
//
//    _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
//    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];

    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",@"text/plain",@"image/gif", nil];
    [_sessionManager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];

    //设置请求的超时时间
    _sessionManager.requestSerializer.timeoutInterval = 30.f;
    //打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;

    /*! https 参数配置 */
    /*!
     采用默认的defaultPolicy就可以了. AFN默认的securityPolicy就是它, 不必另写代码. AFSecurityPolicy类中会调用苹果security.framework的机制去自行验证本次请求服务端放回的证书是否是经过正规签名.
     */
    _sessionManager.requestSerializer.timeoutInterval = 15.0f;
    _sessionManager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    _sessionManager.securityPolicy.allowInvalidCertificates = YES;
    _sessionManager.securityPolicy.validatesDomainName = NO;
}

+(void)headerRequest{
    /*! 设置响应数据的基本类型 */
 
    /*! RequestHeader */
//    [Gloabinfo shared].token = INMNULLString([Gloabinfo shared].token) ? @"" : [Gloabinfo shared].token;
//    NSLog(@"headToken = %@",[Gloabinfo shared].token);
//    [_sessionManager.requestSerializer setValue:[Gloabinfo shared].token forHTTPHeaderField:@"token"];
//    [_sessionManager.requestSerializer setValue:@"857b97e33cda46d1adbcd409f085de49" forHTTPHeaderField:@"datasource"]; // adhibitionId  datasource
//    [_sessionManager.requestSerializer setValue:[NSString stringWithFormat:@"%@_V%@",@"iOS",[Gloabinfo getCurrentVersion]] forHTTPHeaderField:@"version"];
    
}

#pragma mark  --- 网络请求的类方法 --- GET / POST   请求无缓存
+ (NSURLSessionTask *)zz_requestType:(REQUESTTYPE)type URL:(NSString *)url
                          parameters:(NSDictionary *)parameters successBlock:(ZZRequestSuccess)successBlock
                        failureBlock:(ZZRequestFailed)failureBlock {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //无条件的信任服务器上的证书
    AFSecurityPolicy *securityPolicy =  [AFSecurityPolicy defaultPolicy];
    // 客户端是否信任非法证书
    securityPolicy.allowInvalidCertificates = YES;
    // 是否在证书域字段中验证域名
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;

    
    return [self zz_requestType:type URL:url parameters:parameters responseCache:nil
                   successBlock:successBlock failureBlock:failureBlock];
}

#pragma mark  --- 网络请求的类方法 --- GET / POST   请求自动缓存
+ (NSURLSessionTask *)zz_requestType:(REQUESTTYPE)type URL:(NSString *)url
                           parameters:(NSDictionary *)parameters responseCache:(ZZRequestCache)responseCache
                        successBlock:(ZZRequestSuccess)successBlock failureBlock:(ZZRequestFailed)failureBlock {
    //请求地址为空时直接返回nil
    if (url == nil || [url isEqualToString:@""]) {
        return nil;
    }
    url = [url stringByReplacingOccurrencesOfString:@" " withString:@""];//出去URL中的空格
    NSString *urlString = [NSURL URLWithString:url] ? url : [self stringUTF8Encoding:url];//检测地址中是否混有中文
    
    //请求的参数
    if (parameters) {
        parameters=@{@"paramJson":[HPDivisableTool dictionaryToJson:parameters]};
    }
    
    NSURLSessionTask *sessionTask = nil;
    switch (type) {
        case GET: {
            sessionTask = [self GET:urlString parameters:parameters responseCache:responseCache successBlock:successBlock failureBlock:failureBlock];
        } break;
            
        case POST: {
             sessionTask = [self POST:urlString parameters:parameters responseCache:responseCache successBlock:successBlock failureBlock:failureBlock];
        } break;
        default: break;
    }
    return sessionTask;
}


#pragma mark  --- GET请求
+ (NSURLSessionTask *)GET:(NSString *)URL parameters:(NSDictionary *)parameters
            responseCache:(ZZRequestCache)responseCache successBlock:(ZZRequestSuccess)successBlock
             failureBlock:(ZZRequestFailed)failureBlock {
    
    //读取缓存
    responseCache ? responseCache([ZZNetworkCache httpCacheForURL:URL parameters:parameters]) : nil;

    return [_sessionManager GET:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock ? successBlock(responseObject) : nil;
        //对数据进行异步缓存
        responseCache ? [ZZNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock ? failureBlock(error) : nil;
    }];
}

#pragma mark  --- POST请求
+ (NSURLSessionTask *)POST:(NSString *)URL  parameters:(NSDictionary *)parameters
             responseCache:(ZZRequestCache)responseCache successBlock:(ZZRequestSuccess)successBlock
              failureBlock:(ZZRequestFailed)failureBlock {
    
    //读取缓存
    responseCache ? responseCache([ZZNetworkCache httpCacheForURL:URL parameters:parameters]) : nil;
    
    return [_sessionManager POST:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock ? successBlock(responseObject) : nil;
        //对数据进行异步缓存
        responseCache ? [ZZNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock ? failureBlock(error) : nil;
    }];
}

#pragma mark  --- 上传图片文件
+ (NSURLSessionTask *)zz_uploadWithURL:(NSString *)URL
                            parameters:(NSDictionary *)parameters
                                images:(NSArray<UIImage *> *)images
                                  name:(NSString *)name 
                              fileName:(NSString *)fileName
                              mimeType:(NSString *)mimeType
                              progress:(ZZUploadProgress)progress
                               success:(ZZRequestSuccess)success
                               failure:(ZZRequestFailed)failure {
    
    [ZZNetworkRequest headerRequest];
    
    //请求地址为空时直接返回nil
    if (URL == nil || [URL isEqualToString:@""]) {
        return nil;
    }
    URL = [URL stringByReplacingOccurrencesOfString:@" " withString:@""];//出去URL中的空格
    NSString *urlString = [NSURL URLWithString:URL] ? URL : [self stringUTF8Encoding:URL];//检测地址中是否混有中文
    
    return [_sessionManager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //压缩-添加-上传图片
        [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData:imageData name:name fileName:[NSString stringWithFormat:@"%@%lu.%@",fileName,(unsigned long)idx,mimeType?mimeType:@"jpeg"] mimeType:[NSString stringWithFormat:@"image/%@",mimeType ? mimeType : @"jpeg"]];
        }];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress.completedUnitCount,uploadProgress.totalUnitCount) : nil;
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success ? success(responseObject) : nil;

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure ? failure(error) : nil;
    }];
}

+ (NSURLSessionTask *)zz_uploadListWithURL:(NSString *)URL
                                parameters:(NSDictionary *)parameters
                                  mimeType:(NSString *)mimeType
                                  progress:(ZZUploadProgress)progress
                                   success:(ZZRequestSuccess)success
                                   failure:(ZZRequestFailed)failure {

    [ZZNetworkRequest headerRequest];
    
    //请求地址为空时直接返回nil
    if (URL == nil || [URL isEqualToString:@""]) {
        return nil;
    }
    URL = [URL stringByReplacingOccurrencesOfString:@" " withString:@""];//出去URL中的空格
    NSString *urlString = [NSURL URLWithString:URL] ? URL : [self stringUTF8Encoding:URL];//检测地址中是否混有中文
    NSMutableDictionary *sp = [[NSMutableDictionary alloc]initWithDictionary:parameters];
    NSArray *keyarr = [sp allKeys];
    NSMutableArray *removekey = [[NSMutableArray alloc]init];
    for (NSString *key in keyarr) {
        id obj = [sp valueForKey:key];
        if ([obj isKindOfClass:[UIImage class]]) {
            [removekey addObject:key];
        }
        if ([obj isKindOfClass:[NSArray class]]) {
            NSArray *oarr = (NSArray *)obj;
            id sobj = oarr[0];
            if ([sobj isKindOfClass:[UIImage class]]) {
                [removekey addObject:key];
            }
        }
    }
    
    [sp removeObjectsForKeys:removekey];
    
    NSURLSessionTask *task = [_sessionManager POST:urlString parameters:sp constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //压缩-添加-上传图片
        [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UIImage class]]) {
                UIImage *image = (UIImage *)obj;
                NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
                [formData appendPartWithFileData:imageData name:key fileName:[NSString stringWithFormat:@"%@%d.%@",key,0,mimeType?mimeType:@"jpeg"] mimeType:[NSString stringWithFormat:@"image/%@",mimeType ? mimeType : @"jpeg"]];
            }else if ([obj isKindOfClass:[NSArray class]]) {
                NSArray *arr = (NSArray *)obj;
                if ([arr[0] isKindOfClass:[UIImage class]]) {
                    [arr enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
                        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
                        [formData appendPartWithFileData:imageData name:key fileName:[NSString stringWithFormat:@"%@%lu.%@",key,(unsigned long)idx,mimeType?mimeType:@"jpeg"] mimeType:[NSString stringWithFormat:@"image/%@",mimeType ? mimeType : @"jpeg"]];
                    }];
                }
            }
        }];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress.completedUnitCount,uploadProgress.totalUnitCount) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success ? success(responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure ? failure(error) : nil;
    }];
    return task;
}


#pragma mark  --- 文件下载
+ (NSURLSessionTask *)zz_downloadWithURL:(NSString *)URL
                        fileDirectory:(NSString *)fileDirectory
                             progress:(ZZDownloadProgress)progress
                              success:(void(^)(NSString *filePath))success
                              failure:(ZZRequestFailed)failure {
    
    [ZZNetworkRequest headerRequest];

    //请求地址为空时直接返回nil
    if (URL == nil || [URL isEqualToString:@""]) {
        return nil;
    }
    URL = [URL stringByReplacingOccurrencesOfString:@" " withString:@""];//出去URL中的空格
    NSString *urlString = [NSURL URLWithString:URL] ? URL : [self stringUTF8Encoding:URL];//检测地址中是否混有中文
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLSessionDownloadTask *downloadTask = [_sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress.completedUnitCount,downloadProgress.totalUnitCount) : nil;
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDirectory ? fileDirectory : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建Download目录
        if (![fileManager fileExistsAtPath:downloadDir]) {
            [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        }

        //拼接文件路径
        downloadDir = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:downloadDir];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if(failure && error) {failure(error) ; return ;};
        NSString *localpath = filePath.absoluteString;
        NSArray *array = [localpath componentsSeparatedByString:@"/"];
        NSMutableArray *sarray = [[NSMutableArray alloc]initWithArray:array];
        [sarray removeLastObject];
        [sarray addObject:response.suggestedFilename];
        NSString *slocalpath = [sarray componentsJoinedByString:@"/"];
        success ? success(slocalpath /** NSURL->NSString*/) : nil;
    }];
    //开始下载
    [downloadTask resume];
    return downloadTask;
}

+ (NSURLSessionTask *)lyj_zz_downloadWithURL:(NSString *)URL
                               fileDirectory:(NSString *)fileDirectory
                                    progress:(ZZDownloadProgress)progress
                                     success:(void(^)(NSString *filePath,NSString *downloadPath,NSString *filename))success
                                     failure:(LYJ_ZZRequestFailed)failure {
    
    [ZZNetworkRequest headerRequest];

    //请求地址为空时直接返回nil
    if (URL == nil || [URL isEqualToString:@""]) {
        return nil;
    }
    URL = [URL stringByReplacingOccurrencesOfString:@" " withString:@""];//出去URL中的空格
    NSString *urlString = [NSURL URLWithString:URL] ? URL : [self stringUTF8Encoding:URL];//检测地址中是否混有中文
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLSessionDownloadTask *downloadTask = [_sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress.completedUnitCount,downloadProgress.totalUnitCount) : nil;
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDirectory ? fileDirectory : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if(failure && error) {failure(error,response.URL.absoluteString) ; return ;};
        success ? success(filePath.absoluteString,response.URL.absoluteString,response.suggestedFilename /** NSURL->NSString*/) : nil;
    }];
    //开始下载
    [downloadTask resume];
    return downloadTask;
}

#pragma mark  --- 视频上传
+ (void)zz_uploadVideoURL:(NSString *)URL
                         parameters:(NSDictionary *)parameters
                          videoPath:(NSString *)videoPath
                       successBlock:(ZZRequestSuccess)successBlock
                       failureBlock:(ZZRequestFailed)failureBlock
                     uploadProgress:(ZZUploadProgress)progress {
    
    [ZZNetworkRequest headerRequest];

    
    //请求地址为空时直接返回nil
    if (URL == nil || [URL isEqualToString:@""]) {
        return ;
    }
    URL = [URL stringByReplacingOccurrencesOfString:@" " withString:@""];//出去URL中的空格
    NSString *urlString = [NSURL URLWithString:URL] ? URL : [self stringUTF8Encoding:URL];//检测地址中是否混有中文
    
    /*! 获得视频资源 */
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:videoPath]  options:nil];
    
    /*! 创建日期格式化器 */
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    
    /*! 转化后直接写入Library---caches */
    NSString *videoWritePath = [NSString stringWithFormat:@"output-%@.mp4",[formatter stringFromDate:[NSDate date]]];
    NSString *outfilePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", videoWritePath];
    
    AVAssetExportSession *avAssetExport = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
    avAssetExport.outputURL = [NSURL fileURLWithPath:outfilePath];
    avAssetExport.outputFileType =  AVFileTypeMPEG4;
    
    [avAssetExport exportAsynchronouslyWithCompletionHandler:^{
        switch ([avAssetExport status]) {
            case AVAssetExportSessionStatusCompleted: {
                [_sessionManager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    
                    NSURL *filePathURL2 = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@", outfilePath]];
                    // 获得沙盒中的视频内容
                    [formData appendPartWithFileURL:filePathURL2 name:@"video" fileName:outfilePath mimeType:@"application/octet-stream" error:nil];
                    
                } progress:^(NSProgress * _Nonnull uploadProgress) {
                    progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);

                } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
                    successBlock(responseObject);
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     failureBlock(error);
                }];
                break;
            }
            default:  break;
        }
    }];
}



#pragma mark --- URL中文格式处理
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
+ (NSString *)stringUTF8Encoding:(NSString *)urlString {
    /**     如果是9.0之后 使用第一个  */
//    if ([[UIDevice currentDevice] systemVersion].floatValue >= 9.0) {
//        return [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
//    }else {
        return [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    }
}
#pragma clang diagnostic pop

#pragma mark - 重置AFHTTPSessionManager相关属性
+ (void)setRequestSerializer:(ZZRequestSerializer)requestSerializer {
    _sessionManager.requestSerializer = requestSerializer==ZZRequestSerializerHTTP ? [AFHTTPRequestSerializer serializer] : [AFJSONRequestSerializer serializer];
}

+ (void)setResponseSerializer:(ZZResponseSerializer)responseSerializer {
    _sessionManager.responseSerializer = responseSerializer==ZZResponseSerializerHTTP ? [AFHTTPResponseSerializer serializer] : [AFJSONResponseSerializer serializer];
}

+ (void)setRequestTimeoutInterval:(NSTimeInterval)time {
    _sessionManager.requestSerializer.timeoutInterval = time;
}

+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    [_sessionManager.requestSerializer setValue:value forHTTPHeaderField:field];
}

+ (void)openNetworkActivityIndicator:(BOOL)open {
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:open];
}

#pragma mark --- 网络状态
+ (void)zz_networkStatusWithBlock:(ZJNetworkStatusBlock)networkStatus  {
    /* 1.获得网络监控的管理者 */
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    /* 当使用AF发送网络请求时,只要有网络操作,那么在状态栏(电池条)wifi符号旁边显示  菊花提示 */
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    /* 2.设置网络状态改变后的处理 */
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /* 当网络状态改变了, 就会调用这个block */
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                networkStatus ? networkStatus(ZZNetworkStatusUnknown) : nil;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                networkStatus ? networkStatus(ZZNetworkStatusNotReachable) : nil;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                networkStatus ? networkStatus(ZZNetworkStatusReachableViaWWAN) : nil;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                networkStatus ? networkStatus(ZZNetworkStatusReachableViaWiFi) : nil;
                break;
        }
    }];
    [manager startMonitoring];
}

+ (BOOL)currentNetworkStatus {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

-(NSData *)imageData:(UIImage *)myimage
{
    NSData *data=UIImageJPEGRepresentation(myimage, 1.0);
    if (data.length>100*1024) {
        if (data.length>2*1024*1024) {//2M以及以上
            data=UIImageJPEGRepresentation(myimage, 0.05);
        }else if (data.length>1024*1024) {//1M-2M
            data=UIImageJPEGRepresentation(myimage, 0.1);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(myimage, 0.2);
        }else if (data.length>200*1024) {//0.25M-0.5M
            data=UIImageJPEGRepresentation(myimage, 0.4);
        }
    }
    return data;
}

@end


#pragma mark -
#pragma mark --- 使用YY缓存处理缓存
@implementation ZZNetworkCache
static NSString *const NetworkResponseCache = @"NetworkResponseCache";
static YYCache *_dataCache;

+ (void)initialize {
    _dataCache = [YYCache cacheWithName:NetworkResponseCache];
}

+ (void)setHttpCache:(id)httpData URL:(NSString *)URL parameters:(NSDictionary *)parameters {
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    //异步缓存,不会阻塞主线程
    [_dataCache setObject:httpData forKey:cacheKey withBlock:nil];
}

+ (id)httpCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    return [_dataCache objectForKey:cacheKey];
}

+ (NSInteger)getAllHttpCacheSize {
    return [_dataCache.diskCache totalCost];
}

+ (void)removeAllHttpCache {
    [_dataCache.diskCache removeAllObjects];
}

+ (NSString *)cacheKeyWithURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    if(!parameters){return URL;};
    // 将参数字典转换成字符串
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    
    // 将URL与转换好的参数字符串拼接在一起,成为最终存储的KEY值
    NSString *cacheKey = [NSString stringWithFormat:@"%@%@",URL,paraString];
    return cacheKey;
}

@end


#pragma mark -
#pragma mark - NSDictionary,NSArray 类别
/*
 ************************************************************************************
 *新建NSDictionary与NSArray的分类, 控制台打印json数据中的中文
 ************************************************************************************
 */

#ifdef DEBUG
@implementation NSArray (ZZ)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
     [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    
    [strM appendString:@")"];
     return strM;
}

@end

@implementation NSDictionary (ZZ)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
     [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    
    [strM appendString:@"}\n"];
    return strM;
}

@end



#endif




