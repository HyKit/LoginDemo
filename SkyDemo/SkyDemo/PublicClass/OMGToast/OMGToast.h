//
//  OMGToast.h
//  KXDemo
//
//  Created by 李亨达 on 14-10-11.
//  Copyright (c) 2014年 Kxtx. All rights reserved.
//

#import <Foundation/Foundation.h>
#define DEFAULT_DISPLAY_DURATION 2.0f 
@interface OMGToast : NSObject
{
    NSString *text;
    UIButton *contentView;
    CGFloat  duration;
}

+ (void)showWithText:(NSString *) text_;
+ (void)showWithText:(NSString *) text_
            duration:(CGFloat)duration_;

+ (void)showWithText:(NSString *) text_
           topOffset:(CGFloat) topOffset_;
+ (void)showWithText:(NSString *) text_
           topOffset:(CGFloat) topOffset
            duration:(CGFloat) duration_;

+ (void)showWithText:(NSString *) text_
        bottomOffset:(CGFloat) bottomOffset_;
+ (void)showWithText:(NSString *) text_
        bottomOffset:(CGFloat) bottomOffset_
            duration:(CGFloat) duration_;

+ (void)KMShowToast:(NSString *)text_;

@end
