//
//  NSObject+NewBeeNotification.h
//  userApp
//
//  Created by 张烨 on 16/8/4.
//  Copyright © 2016年 张烨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NewBeeNotification)

/**
 *  处理处理通知
 *
 *  @param notification
 */
- (void)handleNotification:(NSNotification *)notification;
/**
 *  注册通知
 *
 *  @param name 通知名称
 */
- (void)observeNotification:(NSString *)name;
/**
 *  取消注册通知
 *
 *  @param name 通知名称
 */
- (void)unobserveNotification:(NSString *)name;
/**
 *  取消注册的所有通知
 */
- (void)unobserveAllNotifications;
/**
 *  发送通知
 *
 *  @param name 通知名称
 *
 *  @return
 */
- (void)postNotification:(NSString *)name;
/**
 *  发送通知并传递参数
 *
 *  @param name   通知名称
 *  @param object 传递的参数
 *
 *  @return
 */
- (void)postNotification:(NSString *)name withObject:(NSObject *)object;
/**
 *  发送通知并传递参数
 *
 *  @param name   通知名称
 *  @param object 传递的参数
 *  @param info 传递的参数
 *
 *  @return
 */
- (void)postNotification:(NSString *)name withObject:(NSObject *)object userInfo:(NSDictionary *)info;


@end
