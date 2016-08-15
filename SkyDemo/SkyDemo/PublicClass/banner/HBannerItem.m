//
//  HBannerItem.m
//  SkyDemo
//
//  Created by 何亚慧 on 16/7/21.
//  Copyright © 2016年 Sky. All rights reserved.
//

#import "HBannerItem.h"



@implementation HBannerItem
@synthesize title = _title;
@synthesize image = _image;
@synthesize tag = _tag;


- (void)dealloc {
    self.title = nil;
    self.image = nil;
    
}

- (instancetype)initWithDict:(NSDictionary *)dict tag:(NSInteger)tag {
    self = [super init];
    if (self) {
        if ([dict isKindOfClass:[NSDictionary class]]) {
            self.title = dict[@"title"];
        }
        self.tag = tag;
        
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title image:(NSString *)image tag:(NSInteger)tag {
    self = [super init];
    if (self) {
        self.title = title;
        self.image = image;
        self.tag = tag;
    }
    return self;
}

@end
