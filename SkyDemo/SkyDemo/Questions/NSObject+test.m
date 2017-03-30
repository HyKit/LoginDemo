//
//  NSObject+test.m
//  SkyDemo
//
//  Created by 何亚慧 on 2017/3/28.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "NSObject+test.h"

static const char *key = "name";

@implementation NSObject (test)

-(NSString *)name {
    return objc_getAssociatedObject(self, key);
}

- (void)setName:(NSString *)name {
    objc_setAssociatedObject(self, key, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}




@end


/*
 ----------------------------------------------------------------------

 Push Notification 是如何工作的？
 
 推送通知分为两种,一个是本地推送,一个是远程推送
 本地推送:不需要联网也可以推送,是开发人员在APP内设定特定的时间来提醒用户干什么
 远程推送:需要联网,用户的设备会于苹果APNS服务器形成一个长连接,用户设备会发送uuid和Bundle idenidentifier给苹果服务器,苹果服务器会加密生成一个deviceToken给用户设备,然后设备会将deviceToken发送给APP的服务器,服务器会将deviceToken存进他们的数据库,这时候如果有人发送消息给我,服务器端就会去查询我的deviceToken,然后将deviceToken和要发送的信息发送给苹果服务器,苹果服务器通过deviceToken找到我的设备并将消息推送到我的设备上,这里还有个情况是如果APP在线,那么APP服务器会于APP产生一个长连接,这时候APP服务器会直接通过deviceToken将消息推送到设备上
 --------------------------------------------------------------------
 什么是 Runloop？
 
 是一个与线程相关的机制,可以理解为一个循环,在这个循环里面等待事件然后处理事件.而这个循环是基于线程的,在Cocoa中每个线程都有它的runroop,通过他这样的机制,线程可以在没有事件要处理的时候休息,有事件运行,减轻CPU压力,这题可以衍生出为什么在滑动时会导致定时器失败,在下面有解答
 --------------------------------------------------------------------
 Toll-Free Bridging 是什么？什么情况下会使用？
 
 Toll-Free Bridging用于在Foundation对象与Core Foundation对象之间交换数据,俗称桥接
 
 在ARC环境下,Foundation对象转成 Core Foundation对象
 使用__bridge桥接以后ARC会自动2个对象
 使用__bridge_retained桥接需要手动释放Core Foundation对象
 在ARC环境下, Core Foundation对象转成 Foundation对象
 使用__bridge桥接,如果Core Foundation对象被释放,Foundation对象也同时不能使用了,需要手动管理Core Foundation对象
 使用__bridge_transfer桥接,系统会自动管理2个对象
 --------------------------------------------------------------------

 当系统出现内存警告时会发生什么？
 
 会将不在当前窗口上的view暂时移除
 如果放任内存警告,最终会导致软件强制被系统关闭
 --------------------------------------------------------------------

 什么是 Protocol，Delegate 一般是怎么用的？
 
 协议是一个方法签名的列表，在其中可以定义若干个方法,遵守该协议的类可以实现协议里的方法,在协议中使用@property只会生成setter和getter方法的声明
 delegate用法:成为一个类的代理,可以去实现协议里的方法
 --------------------------------------------------------------------

 autorelease 对象在什么情况下会被释放？
 
 分两种情况：手动干预释放和系统自动释放
 手动干预释放就是指定autoreleasepool,当前作用域大括号结束就立即释放
 系统自动去释放:不手动指定autoreleasepool,Autorelease对象会在当前的 runloop 迭代结束时释放
 kCFRunLoopEntry(1):第一次进入会自动创建一个autorelease
 kCFRunLoopBeforeWaiting(32):进入休眠状态前会自动销毁一个autorelease,然后重新创建一个新的autorelease
 kCFRunLoopExit(128):退出runloop时会自动销毁最后一个创建的autorelease
 --------------------------------------------------------------------

 为什么 NotificationCenter 要 removeObserver? 如何实现自动 remove?
 
 如果不移除的话,万一注册通知的类被销毁以后又发了通知,程序会崩溃.因为向野指针发送了消息
 实现自动remove:通过自释放机制,通过动态属性将remove转移给第三者,解除耦合,达到自动实现remove
 --------------------------------------------------------------------

 当 TableView 的 Cell 改变时，如何让这些改变以动画的形式呈现？
 
 这里举个例子,点击cell以后以动画形式改变cell高度
 
 @interface ViewController ()
 @property (nonatomic, strong) NSIndexPath *index;
 @end
 
 @implementation ViewController
 
 static NSString *ID = @"cell";
 - (void)viewDidLoad {
 
 [super viewDidLoad];
 
 
 }
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
 cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
 return cell;
 }
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
 return 20;
 }
 
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 
 if(self.index == indexPath){
 
 return 120;
 }
 
 return 60;
 }
 
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 self.index = indexPath;
 
 [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
 // 重点是这2句代码实现的功能
 [tableView beginUpdates];
 [tableView endUpdates];
 }
 --------------------------------------------------------------------

 为什么 UIScrollView 的滚动会导致 NSTimer 失效？
 
 定时器里面有个runoop mode,一般定时器是运行在defaultmode上但是如果滑动了这个页面,主线程runloop会转到UITrackingRunLoopMode中,这时候就不能处理定时器了,造成定时器失效,原因就是runroop mode选错了,
 解决办法有2个,一个是更改mode为NSRunLoopCommonModes(无论runloop运行在哪个mode,都能运行),还有种办法是切换到主线程来更新UI界面的刷新
 --------------------------------------------------------------------

 为什么当 Core Animation 完成时，layer 又会恢复到原先的状态？
 
 因为这些产生的动画只是假象,并没有对layer进行改变.那么为什么会这样呢,这里要讲一下图层树里的呈现树.呈现树实际上是模型图层的复制,但是它的属性值表示了当前外观效果,动画的过程实际上只是修改了呈现树,并没有对图层的属性进行改变,所以在动画结束以后图层会恢复到原先状态
 --------------------------------------------------------------------

 你会如何存储用户的一些敏感信息，如登录的 token
 
 使用keychain来存储,也就是钥匙串,使用keychain需要导入Security框架
 自定义一个keychain的类
 
 #import <Security/Security.h>
 
 @implementation YCKKeyChain
 
 + (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
 return [NSMutableDictionary dictionaryWithObjectsAndKeys:
 (__bridge_transfer id)kSecClassGenericPassword,(__bridge_transfer id)kSecClass,
 service, (__bridge_transfer id)kSecAttrService,
 service, (__bridge_transfer id)kSecAttrAccount,
 (__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock,(__bridge_transfer id)kSecAttrAccessible,
 nil];
 }
 
 + (void)save:(NSString *)service data:(id)data {
 // 获得搜索字典
 NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
 // 添加新的删除旧的
 SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
 // 添加新的对象到字符串
 [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge_transfer id)kSecValueData];
 // 查询钥匙串
 SecItemAdd((__bridge_retained CFDictionaryRef)keychainQuery, NULL);
 }
 
 + (id)load:(NSString *)service {
 id ret = nil;
 NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
 // 配置搜索设置
 [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
 [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
 CFDataRef keyData = NULL;
 if (SecItemCopyMatching((__bridge_retained CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
 @try {
 ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge_transfer NSData *)keyData];
 } @catch (NSException *e) {
 NSLog(@"Unarchive of %@ failed: %@", service, e);
 } @finally {
 }
 }
 return ret;
 }
 
 + (void)delete:(NSString *)service {
 NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
 SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
 }
 在别的类实现存储,加载,删除敏感信息方法
 
 // 用来标识这个钥匙串
 static NSString * const KEY_IN_KEYCHAIN = @"com.yck.app.allinfo";
 // 用来标识密码
 static NSString * const KEY_PASSWORD = @"com.yck.app.password";
 
 + (void)savePassWord:(NSString *)password
 {
 NSMutableDictionary *passwordDict = [NSMutableDictionary dictionary];
 [passwordDict setObject:password forKey:KEY_PASSWORD];
 [YCKKeyChain save:KEY_IN_KEYCHAIN data:passwordDict];
 }
 
 + (id)readPassWord
 {
 NSMutableDictionary *passwordDict = (NSMutableDictionary *)[YCKKeyChain load:KEY_IN_KEYCHAIN];
 return [passwordDict objectForKey:KEY_PASSWORD];
 }
 
 + (void)deletePassWord
 {
 [YCKKeyChain delete:KEY_IN_KEYCHAIN];
 }
 --------------------------------------------------------------------

 有用过一些开源组件吧，能简单说几个么，大概说说它们的使用场景实现。
 
 AFN:网络请求
 FMDB:使用数据库
 MJExtension: JSON与Model互转
 SVProgressHUD:提示HUD
 Masonry:自动布局
 MJRefresh:下拉和上拉刷新
 --------------------------------------------------------------------

 什么时候会发生 EXC BAD ACCESS 异常？
 
 访问一个僵尸对象，访问僵尸对象的成员变量或者向其发消息；
 死循环
 --------------------------------------------------------------------

 NSNotification 和 KVO 的使用场景？
 
 KVO使用场景:当一个对象的特定属性改变的时候，需要被通知一个或者多个对象的时候
 NSNotification使用场景:跨层级传递值,多个对象通知多个对象
 --------------------------------------------------------------------

 使用 Block 时需要注意哪些问题？
 
 在block内部使用外部指针且会造成循环引用情况下,需要用__weak修饰外部指针
 __weak typeof(self) weakSelf = self;
 在block内部如果调用了延时函数还使用弱指针会取不到该指针,因为已经被销毁了,需要在block内部再将弱指针重新强引用一下__strong typeof(self) strongSelf = weakSelf;
 如果需要在block内部改变外部变量的话,需要在用__block修饰外部变量
 笔者也写过一篇block博客
 --------------------------------------------------------------------

 performSelector:withObject:afterDelay: 内部大概是怎么实现的，有什么注意事项么？
 
 创建一个定时器,时间结束后系统会使用runtime通过方法名称(Selector本质就是方法名称)去方法列表中找到对应的方法实现并调用方法
 注意事项
 调用performSelector:withObject:afterDelay:方法时,先判断希望调用的方法是否存在respondsToSelector:
 这个方法是异步方法,必须在主线程调用,在子线程调用永远不会调用到想调用的方法
 使用 NSUserDefaults 时，如何处理布尔的默认值？(比如返回 NO，不知道是真的 NO 还是没有设置过)
 
 if([[NSUserDefaults standardUserDefaults] objectForKey:ID] == nil){
 NSLog(@"没有设置");
 }
 哪些途径可以让 ViewController 瘦下来？
 
 把 Data Source 和其他 Protocols 分离出来(将UITableView或者UICollectionView的代码提取出来放在其他类中)
 将业务逻辑移到 Model 中(和模型有关的逻辑全部在model中写)
 把网络请求逻辑移到 Model 层(网络请求依靠模型)
 把 View 代码移到 View 层(自定义View)
 有哪些常见的 Crash 场景？
 
 访问了僵尸对象
 访问了不存在的方法
 数组越界
 在定时器下一次回调前将定时器释放,会Crash

 
 */
