//
//  UILabel+CustomLabel.h
//  SkyDemo
//
//  Created by 何亚慧 on 2017/3/24.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (CustomLabel)


+ (UILabel *)labelWithFrame:(CGRect)frame title:(NSString *)title
                  textColor:(UIColor *)textColor
                       font:(UIFont *)font;

@end
