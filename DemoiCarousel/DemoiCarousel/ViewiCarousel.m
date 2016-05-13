//
//  ViewiCarousel.m
//  DemoiCarousel
//
//  Created by Chris Hu on 16/5/12.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewiCarousel.h"
#import "iCarousel.h"
#import "CarouselCell.h"

@interface ViewiCarousel () <
    iCarouselDataSource,
    iCarouselDelegate
>

@property (nonatomic, strong) iCarousel *iCarousel;

@end

@implementation ViewiCarousel

- (instancetype)initWithFrame:(CGRect)frame withCarouselType:(NSInteger)type
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addiCarouselWithType:type];
    }
    return self;
}

- (void)addiCarouselWithType:(NSInteger)type {
    _iCarousel = [[iCarousel alloc] initWithFrame:self.frame];
    [self addSubview:_iCarousel];
    
    _iCarousel.delegate = self;
    _iCarousel.dataSource = self;
    _iCarousel.bounces = NO;
    _iCarousel.pagingEnabled = YES;
    _iCarousel.type = type;
}

#pragma mark - iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return 10;
}

#define PAGE_OFFSET 30
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    if (view == nil) {
        CGFloat widthView   = ScreenWidth - 2 * PAGE_OFFSET;
        CGFloat heightView  = CGRectGetHeight(_iCarousel.frame) - PAGE_OFFSET;
        CGRect frame = CGRectMake(0, 0, widthView, heightView);
        view = (CarouselCell *)[[CarouselCell alloc] initWithFrame:frame withIndex:index];
    }
    
    return view;
}

#pragma mark - iCarouselDelegate

- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform {
    static CGFloat max_scale = 1.0f;
    static CGFloat min_scale = 0.9f;
    if (offset <= 1 && offset >= -1) {
        float tempScale = offset < 0 ? 1+offset : 1-offset;
        float slope = (max_scale - min_scale) / 1;
        
        CGFloat scale = min_scale + slope*tempScale;
        transform = CATransform3DScale(transform, scale, scale, 1);
    }else{
        transform = CATransform3DScale(transform, min_scale, min_scale, 1);
    }
    
    return CATransform3DTranslate(transform, offset * self.iCarousel.itemWidth * 1.125, 0.0, 0.0);
}

@end
