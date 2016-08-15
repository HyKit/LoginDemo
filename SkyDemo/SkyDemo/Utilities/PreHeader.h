//
//  PreHeader.h
//  SkyDemo
//
//  Created by 何亚慧 on 16/7/18.
//  Copyright © 2016年 Sky. All rights reserved.
//

#ifndef PreHeader_h
#define PreHeader_h


#import <Masonry.h>
#import "UIView+Extra.h"
#import <PureLayout.h>




#define ScreenHeight    [UIScreen mainScreen].bounds.size.height
#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   ([UIScreen mainScreen].bounds.size.height - 64)

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//公共宏
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define HEXCOLOR(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0f green:((c>>8)&0xFF)/255.0f blue:(c&0xFF)/255.0f alpha:1.0f];





#endif /* PreHeader_h */
