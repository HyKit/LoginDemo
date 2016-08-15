//
//  PictureLictVC.m
//  SkyDemo
//
//  Created by 何亚慧 on 16/7/22.
//  Copyright © 2016年 Sky. All rights reserved.
//

#import "PictureLictVC.h"


@interface PictureLictVC () <UIScrollViewDelegate>

@end

@implementation PictureLictVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title = @"物品列表";
    [self configUI];
    
}

- (void)configUI {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 64+10, ScreenWidth - 40, 100)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(ScreenWidth * 4, 100);
    
    scrollView.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:scrollView];
    
}

@end
