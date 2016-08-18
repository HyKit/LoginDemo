//
//  MovieModel.m
//  SkyDemo
//
//  Created by 何亚慧 on 16/8/17.
//  Copyright © 2016年 Sky. All rights reserved.
//

#import "MovieModel.h"

@implementation MovieModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"description"]) {
        
        self.descrip = value;
        
    }
    
    if ([key isEqualToString:@"id"]) {
        
        self.ID = [value stringValue];
        
    }
    
}

- (void)setValue:(id)value forKey:(NSString *)key{
    
    [super setValue:value forKey:key];
    
    if ([key isEqualToString:@"duration"]) {
        
        self.duration = [value stringValue];
        
    }
    
    //    if ([key isEqualToString:@"collectionCount"]) {
    //
    //        self.collectionCount = [value stringValue];
    //
    //    }
    //
    //    if ([key isEqualToString:@"replyCount"]) {
    //
    //        self.replyCount = [value stringValue];
    //
    //    }
    //
    //    if ([key isEqualToString:@"shareCount"]) {
    //
    //        self.shareCount = [value stringValue];
    //        
    //    }
    
}

@end
