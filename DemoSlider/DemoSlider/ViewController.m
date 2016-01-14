//
//  ViewController.m
//  DemoSlider
//
//  Created by zj－db0465 on 16/1/14.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _sliderHorizontal.minimumValue = 0;
    _sliderHorizontal.maximumValue = 100;
    _sliderHorizontal.minimumValueImage = [UIImage imageNamed:@"iconMax"];
    _sliderHorizontal.maximumValueImage = [UIImage imageNamed:@"iconMin"];
    _sliderHorizontal.minimumTrackTintColor = [UIColor blueColor];
    _sliderHorizontal.maximumTrackTintColor = [UIColor grayColor];

//    [_sliderHorizontal setThumbImage:[UIImage imageNamed:@"iconMax"] forState:UIControlStateNormal];
//    [_sliderHorizontal setThumbImage:[UIImage imageNamed:@"iconMin"] forState:UIControlStateHighlighted];
    _sliderHorizontal.thumbTintColor = [UIColor blueColor];
    
    _sliderHorizontal.continuous = YES;
    _sliderHorizontal.value = 50.0;

    
    
    _labelHorizontal.text = [NSString stringWithFormat:@"%.1f", _sliderHorizontal.value];
    _labelVertical.text = [NSString stringWithFormat:@"%.1f", _sliderHorizontal.value];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)valueChangedHorizontalSlider:(UISlider *)sender {
    _labelHorizontal.text = [NSString stringWithFormat:@"%.1f", sender.value];
}



@end
