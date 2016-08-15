//
//  PopViewController.m
//  SkyDemo
//
//  Created by 何亚慧 on 16/7/27.
//  Copyright © 2016年 Sky. All rights reserved.
//

#import "PopViewController.h"
#import "HyPopMenuView.h"



@interface PopViewController () <HyPopMenuViewDelegate>
{
    HyPopMenuView *_menu;
    
}
@end

@implementation PopViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"";

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"bg"];
    imageView.contentMode = UIViewContentModeCenter;
    
    
    [self.view addSubview:imageView];
    
    
    [self configUI];
    self.navigationController.navigationBarHidden = YES;
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, ScreenHeight - 64 - 100, 100, 40)];
    [button setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

}

- (void)configUI {
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
    
    /**
     *  仿新浪App弹出菜单。
     *  Sina App fake pop-up menu
     */
    _menu.animationType = HyPopMenuViewAnimationTypeSina;
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


- (void)addButtonClicked:(UIButton *)sender {
    [self showMenu];
}

- (void)showMenu {
    [_menu openMenu];
}


- (void)popMenuView:(HyPopMenuView*)popMenuView didSelectItemAtIndex:(NSUInteger)index {
//    UIViewController* t =
//    [self.storyboard instantiateViewControllerWithIdentifier:@"two"];
//    [self.navigationController pushViewController:t animated:false];
}

@end
