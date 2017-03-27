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

#import "UIImageView+WebCache.h"
#import "UIImageView+AFNetworking.h"
#import "Sky_HttpRequest.h"
#import "OMGToast.h"
#import "YYKit.h"
#import "UILabel+CustomLabel.h"
#import "UIButton+CustomButton.h"





#define ScreenHeight    [UIScreen mainScreen].bounds.size.height
#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   ([UIScreen mainScreen].bounds.size.height - 64)

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//公共宏
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define HEXCOLOR(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0f green:((c>>8)&0xFF)/255.0f blue:(c&0xFF)/255.0f alpha:1.0f]


#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kSelfWidth self.frame.size.width
#define kSelfHeight self.frame.size.height


//--------------begin  新版颜色 标准-------------------
#define kMainColor     HEXCOLOR(0xff8400)  //主色调，
#define kColor333333   HEXCOLOR(0x333333)  //重要文字信息，类目名称，正文标题
#define kColor666666   HEXCOLOR(0x666666)  //普通级段落信息，段落内文的文字
#define kColor999999   HEXCOLOR(0x999999)  //用于辅助，次要的文字信息，不可点击按钮文字
#define kColord2d2d2   HEXCOLOR(0xd2d2d2)  //用于提示输入文字，普通级别小icon,如次要文字色块底色
#define kColore6e6e6   HEXCOLOR(0xe6e6e6)  //用于分割线，不可点击按钮底色，或者次要icon
#define kColorf5f5f5   HEXCOLOR(0xf5f5f5)  //用于内容区域底色，

#define kColorfb5100   HEXCOLOR(0xfb5100)  //用于主色按钮点击效果
#define kColorff6b00   HEXCOLOR(0xff6b00)  //用于首页不同角色icon颜色
#define kColorff9c00   HEXCOLOR(0xff9c00)  //用于首页不同角色icon颜色
#define kColorfccc00   HEXCOLOR(0xfccc00)  //用于点缀小图标，订单，运单不同状态
#define kColorf25d5c   HEXCOLOR(0xf25d5c)  //用于点缀小图标,删除操作底色，订单，运单不同状态
#define kColor12b7f5   HEXCOLOR(0x12b7f5)  //用于点缀小图标，链接字体颜色，订单，运单不同状态
#define kColor2bd2c8   HEXCOLOR(0x2bd2c8)  //用于点缀小图标，订单，运单不同状态
#define kColor70ca57   HEXCOLOR(0x70ca57)  //用于点缀小图标，完成对勾底色订单，运单不同状态

//--------------end  颜色 -----------------------

#endif /* PreHeader_h */
