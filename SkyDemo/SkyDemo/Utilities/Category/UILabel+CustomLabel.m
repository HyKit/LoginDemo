//
//  UILabel+CustomLabel.m
//  SkyDemo
//
//  Created by 何亚慧 on 2017/3/24.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "UILabel+CustomLabel.h"

@implementation UILabel (CustomLabel)

+ (UILabel *)labelWithFrame:(CGRect)frame title:(NSString *)title
                        textColor:(UIColor *)textColor
                             font:(UIFont *)font{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.textColor = textColor;
    label.font = font;
    
    return label;
}

@end
