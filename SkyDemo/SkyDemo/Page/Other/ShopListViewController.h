//
//  ShopListViewController.h
//  SkyDemo
//
//  Created by 何亚慧 on 16/7/28.
//  Copyright © 2016年 Sky. All rights reserved.
//

#import "RootTableViewController.h"
@class rilegouleView;

@interface ShopListViewController : RootTableViewController


@property (nonatomic, strong) rilegouleView *rilegoule;

@property (nonatomic, strong) UIImageView *BlurredView;

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) NSIndexPath *currentIndexPath;



@end
