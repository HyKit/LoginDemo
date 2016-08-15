//
//  RootViewController.h
//  HYQDemo
//
//  Created by HYH on 16/6/30.
//  Copyright © 2016年 h. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RegisterViewController;
@class LoginViewController;


@interface RootViewController : UIViewController

@property (nonatomic, strong) UIButton *backButton;


//根据index判断是根据block还是vcName进行返回的操作,间隔交替操作
//block  和  vcName  一起传过来
//- (void)loginWithVcName:(NSString *)vcName  block:(BooleanResultBlock)block index:(NSInteger)index;
//- (void)registerWithVcName:(NSString *)vcName block:(BooleanResultBlock)block index:(NSInteger)index;


- (void)toContentVCWithName:(NSString *)vcName;

- (void)backViewController;
- (void)dismissNav;



@end
