//
//  HBannerView.m
//  SkyDemo
//
//  Created by 何亚慧 on 16/7/21.
//  Copyright © 2016年 Sky. All rights reserved.
//

#import "HBannerView.h"
#import "HBannerItem.h"



#import "UIImageView+WebCache.h"



#import <objc/runtime.h>




@interface HBannerView () <UIScrollViewDelegate, UIGestureRecognizerDelegate>


{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    BOOL _isAutoPlay;
    
}



@end

static NSString *BANNER_FOCUS_ITEM_ASS_KEY = @"itemAssKey";
static CGFloat SWITH_PICTURE_INTERVAL = 5.0; //时间间隔



@implementation HBannerView

@synthesize delegate = _delegate;



- (instancetype)initWithFrame:(CGRect)frame delegate:(id<HBannerViewDelegate>)delegate imageItems:(NSArray *)imageItems {
    self = [super initWithFrame:frame];
    if (self) {
        
        NSMutableArray *imageArr = [NSMutableArray arrayWithArray:imageItems];
        objc_setAssociatedObject(self, (__bridge const void *)BANNER_FOCUS_ITEM_ASS_KEY, imageArr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        _isAutoPlay = YES;
        [self setDelegate:delegate];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    
    
    NSArray *imageItems = objc_getAssociatedObject(self, (__bridge const void *)(BANNER_FOCUS_ITEM_ASS_KEY));
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.scrollsToTop = NO;
    float space = 0;
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 0);
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 16 - 10, ScreenWidth, 10)];
    _pageControl.userInteractionEnabled = NO;
    
    [self addSubview:_scrollView];
    [self addSubview:_pageControl];

    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    
    _pageControl.numberOfPages = imageItems.count > 1 ? imageItems.count - 2 : imageItems.count;
    _scrollView.delegate = self;
    
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureRecognizer:)];
    tapGestureRecognize.delegate = self;
    tapGestureRecognize.numberOfTapsRequired = 1;
    [_scrollView addGestureRecognizer:tapGestureRecognize];
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * imageItems.count, _scrollView.frame.size.height);
    
    for (int i = 0; i < imageItems.count; i++) {
        HBannerItem *item = [imageItems objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * _scrollView.frame.size.width + space, space, _scrollView.frame.size.width - space * 2, _scrollView.frame.size.height - 2 * space - size.height)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:item.image]];
        [_scrollView addSubview:imageView];
    }
    
    
    
    if (imageItems.count > 1) {
        [_scrollView setContentOffset:CGPointMake(ScreenWidth, 0) animated:NO];
        if (_isAutoPlay) {
            [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:SWITH_PICTURE_INTERVAL];
        }
    }
}




- (void)singleTapGestureRecognizer:(UITapGestureRecognizer *)sender {
    
    NSArray *imageItems = objc_getAssociatedObject(self, (__bridge const void *)BANNER_FOCUS_ITEM_ASS_KEY);
    
    int page = (int)_scrollView.contentOffset.x / _scrollView.frame.size.width;
    if (page > -1 && page < imageItems.count) {
        HBannerItem *item = [imageItems objectAtIndex:page];
        if ([self.delegate respondsToSelector:@selector(focusBannerView:didSelectItem:)]) {
            [self.delegate focusBannerView:self didSelectItem:item];
        }
    }

}

- (void)switchFocusImageItems {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(switchFocusImageItems) object:nil];
    
    
    CGFloat targetX = _scrollView.contentOffset.x + _scrollView.frame.size.width;
    NSArray *imageView = objc_getAssociatedObject(self, (__bridge const void *)BANNER_FOCUS_ITEM_ASS_KEY);
    targetX = (int)(targetX / ScreenWidth) * ScreenWidth;
    
    [self moveToTargetPosition:targetX];
    
    if (imageView.count > 1 && _isAutoPlay) {
        [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:SWITH_PICTURE_INTERVAL];
        
    }
}


- (void)moveToTargetPosition:(CGFloat)targetX {
    BOOL animated = YES;
    [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:animated];
}

#pragma mark -- UIScrollViewDeledate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float targetX = scrollView.contentOffset.x;
    NSArray *imageItems = objc_getAssociatedObject(self, (__bridge const void *)(BANNER_FOCUS_ITEM_ASS_KEY));
    if (imageItems.count >= 3) {
        if (targetX >= ScreenWidth * (imageItems.count - 1)) {
            //正在最后一个页面
            targetX = ScreenWidth;
            [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:NO];
        }
        else if (targetX <= 0) {
            //第一个
            targetX = ScreenWidth * (imageItems.count - 2);
            [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:NO];
        }
    }
    NSInteger page = (_scrollView.contentOffset.x + ScreenWidth / 2.0) / ScreenWidth;
    
    if (imageItems.count > 1) {
        page --;
        if (page >= _pageControl.numberOfPages) {
            page = 0;
        }
        else if (page < 0) {
            page = _pageControl.numberOfPages - 1;
        }
    }
    if (page != _pageControl.numberOfPages) {
        if ([self.delegate respondsToSelector:@selector(focusBannerView:didSelectIndex:)]) {
            [self.delegate focusBannerView:self didSelectIndex:page];
        }
    }
    _pageControl.currentPage = page;
    
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        CGFloat targetX = _scrollView.contentOffset.x + _scrollView.frame.size.width;
        targetX = (int)(targetX /ScreenWidth) * ScreenWidth;
        [self moveToTargetPosition:targetX];
    }
}


- (void)scrollToIndex:(NSInteger)aIndex {
    NSArray *imageItems = objc_getAssociatedObject(self, (__bridge const void *)BANNER_FOCUS_ITEM_ASS_KEY);
    if (imageItems.count > 1) {
        if (aIndex >= imageItems.count - 2) {
            aIndex = imageItems.count - 3;
        }
        [self moveToTargetPosition:ScreenWidth * (aIndex + 1)];
    }
    else {
        [self moveToTargetPosition:0];
    }
    [self scrollViewDidScroll:_scrollView];
}




@end
