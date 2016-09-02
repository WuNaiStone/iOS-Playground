//
//  ViewController.m
//  CustomUISlider
//
//  Created by Chris Hu on 16/8/31.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import "CSSlider.h"

@interface ViewController () <
    CSSliderDelegate
>

@end

@implementation ViewController {

    UILabel *label;
    CSSlider *csSlider;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    csSlider = [[CSSlider alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    csSlider.center = self.view.center;
    csSlider.value = 0.5f;
    [self.view addSubview:csSlider];
    csSlider.delegate = self;
//    csSlider.thumbTintColor = [UIColor greenColor];
    
    csSlider.csThumbImage = [UIImage imageNamed:@"CSSliderHandler"];
    csSlider.csMinimumTrackTintColor = [UIColor redColor];
    csSlider.csMaximumTrackTintColor = [UIColor lightGrayColor];
    // Please use CSSliderTrackTintType_Divide after csMinimumTrackTintColor and csMaximumTrackTintColor set already. Please do not set minimumValueImage and maximumValueImage.
    csSlider.trackTintType = CSSliderTrackTintType_Linear;
    
    csSlider.sliderDirection = CSSliderDirection_Vertical;
    
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = [NSString stringWithFormat:@"%.1f", csSlider.value];
    [self.view addSubview:label];
}

#pragma mark - CSSliderDelegate

- (void)CSSliderValueChanged:(CSSlider *)sender {
    label.text = [NSString stringWithFormat:@"%.1f", sender.value];
}

- (void)CSSliderTouchDown:(CSSlider *)sender {

}

- (void)CSSliderTouchUp:(CSSlider *)sender {

}

- (void)CSSliderTouchCancel:(CSSlider *)sender {

}

@end
