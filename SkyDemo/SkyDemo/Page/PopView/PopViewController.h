//
//  PopViewController.h
//  SkyDemo
//
//  Created by 何亚慧 on 16/7/27.
//  Copyright © 2016年 Sky. All rights reserved.
//

#import "RootViewController.h"

@interface PopViewController : RootViewController

//点击中间的加号 出现的页面


/**
 *   @"UIViewContentModeScaleToFill",      // 拉伸自适应填满整个视图
 根据视图的比例去拉伸图片内容。
 @"UIViewContentModeScaleAspectFit",   // 自适应比例大小显示
 保持图片内容的纵横比例，来适应视图的大小。
 @"UIViewContentModeScaleAspectFill",  // 原始大小显示
 用图片内容来填充视图的大小，多余得部分可以被修剪掉来填充整个视图边界
 @"UIViewContentModeRedraw",           // 尺寸改变时重绘
 @"UIViewContentModeCenter",           // 中间
 @"UIViewContentModeTop",              // 顶部
 @"UIViewContentModeBottom",           // 底部
 @"UIViewContentModeLeft",             // 中间贴左
 @"UIViewContentModeRight",            // 中间贴右
 @"UIViewContentModeTopLeft",          // 贴左上
 @"UIViewContentModeTopRight",         // 贴右上
 @"UIViewContentModeBottomLeft",       // 贴左下
 @"UIViewContentModeBottomRight",      // 贴右下
 */



- (void)showMenu;



@end
