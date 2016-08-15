//
//  RootWebViewController.m
//  SkyDemo
//
//  Created by 何亚慧 on 16/7/22.
//  Copyright © 2016年 Sky. All rights reserved.
//

#import "RootWebViewController.h"




@interface RootWebViewController ()

@property (nonatomic, strong) UIWebView *webView;


@end
@implementation RootWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title = self.title;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self configUI];
    
}

- (void)configUI {
    
    self.webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    
    [_webView loadRequest:request];
    self.view = _webView;
    
    
}


@end
