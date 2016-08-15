//
//  SkyTabBarButton.m
//  SWK
//
//  Created by 李亨达 on 15-4-2.
//  Copyright (c) 2015年 Kxtx. All rights reserved.
//

#import "SkyTabBarButton.h"

@implementation SkyTabBarButton

-(void)layoutSubviews {
    [super layoutSubviews];
    
    // Center image
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width/2;
    //center.y = self.imageView.frame.size.height/2;
    center.y=self.frame.size.height/2-self.imageView.frame.size.height/2+4;
    self.imageView.center = center;
    
    //Center text
    CGRect newFrame = [self titleLabel].frame;
    newFrame.origin.x = 0;
    newFrame.origin.y = self.frame.size.height/2+newFrame.size.height/2;
    newFrame.size.width = self.frame.size.width;
    
    self.titleLabel.frame = newFrame;
    self.titleLabel.textAlignment = 1;
}
@end
