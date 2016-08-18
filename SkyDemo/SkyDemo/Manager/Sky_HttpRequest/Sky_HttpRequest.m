//
//  Sky_HttpRequest.m
//  SkyDemo
//
//  Created by 何亚慧 on 16/8/17.
//  Copyright © 2016年 Sky. All rights reserved.
//

#import "Sky_HttpRequest.h"
#define serverUrl @"http://192.168.1.1:8080/jiekou"



@implementation Sky_HttpRequest


+ (void)POST:(NSString *)URL
      params:(NSDictionary * )params
     progress:(void (^)(NSProgress *))_uploadProgress
     success:(void (^)(id response))success
     failure:(void (^)(NSError *error))Error
{
    // 创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 请求超时时间
    
    manager.requestSerializer.timeoutInterval = 30;
    NSString *postStr = URL;
    if (![URL hasPrefix:@"http"]) {
        
        postStr = [NSString stringWithFormat:@"%@%@", serverUrl,URL] ;
    }
    NSMutableDictionary *dict = [params mutableCopy];
    // 发送post请求

    [manager POST:postStr parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        if (_uploadProgress) {
            _uploadProgress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        if (success) {
            success(responseDict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (Error) {
            Error(error);
        }
    }];
    
}

+ (void)GET:(NSString *)URL
   progress:(void (^)(NSProgress *))_uploadProgress
    success:(void (^)(id response))success
    failure:(void (^)(NSError *error))Error
{
    // 获得请求管理者
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setHTTPShouldHandleCookies:NO];
    manager.requestSerializer.timeoutInterval = 30;
    NSString *getStr = URL;
    //    NSLog(@"getStr======%@",getStr);
    if (![URL hasPrefix:@"http"]) {
        
        getStr = [NSString stringWithFormat:@"%@%@", serverUrl,URL] ;
    }
    
    
    // 发送GET请求
    [manager GET:getStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        if (_uploadProgress) {
            _uploadProgress(downloadProgress);
        }

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        if (success) {
            success(responseDict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (Error) {
            Error(error);
        }
    }];
    
}

+ (void)UPLOADIMAGE:(NSString *)URL
             params:(NSDictionary *)params
        uploadImage:(UIImage *)image
           progress:(void (^)(NSProgress *))_uploadProgress
            success:(void (^)(id response))success
            failure:(void (^)(NSError *error))Error
{
    // 创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    //    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //
    //    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSString *postStr = [NSString stringWithFormat:@"%@%@", serverUrl,URL] ;
    NSMutableDictionary *dict = [params mutableCopy];
    
    [manager POST:postStr parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
        [formData appendPartWithFileData:imageData name:@"img" fileName:@"head.jpg" mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (_uploadProgress) {
            _uploadProgress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        if (success) {
            success(responseDict);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (Error) {
            Error(error);
        }
    }];
    
    
    
}

@end
