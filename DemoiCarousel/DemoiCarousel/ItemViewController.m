//
//  ItemViewController.m
//  DemoiCarousel
//
//  Created by Chris Hu on 16/5/14.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ItemViewController.h"
#import "ViewiCarousel.h"
#import "iCarousel.h"

@interface ItemViewController ()

@end

@implementation ItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = [NSString stringWithFormat:@"%ld", (long)_iCarouselType];
    
    ViewiCarousel *viewiCarousel = [[ViewiCarousel alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), 300) withCarouselType:_iCarouselType];
    viewiCarousel.center = self.view.center;
    [self.view addSubview:viewiCarousel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
