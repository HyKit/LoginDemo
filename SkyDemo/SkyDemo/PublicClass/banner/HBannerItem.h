//
//  HBannerItem.h
//  SkyDemo
//
//  Created by 何亚慧 on 16/7/21.
//  Copyright © 2016年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBannerItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, assign) NSInteger tag;


- (instancetype)initWithTitle:(NSString *)title image:(NSString *)image tag:(NSInteger)tag;
- (instancetype)initWithDict:(NSDictionary *)dict tag:(NSInteger)tag;



@end
