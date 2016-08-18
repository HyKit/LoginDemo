//
//  MovieListCell.h
//  SkyDemo
//
//  Created by 何亚慧 on 16/8/17.
//  Copyright © 2016年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MovieModel;


@interface MovieListCell : UITableViewCell

@property (nonatomic, strong) UIImageView *picture;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *littleLabel;

@property (nonatomic, strong) UIView *coverview;

@property (nonatomic, strong) MovieModel *model;



- (CGFloat)cellOffset;



@end
