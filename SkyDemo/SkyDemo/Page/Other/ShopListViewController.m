//
//  ShopListViewController.m
//  SkyDemo
//
//  Created by 何亚慧 on 16/7/28.
//  Copyright © 2016年 Sky. All rights reserved.
//

#import "ShopListViewController.h"
#import "ShopListCell.h"
#import <SVProgressHUD.h>
#import <UIView+Toast.h>

#import "OMGToast.h"



#import <LocalAuthentication/LocalAuthentication.h>



@implementation ShopListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"列表";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self configUI];
    [self initTouchIDBtn];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)configUI {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.row) {
        ShopListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopListCell"];
        if (!cell) {
            cell = [[ShopListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ShopListCell"];
            cell.titleLabel.text = @"111";
            cell.descLable.text = @"description";
        }
        return cell;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
            cell.textLabel.text = @"111";
        }
        return cell;
    
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //开始指纹验证
    [self beginTouchIdCheck];
    
}

- (void)beginTouchIdCheck {
    
    
}
-(void)initTouchIDBtn{
    UIButton *touchIDBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    touchIDBtn.frame = CGRectMake(50, 300, 60, 40);
    [touchIDBtn setTitle:@"指纹" forState:UIControlStateNormal];
    [touchIDBtn setBackgroundColor:[UIColor cyanColor]];
    [touchIDBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [touchIDBtn addTarget:self action:@selector(OnTouchIDBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:touchIDBtn];
}

-(void)OnTouchIDBtn:(UIButton *)sender{
    // iOS 8及以上版本执行-(void)authenticateUser方法，方法自动判断设备是否支持和开启Touch ID
    if ([[UIDevice currentDevice].systemVersion doubleValue] > 8.0) {
//        NSLog(@"你的系统满足条件");
        
        // 判断是否开启指纹验证功能
        LAContext *context = [[LAContext alloc] init];
        // Evaluate: 评估,评价
        // policy: 政策,方法
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil]) {
            
            NSLog(@"你的设备开启了指纹验证功能");
            
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"利用他解锁(支付)" reply:^(BOOL success, NSError * _Nullable error) {
                
                if (success) {
                    [OMGToast showWithText:@"验证成功"];
                    NSLog(@"验证成功");
                    //验证成功，主线程处理UI
                }
                else {
                    if (error.code == -2) {
                        [OMGToast showWithText:[NSString stringWithFormat:@"用户取消了操作:%@",error]];
                        NSLog(@"用户取消了操作:%@",error);
                    }
                    if (error.code != -2) {
                        [OMGToast showWithText:[NSString stringWithFormat:@"验证失败:%@",error]];
                        NSLog(@"验证失败:%@",error);
                    }
                }
            }];
            
        } else {
            [OMGToast showWithText:@"你的设备没有开启"];
        }
        
    } else {
        [OMGToast showWithText:@"你的系统不满足条件"];
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    // iOS 8及以上版本执行-(void)authenticateUser方法，方法自动判断设备是否支持和开启Touch ID
    if ([[UIDevice currentDevice].systemVersion doubleValue] > 8.0) {
        NSLog(@"你的系统满足条件");
        
        // 判断是否开启指纹验证功能
        LAContext *context = [[LAContext alloc] init];
        // Evaluate: 评估,评价
        // policy: 政策,方法
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil]) {
            NSLog(@"你的设备开启了指纹验证功能");
            
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"利用他解锁(支付)" reply:^(BOOL success, NSError * _Nullable error) {
                
                if (success) {
                    NSLog(@"验证成功");
                    //验证成功，主线程处理UI
                }
                if (error.code == -2) {
                    NSLog(@"用户取消了操作:%@",error);
                }
                
                if (error.code != -2) {
                    NSLog(@"验证失败:%@",error);
                }
                
            }];
            
        } else {
            NSLog(@"你的设备没有开启");
        }
        
    } else {
        NSLog(@"你的系统不满足条件");
    }
}



@end
