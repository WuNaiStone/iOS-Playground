//
//  ViewController.m
//  DemoiCarousel
//
//  Created by Chris Hu on 16/5/12.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import "iCarousel.h"

#import "ViewiCarousel.h"

@interface ViewController () <
    iCarouselDataSource,
    iCarouselDelegate
>

@property (nonatomic,strong) iCarousel *iCarousel;

@property (nonatomic,strong) NSArray *items;

@end

#define PAGE_OFFSET 50
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    ViewiCarousel *viewiCarousel = [[ViewiCarousel alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), 100)];
    NSArray *imageNames = @[@"Model",
                       @"Model",
                       @"Model",
                       @"Model",
                       @"Model",
                       ];
    [viewiCarousel prepareImageNames:imageNames andPageOffset:30];
    [self.view addSubview:viewiCarousel];
    
    
    // 相关数据源要放在添加iCarousel之前。
    self.items = @[@"Model",
                   @"Model",
                   @"Model",
                   @"Model",
                   @"Model",
                   ];
    
    [self addiCarousel];
}

- (void)addiCarousel {
    CGFloat height = ScreenWidth - 2 * PAGE_OFFSET;
    _iCarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, (ScreenHeight - height) * 0.5, ScreenWidth, height)];
    _iCarousel.backgroundColor = [UIColor lightGrayColor];
    _iCarousel.center = self.view.center;
    [self.view addSubview:_iCarousel];
    
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
        CGFloat viewWidth = ScreenWidth - 2 * PAGE_OFFSET;
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewWidth)];
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
