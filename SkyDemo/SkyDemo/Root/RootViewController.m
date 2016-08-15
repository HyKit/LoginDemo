//
//  RootViewController.m
//  HYQDemo
//
//  Created by HYH on 16/6/30.
//  Copyright © 2016年 h. All rights reserved.
//

#import "RootViewController.h"

//#import "LoginViewController.h"
//#import "RegisterViewController.h"
#import "UserCenterVC.h"


@interface RootViewController () <UIGestureRecognizerDelegate>
{
    UINavigationController *_nav;
}

@end

@implementation RootViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization.
//        if ([self isKindOfClass:[ViewController class]] || [self isKindOfClass:[UserCenterVC class]]) {
//            self.hidesBottomBarWhenPushed = NO;
//        }
//        else {
//            [self configNav];
//            self.hidesBottomBarWhenPushed = YES;
//        }
//    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
    
}
- (void)tap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- config ui
- (void)configNav {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 15, 41*15/25);
    [backButton setBackgroundImage:[UIImage imageNamed:@"fanhui_baise"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backViewController) forControlEvents:UIControlEventTouchUpInside];
    _backButton = backButton;
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = left;
}

#pragma mark -- reWrite back function
- (void)backViewController {

    [self back];
    
}

- (void)presentNac:(UIViewController *)vc {
    _nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:_nav animated:YES completion:nil];
    
    
    
}
#pragma mark -- to next vc
- (void)toContentVCWithName:(NSString *)vcName {
    Class vcClass = NSClassFromString(vcName);
    id vc = [[vcClass alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark --  back  function
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)dismissNav {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
