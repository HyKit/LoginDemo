//
//  HBannerView.h
//  SkyDemo
//
//  Created by 何亚慧 on 16/7/21.
//  Copyright © 2016年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HBannerView;
@class HBannerItem;



@protocol HBannerViewDelegate <NSObject>

@optional

//当前选择的item  或者  index
- (void)focusBannerView:(HBannerView *)banberView didSelectItem:(HBannerItem *)item;
- (void)focusBannerView:(HBannerView *)banberView didSelectIndex:(NSInteger)index;


@end



@interface HBannerView : UIView

@property (nonatomic, assign) id<HBannerViewDelegate> delegate;


- (instancetype)initWithFrame:(CGRect)frame delegate:(id<HBannerViewDelegate>)delegate imageItems:(NSArray *)imageItems;


@end
