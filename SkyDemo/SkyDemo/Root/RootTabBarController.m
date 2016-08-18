//
//  RootTabBarController.m
//  HYQDemo
//
//  Created by 何亚慧 on 16/7/6.
//  Copyright © 2016年 h. All rights reserved.
//

#import "RootTabBarController.h"
#import "HomePageVC.h"
#import "UserCenterVC.h"
#import "SWRevealViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "BaseAnimationController.h"
#import "PopViewController.h"
#import "ShopListViewController.h"
#import "HyPopMenuView.h"


@interface RootTabBarController () <HyPopMenuViewDelegate>

{
    HyPopMenuView *_menu;
}

@end


@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configUI];
    [self configMenu];
    
    
}

- (void)setUserAgent {
    NSString *identifier = @"SkyDemo";
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
    NSString *userAgent = [[UIWebView new] stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    if ([userAgent rangeOfString:identifier].location == NSNotFound) {
        NSString *version = info[@"CFBundleShortVersionString"];
        NSString *infoUserAgent = [NSString stringWithFormat:@" /%@/%@", identifier, version];
        NSString *customUserAgent = [NSString stringWithFormat:@"%@%@", userAgent, infoUserAgent];
        [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent":customUserAgent}];
    }
    
}


- (void)configUI {
    
    //左侧菜单栏
    LeftViewController *leftViewController = [[LeftViewController alloc] init];
    
    //首页
    BaseAnimationController *centerView1Controller = [[BaseAnimationController alloc] init];
    
    //右侧菜单栏
    RightViewController *rightViewController = [[RightViewController alloc] init];
    
    SWRevealViewController *revealViewController = [[SWRevealViewController alloc] initWithRearViewController:leftViewController frontViewController:centerView1Controller];
    revealViewController.rightViewController = rightViewController;
    
    //浮动层离左边距的宽度
    revealViewController.rearViewRevealWidth = 230;
    //    revealViewController.rightViewRevealWidth = 230;
    
    NSLog(@"kkk");
    
    //是否让浮动层弹回原位
    //mainRevealController.bounceBackOnOverdraw = NO;
    [revealViewController setFrontViewPosition:FrontViewPositionLeft animated:YES];

    HomePageVC *vc1 = [[HomePageVC alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    
    PopViewController * vcPop = [[PopViewController alloc] init];
    UINavigationController *navPop = [[UINavigationController alloc] initWithRootViewController:vcPop];
    
    ShopListViewController *shopVC = [[ShopListViewController alloc] init];
    UINavigationController *shopNav = [[UINavigationController alloc] initWithRootViewController:shopVC];
    
    UserCenterVC *vc2 = [[UserCenterVC alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    
    self.viewControllers = @[revealViewController, nav1, navPop, shopNav, nav2];
    self.selectedIndex = 3;


}

- (void)clickBtn:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (button.tag == 2) {
        //点击的是中间按钮
        [self showMenu];
        
    }
    else {
        //1.先将之前选中的按钮设置为未选中
        self.selectedBtn.selected = NO;
        //2.再将当前按钮设置为选中
        button.selected = YES;
        //3.最后把当前按钮赋值为之前选中的按钮
        self.selectedBtn = button;
        //4.跳转到相应的视图控制器. (通过selectIndex参数来设置选中了那个控制器)
        self.selectedIndex = button.tag;
    }
}



- (void)configMenu  {
    _menu = [HyPopMenuView sharedPopMenuManager];
    
    PopMenuModel *model0 = [PopMenuModel allocPopMenuModelWithImageNameString:@"tabbar_compose_idea"
                                                                AtTitleString:@"文字/头条"
                                                                  AtTextColor:[UIColor grayColor]
                                                             AtTransitionType:PopMenuTransitionTypeSystemApi
                                                   AtTransitionRenderingColor:nil];
    PopMenuModel *model1 = [PopMenuModel allocPopMenuModelWithImageNameString:@"tabbar_compose_photo"
                                                                AtTitleString:@"相册/视频"
                                                                  AtTextColor:[UIColor grayColor]
                                                             AtTransitionType:PopMenuTransitionTypeSystemApi
                                                   AtTransitionRenderingColor:nil];
    
    
    PopMenuModel *model2 = [PopMenuModel allocPopMenuModelWithImageNameString:@"tabbar_compose_camera"
                                                                AtTitleString:@"拍摄/短视频"
                                                                  AtTextColor:[UIColor grayColor]
                                                             AtTransitionType:PopMenuTransitionTypeSystemApi
                                                   AtTransitionRenderingColor:nil];
    
    PopMenuModel *model3 = [PopMenuModel allocPopMenuModelWithImageNameString:@"tabbar_compose_lbs"
                                                                AtTitleString:@"签到"
                                                                  AtTextColor:[UIColor grayColor]
                                                             AtTransitionType:PopMenuTransitionTypeSystemApi
                                                   AtTransitionRenderingColor:nil];
    
    PopMenuModel *model4 = [PopMenuModel allocPopMenuModelWithImageNameString:@"tabbar_compose_review"
                                                                AtTitleString:@"点评"
                                                                  AtTextColor:[UIColor grayColor]
                                                             AtTransitionType:PopMenuTransitionTypeSystemApi
                                                   AtTransitionRenderingColor:nil];
    
    PopMenuModel *model5 = [PopMenuModel allocPopMenuModelWithImageNameString:@"tabbar_compose_more"
                                                                AtTitleString:@"更多"
                                                                  AtTextColor:[UIColor grayColor]
                                                             AtTransitionType:PopMenuTransitionTypeSystemApi
                                                   AtTransitionRenderingColor:nil];
    _menu.dataSource = @[model0, model1, model2, model3, model4, model5];
    _menu.delegate = self;
    _menu.popMenuSpeed = 12.0f;
    _menu.automaticIdentificationColor = false;
    
    _menu.animationType = HyPopMenuViewAnimationTypeSina;
    
    {
        /**
         *  仿新浪App弹出菜单。
         *  Sina App fake pop-up menu
         */
        //    _menu.animationType = HyPopMenuViewAnimationTypeSina;
        /**
         *  带有粘性的动画
         *  Animation with viscous
         */
        //    _menu.animationType = HyPopMenuViewAnimationTypeViscous;
        /**
         *  底部中心点弹出动画
         *  The bottom of the pop-up animation center
         */
        //    _menu.animationType = HyPopMenuViewAnimationTypeCenter;
        
        /**
         *  左和右弹出动画
         *  Left and right pop Anime
         */
        //    _menu.animationType = HyPopMenuViewAnimationTypeLeftAndRight;
        
        
        //头部是可以放置一个view的， 例如今天的天气预报
        //    popMenvTopView * topView = [popMenvTopView popMenvTopView];
        //    topView.frame = CGRectMake(0, 44, CGRectGetWidth(self.view.frame), 92);
        //    _menu.topView = topView;
        
    }
    
}


- (void)showMenu {
    [_menu openMenu];
}



- (void)popMenuView:(HyPopMenuView *)popMenuView didSelectItemAtIndex:(NSUInteger)index {
    
}


@end
