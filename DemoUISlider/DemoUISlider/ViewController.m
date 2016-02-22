//
//  ViewController.m
//  DemoUISlider
//
//  Created by icetime17 on 16/2/22.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <

    UIGestureRecognizerDelegate
>

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation ViewController {

    UITapGestureRecognizer *_tapGesture;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _label.text = [NSString stringWithFormat:@"%f", _slider.value];
    
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTapGesture:)];
    _tapGesture.delegate = self;
    [_slider addGestureRecognizer:_tapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    if (_tapGesture) {
        [_slider removeGestureRecognizer:_tapGesture];
        _tapGesture = nil;
    }
}

#pragma mark - UIButton

- (IBAction)actionReset:(UIButton *)sender {
    _slider.value = (_slider.maximumValue - _slider.minimumValue) / 2;
    _label.text = [NSString stringWithFormat:@"%f", _slider.value];
    NSLog(@"%f", _slider.value);
}

#pragma mark - UISlider

- (IBAction)sliderValueChanged:(UISlider *)sender {
    _label.text = [NSString stringWithFormat:@"%f", sender.value];
    NSLog(@"%f", sender.value);
}

- (IBAction)sliderTouchDown:(UISlider *)sender {
    NSLog(@"sliderTouchDown");
    _tapGesture.enabled = NO;
}

- (IBAction)sliderTouchUp:(UISlider *)sender {
    if (sender) {
        NSLog(@"sliderTouchUp");
    } else {
        NSLog(@"sliderTouchUp from actionTap");
    }
    _tapGesture.enabled = YES;
}

#pragma mark - UIGesture

- (void)actionTapGesture:(UITapGestureRecognizer *)sender {
    CGPoint touchPoint = [sender locationInView:_slider];
    CGFloat value = (_slider.maximumValue - _slider.minimumValue) * (touchPoint.x / _slider.frame.size.width );
    [_slider setValue:value animated:YES];
    _label.text = [NSString stringWithFormat:@"%f", _slider.value];
    NSLog(@"%f", _slider.value);
    
    NSLog(@"actionTap");
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

@end
