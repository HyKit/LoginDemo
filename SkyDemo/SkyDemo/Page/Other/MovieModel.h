//
//  MovieModel.h
//  SkyDemo
//
//  Created by 何亚慧 on 16/8/17.
//  Copyright © 2016年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieModel : NSObject


@property (nonatomic, strong) NSString *category;

@property (nonatomic, strong) NSNumber *collectionCount;

@property (nonatomic, strong) NSNumber *replyCount;

@property (nonatomic, strong) NSNumber *shareCount;

@property (nonatomic, strong) NSString *coverBlurred;

@property (nonatomic, strong) NSString *coverForDetail;

@property (nonatomic, strong) NSString *descrip;

@property (nonatomic, strong) NSString *ID;

@property (nonatomic, strong) NSString *duration;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *playUrl;



@end
