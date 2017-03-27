//
//  UIButton+CustomButton.m
//  SkyDemo
//
//  Created by 何亚慧 on 2017/3/24.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "UIButton+CustomButton.h"

@implementation UIButton (CustomButton)


+ (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title bgColor:(UIColor *)bgColor titleColor:(UIColor *)titleColor fontSize:(CGGlyph)fontSize {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.backgroundColor = bgColor;
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    return button;
}
@end
