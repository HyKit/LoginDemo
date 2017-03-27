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
#import "SearchViewController.h"
#import "DropSearchViewController.h"
#import "MovieModel.h"
#import "AppDelegate.h"
#import "PIPViewController.h"
#import "AddressViewController.h"

@interface HomePageVC () <HBannerViewDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
{
    HBannerView *_bannerView;
    UISearchBar *_searchBar;
    
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *imageView;



@end

@implementation HomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"首页";
    
    [self configButton];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self setNetworkStatus];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)configButton {
    NSArray *buttonArrayName = @[@"button 高亮方法", @"MVC", @"IV渲染red", @"IV渲染cyan", @"imageview美化", @"左滑删除"];
    for (NSInteger i = 0; i < buttonArrayName.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10, 10 * (i + 1) + i * 40 + 60, 100, 40);
        button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [button setTitle:buttonArrayName[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = HEXCOLOR(0xff8400);
        [button setTag:1000 + i];
        [self.view addSubview:button];
    }
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(130, 160, 50, 50)];
    _imageView.layer.borderColor = kMainColor.CGColor;
    _imageView.layer.borderWidth = 1.0f;
    
    [self.view addSubview:_imageView];
    
}
- (void)buttonClicked:(UIButton *)sender {
    NSInteger index = sender.tag - 1000;
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    switch (index) {
        case 0:
            [delegate launchModule:@"自定义Button"];
            break;
        case 1:
            [delegate launchModule:@"MVC"];
            break;
        case 2:
            [self changeImageColor:[UIColor redColor]];
            break;
        case 3:
            [self changeImageColor:[UIColor cyanColor]];
            break;
        case 4:
            [self toPIP];
            break;
        case 5: //左滑删除
            [self toDeleteAnimation];
            break;
        default:
            break;
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self setSearchView];
}
//- (void)setSearchView {
//    if (!_searchBar) {
//        
//        
//        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(50, 100, ScreenWidth - 100, 44)];
//        bgView.backgroundColor = [UIColor colorWithRed:0.8702 green:0.8702 blue:0.8702 alpha:1.0];
//        [self.view addSubview:bgView];
//        
//        
//        
//        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(50, 0, ScreenWidth - 100, 49)];
//        _searchBar.placeholder = @"input  cargo name";
//        _searchBar.delegate = self;
//        
//        
//        [self.navigationController.navigationBar addSubview:_searchBar];
//    }
//
//}
//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
//    [self toDropDownSearchVC];
//    return YES;
//}

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



- (void)toDropDownSearchVC {
    
//    [_searchBar removeFromSuperview];
    
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Search" bundle:nil];
//    DropSearchViewController *vc = [sb instantiateViewControllerWithIdentifier:@"DropSearchViewController"];
//    vc.hidesBottomBarWhenPushed = YES;
//    
//    [self.navigationController pushViewController:vc animated:YES];
//    NSLog(@"tab  ===== %@", self.tabBarController.tabBar);
    
    
}


//在我们使用应用的时候，每当有网络请求产生时，我们总是可以在状态栏看到一个转动的网络请求标志。这个标志并不是在网络请求发生的时候自动出现的，需要在代码中手动启动和关闭。
- (void)setNetworkStatus {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];// 启动状态栏网络请求指示
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];// 关闭状态来网络请求指示

}

//用代码改变image的渲染颜色。
- (void)changeImageColor:(UIColor *)color {
    
    UIImage *theImage = [[UIImage imageNamed:@"CenterBtn"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.imageView.image = theImage;
    [self.imageView setTintColor:color];
}

- (void)toPIP {
    
    PIPViewController *vc = [[PIPViewController alloc] initWithNibName:@"PIPViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)toDeleteAnimation {
    AddressViewController *vc = [[AddressViewController alloc] initWithNibName:@"AddressViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}


@end



