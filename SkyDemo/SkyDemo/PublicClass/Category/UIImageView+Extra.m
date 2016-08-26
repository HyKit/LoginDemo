//
//  UIImageView+Extra.m
//  SkyDemo
//
//  Created by 何亚慧 on 16/8/24.
//  Copyright © 2016年 Sky. All rights reserved.
//

#import "UIImageView+Extra.h"

@implementation UIImageView (Extra)



/** 设置圆形图片(放到分类中使用) */
- (UIImage *)cutCircleImage {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    // 获取上下文
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    // 设置圆形
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctr, rect);
    // 裁剪
    CGContextClip(ctr);
    // 将图片画上去
//    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}




@end
