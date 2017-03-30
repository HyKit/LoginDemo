//
//  NSObject+test.h
//  SkyDemo
//
//  Created by 何亚慧 on 2017/3/28.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (test)

@property (nonatomic, copy) NSString *name;


@end

/*
//  http://www.jianshu.com/p/c22886db98ec
 

*/
/*
 ----------------------------------------------------------------------
 什么是响应链，它是怎么工作的？
 
 这个问题笔者写过一篇博客,里面有对这个问题的详细解释
 ----------------------------------------------------------------------

 如何访问并修改一个类的私有属性？
 
 有两种方法可以访问私有属性,一种是通过KVC获取,一种是通过runtime访问并修改私有属性
 创建一个Father类,声明一个私有属性name,并重写description打印name的值,在另外一个类中通过runtime来获取并修改Father中的属性
 @interface Father ()
 @property (nonatomic, copy) NSString *name;
 @end
 @implementation Father
 
 - (NSString *)description
 {
 return [NSString stringWithFormat:@"name:%@",_name];
 }
 
 @implementation ViewController
 
 - (void)viewDidLoad {
 
 [super viewDidLoad];
 
 Father *father = [Father new];
 // count记录变量的数量IVar是runtime声明的一个宏
 unsigned int count = 0;
 // 获取类的所有属性变量
 Ivar *menbers = class_copyIvarList([Father class], &count);
 
 for (int i = 0; i < count; i++) {
 Ivar ivar = menbers[i];
 // 将IVar变量转化为字符串,这里获得了属性名
 const char *memberName = ivar_getName(ivar);
 NSLog(@"%s",memberName);
 
 Ivar m_name = menbers[0];
 // 修改属性值
 object_setIvar(father, m_name, @"zhangsan");
 // 打印后发现Father中name的值变为zhangsan
 NSLog(@"%@",[father description]);
 }
 
 }
 ----------------------------------------------------------------------

 iOS Extension 是什么？能列举几个常用的 Extension 么？
 
 Extension是扩展,没有分类名字,是一种特殊的分类,类扩展可以扩展属性,成员变量和方法
 常用的扩展是在.m文件中声明私有属性和方法,这里不知道还哪些,请大家补充
 ----------------------------------------------------------------------

 如何把一个包含自定义对象的数组序列化到磁盘？
 
 自定义对象只需要实现NSCoding协议即可
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 
 User *user = [User new];
 Account *account = [Account new];
 NSArray *userArray = @[user, account];
 // 存到磁盘
 NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject: userArray];
 }
 // 代理方法
 - (instancetype)initWithCoder:(NSCoder *)coder
 {
 self = [super initWithCoder:coder];
 if (self) {
 self.user = [aDecoder decodeObjectForKey:@"user"];
 self.account = [aDecoder decodeObjectForKey:@"account"];
 }
 return self;
 }
 // 代理方法
 -(void)encodeWithCoder:(NSCoder *)aCoder{
 [aCoder encodeObject:self.user forKey:@"user"];
 [aCoder encodeObject:self.account forKey:@"account"];
 }
 ----------------------------------------------------------------------

 Apple Pay 是什么？它的大概工作流程是怎样的？
 
 这个笔者也没有详细了解过,大家可以百度谷歌一下具体的
 ----------------------------------------------------------------------

 iOS 的沙盒目录结构是怎样的？ App Bundle 里面都有什么？
 
 1.沙盒结构
 
 Application：存放程序源文件，上架前经过数字签名，上架后不可修改
 Documents：常用目录，iCloud备份目录，存放数据,这里不能存缓存文件,否则上架不被通过
 Library
 Caches：存放体积大又不需要备份的数据,SDWebImage缓存路径就是这个
 Preference：设置目录，iCloud会备份设置信息
 tmp：存放临时文件，不会被备份，而且这个文件下的数据有可能随时被清除的可能
 2.App Bundle 里面有什么
 
 Info.plist:此文件包含了应用程序的配置信息.系统依赖此文件以获取应用程序的相关信息
 可执行文件:此文件包含应用程序的入口和通过静态连接到应用程序target的代码
 资源文件:图片,声音文件一类的
 其他:可以嵌入定制的数据资源
 ----------------------------------------------------------------------

 iOS 的签名机制大概是怎样的？
 
 假设，我们有一个APP需要发布，为了防止中途篡改APP内容，保证APP的完整性，以及APP是由指定的私钥发的。首先，先将APP内容通过摘要算法，得到摘要，再用私钥对摘要进行加密得到密文，将源文本、密文、和私钥对应的公钥一并发布即可。那么如何验证呢？
 验证方首先查看公钥是否是私钥方的，然后用公钥对密文进行解密得到摘要，将APP用同样的摘要算法得到摘要，两个摘要进行比对，如果相等那么一切正常。这个过程只要有一步出问题就视为无效。
 ----------------------------------------------------------------------
 
 iOS 7的多任务添加了哪两个新的 API? 各自的使用场景是什么？
 
 后台获取（Background Fetch):后台获取使用场景是用户打开应用之前就使app有机会执行代码来获取数据，刷新UI。这样在用户打开应用的时候，最新的内容将已然呈现在用户眼前，而省去了所有的加载过程。
 推送唤醒（Remote Notifications):使用场景是使设备在接收到远端推送后让系统唤醒设备和我们的后台应用，并先执行一段代码来准备数据和UI，然后再提示用户有推送。这时用户如果解锁设备进入应用后将不会再有任何加载过程，新的内容将直接得到呈现。
 不是没有加载过程，只是提前加载了
 ----------------------------------------------------------------------

 UIScrollView 大概是如何实现的，它是如何捕捉、响应手势的？
 
 我对UIScrollView的理解是frame就是他的contentSize,bounds就是他的可视范围,通过改变bounds从而达到让用户误以为在滚动,以下是一个简单的UIScrollView实现
 在头文件定义一个contentSize属性
 
 @interface MyScrollView : UIView
 @property (nonatomic) CGSize contentSize;
 @end
 @implementation MyScrollView
 - (instancetype)initWithFrame:(CGRect)frame{
 self = [super initWithFrame:frame];
 if (self == nil) {
 return nil;
 }
 // 添加一个滑动手势
 UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
 [self addGestureRecognizer:pan];
 return self;
 }
 
 - (void)panGesture:(UIPanGestureRecognizer *)gestureRecognizer{
 // 改变bounds
 CGPoint translation = [gestureRecognizer translationInView:self];
 CGRect bounds = self.bounds;
 
 CGFloat newBoundsOriginX = bounds.origin.x - translation.x;
 CGFloat minBoundsOriginX = 0.0;
 CGFloat maxBoundsOriginX = self.contentSize.width - bounds.size.width;
 bounds.origin.x = fmax(minBoundsOriginX, fmin(newBoundsOriginX, maxBoundsOriginX));
 
 CGFloat newBoundsOriginY = bounds.origin.y - translation.y;
 CGFloat minBoundsOriginY = 0.0;
 CGFloat maxBoundsOriginY = self.contentSize.height - bounds.size.height;
 bounds.origin.y = fmax(minBoundsOriginY, fmin(newBoundsOriginY, maxBoundsOriginY));
 
 self.bounds = bounds;
 [gestureRecognizer setTranslation:CGPointZero inView:self];
 }
 第二个问题个人理解是解决手势冲突,对自己添加的手势进行捕获和响应
 // 让UIScrollView遵守UIGestureRecognizerDelegate协议,实现这个方法,在这里方法里对添加的手势进行处理就可以解决冲突
 - (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer

 ----------------------------------------------------------------------
 Objective-C 如何对已有的方法，添加自己的功能代码以实现类似记录日志这样的功能？
 

 这题目主要考察的是runtime如何交换方法
 先在分类中添加一个方法,注意不能重写系统方法,会覆盖
 
 + (NSString *)myLog
 {
 // 这里写打印行号,什么方法,哪个类调用等等
 }
 然后交换方法
 
 // 加载分类到内存的时候调用
 + (void)load
 {
 // 获取imageWithName方法地址
 Method description = class_getClassMethod(self, @selector(description));
 
 // 获取imageWithName方法地址
 Method myLog = class_getClassMethod(self, @selector(myLog));
 
 // 交换方法地址，相当于交换实现方式
 method_exchangeImplementations(description, myLog);
 }
 ----------------------------------------------------------------------
 +load 和 +initialize 的区别是什么？
 
 +(void)load;
 当类对象被引入项目时, runtime 会向每一个类对象发送 load 消息
 load 方法会在每一个类甚至分类被引入时仅调用一次,调用的顺序：父类优先于子类, 子类优先于分类
 load 方法不会被类自动继承
 +(void)initialize;
 也是在第一次使用这个类的时候会调用这个方法

 ----------------------------------------------------------------------

 
 如何让 Category 支持属性？
 
 使用runtime可以实现
 头文件
 
 @interface NSObject (test)
 
 @property (nonatomic, copy) NSString *name;
 
 @end
 .m文件
 
 @implementation NSObject (test)
 // 定义关联的key
 static const char *key = "name";
 - (NSString *)name
 {
 // 根据关联的key，获取关联的值。
 return objc_getAssociatedObject(self, key);
 }
 - (void)setName:(NSString *)name
 {
 // 第一个参数：给哪个对象添加关联
 // 第二个参数：关联的key，通过这个key获取
 // 第三个参数：关联的value
 // 第四个参数:关联的策略
 objc_setAssociatedObject(self, key, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
 }
 
 ----------------------------------------------------------------------

 load和initliazlize区别：
 load对于加入运行期系统中的每个类及分类都会调用且仅调用一次。通常app启动时就会执行，调用顺序父类->子类->分类。
 iniitialize程序首次调用该类前调用，只调用一次，只有在用到时才调用，而load是程序会执行所有类的load，无论是否用到。
 initialize遵从普通方法的覆写如果本类没有，会调用其父类的，而load不会自动覆写。
 ----------------------------------------------------------------------
 NSOperation 相比于 GCD 有哪些优势？
 
 提供了在 GCD 中不那么容易复制的有用特性。
 可以很方便的取消一个NSOperation的执行
 可以更容易的添加任务的依赖关系
 提供了任务的状态：isExecuteing, isFinished.
 
 ----------------------------------------------------------------------
 strong / weak / unsafe_unretained 的区别？
 weak只能修饰OC对象,使用weak不会使计数器加1,对象销毁时修饰的对象会指向nil
 strong等价与retain,能使计数器加1,且不能用来修饰数据类型
 unsafe_unretained等价与assign,可以用来修饰数据类型和OC对象,但是不会使计数器加1,且对象销毁时也不会将对象指向nil,容易造成野指针错误

 如何为 Class 定义一个对外只读对内可读写的属性?
 
 在头文件中将属性定义为readonly,在.m文件中将属性重新定义为readwrite
 
----------------------------------------------------------------------
 Objective-C 中，meta-class 指的是什么？
 
 meta-class 是 Class 对象的类,为这个Class类存储类方法,当一个类发送消息时,就去那个类对应的meta-class中查找那个消息,每个Class都有不同的meta-class,所有的meta-class都使用基类的meta-class(假如类继承NSObject,那么他所对应的meta-class也是NSObject)作为他们的类
 ----------------------------------------------------------------------
 UIView 和 CALayer 之间的关系？
 
 UIView显示在屏幕上归功于CALayer，通过调用drawRect方法来渲染自身的内容，调节CALayer属性可以调整UIView的外观，UIView继承自UIResponder，CALayer不可以响应用户事件
 UIView是iOS系统中界面元素的基础，所有的界面元素都继承自它。它内部是由Core Animation来实现的，它真正的绘图部分，是由一个叫CALayer(Core Animation Layer)的类来管理。UIView本身，更像是一个CALayer的管理器，访问它的根绘图和坐标有关的属性，如frame，bounds等，实际上内部都是访问它所在CALayer的相关属性
 UIView有个layer属性，可以返回它的主CALayer实例，UIView有一个layerClass方法，返回主layer所使用的类，UIView的子类，可以通过重载这个方法，来让UIView使用不同的CALayer来显示
 ----------------------------------------------------------------------
 +[UIView animateWithDuration:animations:completion:] 内部大概是如何实现的？
 
 animateWithDuration:这就等于创建一个定时器
 animations:这是创建定时器需要实现的SEL
 completion : block中直接设置的是最终的属性，而不是每次timer调用所增加的增量。
 以上只是自己的理解,不一定正确,有对这个有研究的朋友请告知下
 

 ----------------------------------------------------------------------
 什么时候会发生「隐式动画」？
 
 当改变CALayer的一个可做动画的属性，它并不能立刻在屏幕上体现出来.相反，它是从先前的值平滑过渡到新的值。这一切都是默认的行为，你不需要做额外的操作,这就是隐式动画
 

 ----------------------------------------------------------------------
 如何处理异步的网络请求？
 
 异步请求：会单独开一个线程去处理网络请求，主线程依然处于可交互状态,程序运行流畅
 
 // POST请求
 NSString *urlString = @"www.baidu.com";
 // 创建url对象
 NSURL *url = [NSURL URLWithString:urlString];
 // 创建请求
 NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
 // 创建参数字符串对象
 NSString *parmStr = [NSString stringWithFormat:@"参数"];
 // 将字符串转换为NSData对象
 NSData *data = [parmStr dataUsingEncoding:NSUTF8StringEncoding];
 [request setHTTPBody:data];
 [request setHTTPMethod:@"POST"];
 // 创建异步连接
 [NSURLConnection connectionWithRequest:request delegate:self];
 然后实现代理方法
 
 // 服务器接收到请求时
 - (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
 {
 }
 // 当收到服务器返回的数据时触发, 返回的可能是资源片段
 - (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
 {
 }
 // 当服务器返回所有数据时触发, 数据返回完毕
 - (void)connectionDidFinishLoading:(NSURLConnection *)connection
 {
 }
 // 请求数据失败时触发
 - (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
 {
 NSLog(@"%s", __FUNCTION__);
 }
 ----------------------------------------------------------------------
 frame 和 bounds 的区别是什么？
 
 frame相对于父视图,是父视图坐标系下的位置和大小。bounds相对于自身,是自身坐标系下的位置和大小。
 frame以父控件的左上角为坐标原点，bounds以自身的左上角为坐标原点
 ----------------------------------------------------------------------
 如何把一张大图缩小为1/4大小的缩略图？
 
 let data = UIImageJPEGRepresentation(image, 0.25)
 ----------------------------------------------------------------------


 ----------------------------------------------------------------------

 ----------------------------------------------------------------------

 ----------------------------------------------------------------------

 */
















