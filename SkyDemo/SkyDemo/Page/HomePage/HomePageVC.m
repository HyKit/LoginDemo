//
//  HomePageVC.m
//  SkyDemo
//
//  Created by 何亚慧 on 16/7/19.
//  Copyright © 2016年 Sky. All rights reserved.
//

#import "HomePageVC.h"
#import "HBannerView.h"
#import "HBannerItem.h"
#import "BannerWebVC.h"
#import "PictureLictVC.h"
#import "PhotoAnimationVC.h"

@interface HomePageVC () <HBannerViewDelegate, UITableViewDelegate, UITableViewDataSource>
{
    HBannerView *_bannerView;
    
}

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation HomePageVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"首页";
    [self configUI];
    [self setApplicationBadgeNumber];
    
}

- (void)setApplicationBadgeNumber {
    /**
     *  //设置应用程序图标右上角的红色提醒数字
     //注：苹果为了增强用户体验，在iOS8以后我们需要创建通知才能实现图标右上角提醒，iOS8之前直接设置applicationIconBadgeNumber的值即可。

     */
    UIApplication *app = [UIApplication sharedApplication];
    app.applicationIconBadgeNumber = 10;
    //创建通知对象
    //这个通知会导致第一次打开app的时候， 提示用户 app将会给用户发送通知
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [app registerUserNotificationSettings:setting];
}



- (void)configUI {
    NSArray *imageArr = @[
                           @"http://kxapp.oss-cn-hangzhou.aliyuncs.com/ads_heli.png",
                           @"http://kxapp.oss-cn-hangzhou.aliyuncs.com/jzztc_android.jpg",
                           @"http://kxapp.oss-cn-hangzhou.aliyuncs.com/boerte_ios.jpg",
                           @"http://kxapp.oss-cn-hangzhou.aliyuncs.com/caocao_android.jpg",
                           @"http://kxapp.oss-cn-hangzhou.aliyuncs.com/chaoren_android.jpg",
                           @"http://kxapp.oss-cn-hangzhou.aliyuncs.com/laosun_android.jpg",
                           @"http://kxapp.oss-cn-hangzhou.aliyuncs.com/ads_heli.png",
                           @"http://kxapp.oss-cn-hangzhou.aliyuncs.com/jzztc_android.jpg",
                           ];
    
    NSMutableArray *itemMutableArr = [NSMutableArray array];
    
    for (NSString *imageUrl in imageArr) {
        
        HBannerItem *item0 = [[HBannerItem alloc] initWithTitle:@"第一个" image:imageUrl tag:[imageArr indexOfObject:imageUrl]];
        [itemMutableArr addObject:item0];
    }
    
    _bannerView = [[HBannerView alloc] initWithFrame:CGRectMake(0, 64 + 20, ScreenWidth, 140) delegate:self imageItems:[itemMutableArr mutableCopy]];
    
    _bannerView.layer.borderColor = [UIColor cyanColor].CGColor;
    _bannerView.layer.borderWidth = 1.0f;
    [self.view addSubview:_bannerView];
    
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _bannerView.maxY, ScreenWidth, ScreenHeight - _bannerView.maxY)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    UIButton *photoButton = [[UIButton alloc] initWithFrame:CGRectMake(10, _bannerView.maxY + 10, 100, 40)];
    [photoButton addTarget:self action:@selector(toPhotoAnimationVC:) forControlEvents:UIControlEventTouchUpInside];
    photoButton.backgroundColor = [UIColor magentaColor];
    [photoButton setTitle:@"动画" forState:UIControlStateNormal];
    [self.view addSubview:photoButton];
    
}


- (void)focusBannerView:(HBannerView *)banberView didSelectItem:(HBannerItem *)item {
    if (item.tag % 2) {
        [self toWebView:@{
                          @"title":@"网页",
                          @"urlString":@"http://www.cocoachina.com",
                          }];
    }
    else {
        [self toPictureListVC];
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.text = @"111";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}







- (void)toWebView:(NSDictionary *)dict {
    BannerWebVC *vc = [[BannerWebVC alloc] init];
    vc.title = dict[@"title"];
    vc.urlString = dict[@"urlString"];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)toPictureListVC {
    PictureLictVC *vc = [[PictureLictVC alloc] init];
    
    
    vc.hidesBottomBarWhenPushed = YES;

//    [self cubeAnimation];
    CATransition *anima = [CATransition animation];
    anima.type = @"cube";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [vc.view.layer addAnimation:anima forKey:@"revealAnimation"];
    
    [self.navigationController pushViewController:vc animated:NO];
}


/**
 *  立体翻滚效果
 */
-(void)cubeAnimation{
//    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = @"cube";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [self.view.layer addAnimation:anima forKey:@"revealAnimation"];
}


- (void)toPhotoAnimationVC:(UIButton *)sender {
    PhotoAnimationVC *vc = [[PhotoAnimationVC alloc] initWithStyle:UITableViewStyleGrouped];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}



@end



