//
//  DJZJ_RequestTool.m
//  DJZJ
//
//  Created by a on 2019/6/12.
//  Copyright © 2019 a. All rights reserved.
//

#import "DJZJ_RequestTool.h"
#import "AFNetworking.h"

static AFHTTPSessionManager *_sessionManager;

@implementation DJZJ_RequestTool

+(void)initialize{
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    _sessionManager = [AFHTTPSessionManager manager];
    
//    AFJSONResponseSerializer * response = [AFJSONResponseSerializer serializer];
//    _sessionManager.responseSerializer = response;
//    _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];

    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",@"text/plain",@"image/gif", nil];
    [_sessionManager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
//    [_sessionManager.requestSerializer setValue:@"" forHTTPHeaderField:@""];
    _sessionManager.requestSerializer.timeoutInterval = 15.0f;
    
    _sessionManager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    _sessionManager.securityPolicy.allowInvalidCertificates = YES;
    _sessionManager.securityPolicy.validatesDomainName = NO;
}

+ (instancetype) shareManager {
    static DJZJ_RequestTool * client = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[DJZJ_RequestTool alloc]init];
    });
    return client;
}

+ (void) LJX_requestWithType:(LJXRequestType)type URL:(NSString *)url params:(NSDictionary *)params successBlock:(LJXSuccessBlock)successBlock failureBlock:(LJXFailureBlock)failureBlock{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //无条件的信任服务器上的证书
    AFSecurityPolicy *securityPolicy =  [AFSecurityPolicy defaultPolicy];
    // 客户端是否信任非法证书
    securityPolicy.allowInvalidCertificates = YES;
    // 是否在证书域字段中验证域名
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;

    [self requestWithType:type requestURL:url params:params success:successBlock failure:failureBlock];
}

+ (NSURLSessionTask *) requestWithType:(LJXRequestType)requestType requestURL:(NSString *)requestURL params:(NSDictionary *)params success:(LJXSuccessBlock)success failure:(LJXFailureBlock)failure {
    
    if ([requestURL isEqualToString:@""] || requestURL == nil) {
        return nil;
    }
    requestURL = [requestURL stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *urlString = [NSURL URLWithString:requestURL] ? requestURL : [self stringUTF8Encoding:requestURL];//检测地址中是否混有中文

    NSLog(@"urlString = %@",urlString);
    
    if (requestType == LJX_GET) {
        
       NSURLSessionTask * task = [_sessionManager GET:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            success ? success(responseObject) : nil;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            failure ? failure(error) : nil;
        }];
    
        return task;
    } else {
        
         NSURLSessionTask * task = [_sessionManager POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            success ? success(responseObject) : nil;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            failure ? failure(error) : nil;
        }];

        return task;
    }
}

#pragma mark - 图片上传
/* 批量上传图片 */
+ (void)LJX_uploadPicWithURL:(NSString *)URL
              parameters:(NSDictionary *)parameters
                  images:(NSArray<UIImage *> *)images
                    name:(NSString *)name
                fileName:(NSString *)fileName
                mimeType:(NSString *)mimeType
                progress:(LJXUploadProgress)progressBlock
                 success:(LJXSuccessBlock)successBlock
                 failure:(LJXFailureBlock)failureBlock {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //无条件的信任服务器上的证书
    AFSecurityPolicy *securityPolicy =  [AFSecurityPolicy defaultPolicy];
    // 客户端是否信任非法证书
    securityPolicy.allowInvalidCertificates = YES;
    // 是否在证书域字段中验证域名
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;
    
    [self uploadWithURL:URL parameters:parameters images:images name:name fileName:fileName mimeType:mimeType progress:progressBlock success:successBlock failure:failureBlock];
}

#pragma mark  --- 上传图片文件
+ (NSURLSessionTask *)uploadWithURL:(NSString *)URL
                            parameters:(NSDictionary *)parameters
                                images:(NSArray<UIImage *> *)images
                                  name:(NSString *)name
                              fileName:(NSString *)fileName
                              mimeType:(NSString *)mimeType
                              progress:(LJXUploadProgress)progress
                               success:(LJXSuccessBlock)success
                               failure:(LJXFailureBlock)failure {
    
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
            NSLog(@"imageData = %@",imageData);
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


+ (void )uploadPicAloneWithURL:(NSString *)URL
                    parameters:(NSDictionary *)parameters
                      mimeType:(NSString *)mimeType
                      progress:(LJXUploadProgress)progressBlock
                       success:(LJXSuccessBlock)successBlock
                       failure:(LJXFailureBlock)failureBlock{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //无条件的信任服务器上的证书
    AFSecurityPolicy *securityPolicy =  [AFSecurityPolicy defaultPolicy];
    // 客户端是否信任非法证书
    securityPolicy.allowInvalidCertificates = YES;
    // 是否在证书域字段中验证域名
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;
    
    [self uploadListWithURL:URL parameters:parameters mimeType:mimeType progress:progressBlock success:successBlock failure:failureBlock];
}

+ (NSURLSessionTask *)uploadListWithURL:(NSString *)URL
                                parameters:(NSDictionary *)parameters
                                  mimeType:(NSString *)mimeType
                                  progress:(LJXUploadProgress)progress
                                   success:(LJXSuccessBlock)success
                                   failure:(LJXFailureBlock)failure {
    
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

+ (NSString *)stringUTF8Encoding:(NSString *)urlString {
    /**     如果是9.0之后 使用第一个  */
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 9.0) {
        return [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    }else {
        return [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
}

+ (NSString *) URLDecodedString:(NSString *) str{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

@end
