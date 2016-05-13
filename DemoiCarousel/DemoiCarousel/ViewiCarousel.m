//
//  ViewiCarousel.m
//  DemoiCarousel
//
//  Created by Chris Hu on 16/5/12.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewiCarousel.h"
#import "iCarousel.h"

@interface ViewiCarousel () <
    iCarouselDataSource,
    iCarouselDelegate
>

@property (nonatomic, strong) iCarousel *iCarousel;

@property (nonatomic, strong) NSArray *items;

// 设置偏移量
@property (nonatomic, assign) CGFloat pageOffset;

@end

@implementation ViewiCarousel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 相关数据源要放在添加iCarousel之前。
        self.items = @[@"Model",
                       @"Model",
                       @"Model",
                       @"Model",
                       @"Model",
                       ];
    }
    return self;
}

- (void)prepareImageNames:(NSArray *)items andPageOffset:(CGFloat)pageOffset {
    self.items = items;
    self.pageOffset = pageOffset;
    [self addiCarousel];
}

- (void)addiCarousel {
    _iCarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    _iCarousel.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_iCarousel];
    
    _iCarousel.delegate = self;
    _iCarousel.dataSource = self;
    _iCarousel.bounces = NO;
    _iCarousel.pagingEnabled = YES;
    _iCarousel.type = iCarouselTypeCustom;
}

#pragma mark - iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return self.items.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    if (view == nil) {
        CGFloat viewWidth = CGRectGetWidth(_iCarousel.frame) - 2 * self.pageOffset;
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, CGRectGetHeight(_iCarousel.frame))];
    }
    
    NSString *imageName = [NSString stringWithFormat:@"%@.jpg", self.items[index]];
    ((UIImageView *)view).image = [UIImage imageNamed:imageName];
    
    return view;
}

#pragma mark - iCarouselDelegate

- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform {
    static CGFloat max_scale = 1.0f;
    static CGFloat min_scale = 0.6f;
    if (offset <= 1 && offset >= -1) {
        float tempScale = offset < 0 ? 1+offset : 1-offset;
        float slope = (max_scale - min_scale) / 1;
        
        CGFloat scale = min_scale + slope*tempScale;
        transform = CATransform3DScale(transform, scale, scale, 1);
    }else{
        transform = CATransform3DScale(transform, min_scale, min_scale, 1);
    }
    
    return CATransform3DTranslate(transform, offset * self.iCarousel.itemWidth * 1.4, 0.0, 0.0);
}

@end
