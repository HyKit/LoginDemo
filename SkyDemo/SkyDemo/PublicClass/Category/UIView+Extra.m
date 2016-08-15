//
//  UIView+Extra.m
//  SkyDemo
//
//  Created by 何亚慧 on 16/7/26.
//  Copyright © 2016年 Sky. All rights reserved.
//

#import "UIView+Extra.h"

@implementation UIView (Extra)
- (CGFloat)centerX
{
    return self.center.x;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x
{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y
{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}

- (void)setMaxX:(CGFloat)maxX
{
    CGRect rect = self.frame;
    rect.origin.x = maxX-rect.size.width;
    self.frame = rect;
}

- (void)setMaxY:(CGFloat)maxY
{
    CGRect rect = self.frame;
    rect.origin.y = maxY-rect.size.height;
    self.frame = rect;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}

#pragma mark - 画线
+ (void)drawLineFromStart:(CGPoint )start toEnd:(CGPoint )end withColor:(UIColor *)color andLineWidth:(CGFloat)lineWidth toView:(UIView *)view
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.strokeColor = [color CGColor];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:start];
    [path addLineToPoint:end];
    shapeLayer.path = path.CGPath;
    [view.layer addSublayer:shapeLayer];
}

#pragma mark - 画一个label
+ (UILabel *)drawLabelWithString:(NSString *)string andframe:(CGRect)rect andColor:(UIColor *)color andFont:(UIFont *)font width:(CGFloat)width
{
    UILabel *lab = [[UILabel alloc] initWithFrame:rect];
    lab.font = font;
    lab.text = string;
    lab.textColor = color;
    lab.textAlignment = 1;
    lab.contentMode = UIViewContentModeLeft;
    lab.width = width;
    lab.height = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.height;
    return lab;
}

@end
