//
//  Sky_HttpRequest.h
//  SkyDemo
//
//  Created by 何亚慧 on 16/8/17.
//  Copyright © 2016年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"



#define serverUrl @"http://192.168.1.1:8080/jiekou"


@interface Sky_HttpRequest : NSObject


+ (void)POST:(NSString *)URL
      params:(NSDictionary * )params
    progress:(void (^)(NSProgress *))_uploadProgress
     success:(void (^)(id response))success
     failure:(void (^)(NSError *error))Error;


+ (void)GET:(NSString *)URL
   progress:(void (^)(NSProgress *))_uploadProgress
    success:(void (^)(id response))success
    failure:(void (^)(NSError *error))Error;

+ (void)UPLOADIMAGE:(NSString *)URL
             params:(NSDictionary *)params
        uploadImage:(UIImage *)image
           progress:(void (^)(NSProgress *))_uploadProgress
            success:(void (^)(id response))success
            failure:(void (^)(NSError *error))Error;


@end
