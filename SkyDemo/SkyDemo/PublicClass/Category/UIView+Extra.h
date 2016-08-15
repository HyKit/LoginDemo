//
//  UIView+Extra.h
//  SkyDemo
//
//  Created by 何亚慧 on 16/7/26.
//  Copyright © 2016年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extra)
@property(nonatomic,assign)CGFloat centerX;
@property(nonatomic,assign)CGFloat centerY;
@property(nonatomic,assign)CGFloat x;
@property(nonatomic,assign)CGFloat y;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)CGFloat maxX;
@property(nonatomic,assign)CGFloat maxY;
@property(nonatomic,assign)CGSize size;

#define kxtxRGB(r,g,b,a) [UIColor colorWithRed:r/256.0 green:g/256.0 blue:b/256.0 alpha:a]

#pragma mark - 画线
+ (void)drawLineFromStart:(CGPoint )start toEnd:(CGPoint )end withColor:(UIColor *)color andLineWidth:(CGFloat)lineWidth toView:(UIView *)view;

#pragma mark - 画label
+ (UILabel *)drawLabelWithString:(NSString *)string andframe:(CGRect)rect andColor:(UIColor *)color andFont:(UIFont *)font width:(CGFloat)width;


@end
