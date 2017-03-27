//
//  CustomButtonVC.m
//  SkyDemo
//
//  Created by 何亚慧 on 2017/3/23.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "CustomButtonVC.h"

@interface CustomButtonVC ()

@end

@implementation CustomButtonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"自定义按钮";
    [self configUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configUI {
    NSString *firstTitle = @"button第一个高亮方法,通过按钮的事件来设置背景色";
    NSString *secondTitle = @"button第二个高亮方法,通过把颜色转换为UIImage来作为按钮不同状态下的背景图片";
    
    CGFloat width = ScreenWidth - 50;
    CGFloat height = [firstTitle heightForFont:[UIFont systemFontOfSize:16.0f] width:width];
    
    UIButton *firstBtn = [UIButton buttonWithFrame:CGRectMake(10, 100, width, height + 20) title:firstTitle bgColor:kMainColor titleColor:[UIColor whiteColor] fontSize:16];
    
    [self.view addSubview:firstBtn];
    
    
    [firstBtn addTarget:self action:@selector(button1BackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    [firstBtn addTarget:self action:@selector(button1BackGroundNormal:) forControlEvents:UIControlEventTouchUpInside];
    [firstBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];

    
    UIButton *secondBtn = [UIButton buttonWithFrame:CGRectMake(10, firstBtn.bottom + 20, width, [secondTitle heightForFont:[UIFont systemFontOfSize:16.0f] width:width] + 20) title:secondTitle bgColor:kMainColor titleColor:[UIColor whiteColor] fontSize:16];
    
    [self.view addSubview:secondBtn];
    
    [secondBtn setBackgroundImage:[self imageWithColor:kMainColor] forState:UIControlStateNormal];
    [secondBtn setBackgroundImage:[self imageWithColor:kColorfb5100] forState:UIControlStateHighlighted];

}


//  button1普通状态下的背景色
- (void)button1BackGroundNormal:(UIButton *)sender {
    sender.backgroundColor = kMainColor;
}

//  button1高亮状态下的背景色
- (void)button1BackGroundHighlighted:(UIButton *)sender {
//    sender.backgroundColor = kColorfb5100;
    sender.backgroundColor = kColor12b7f5;

}
- (void)buttonClicked:(UIButton *)sender {
    [OMGToast showWithText:@"点击了第一个button"];
}



//  颜色转换为背景图片
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
