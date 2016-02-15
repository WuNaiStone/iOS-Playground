//
//  ViewController.m
//  DemoUIVisualEffect
//
//  Created by icetime17 on 16/2/15.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSInteger, EnumVisualEffect) {
    kVisualEffectBlur = 1001,
    kVisualEffectVibrancy,
};

@interface ViewController ()

@end

@implementation ViewController {

    UIImageView *_imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    _imageView.image = [UIImage imageNamed:@"wallpaper.jpg"];
    [self.view addSubview:_imageView];
    
    [self addBtn];
}

- (void)addBtn {
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 50)];
    [btn1 setTitle:@"BlurEffect" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn1 addTarget:self action:@selector(actionUIVisualEffect:) forControlEvents:UIControlEventTouchUpInside];
    btn1.layer.borderColor = [UIColor redColor].CGColor;
    btn1.layer.borderWidth = 2.0f;
    btn1.tag = kVisualEffectBlur;
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 60, self.view.frame.size.width, 50)];
    [btn2 setTitle:@"VibrancyEffect" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn2 addTarget:self action:@selector(actionUIVisualEffect:) forControlEvents:UIControlEventTouchUpInside];
    btn2.layer.borderColor = [UIColor redColor].CGColor;
    btn2.layer.borderWidth = 2.0f;
    btn2.tag = kVisualEffectVibrancy;
    [self.view addSubview:btn2];
}

- (void)actionUIVisualEffect:(UIButton *)sender {
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] init];
    blurView.frame = self.view.frame;
    [_imageView addSubview:blurView];
    
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    if (sender.tag == kVisualEffectBlur) {
        blurView.effect = blurEffect;
    } else {
        // UIVibrancyEffect用于放大或调整UIVisualEffectView下边的内容的颜色，
        // 同时让UIVisualEffectView的contentView的内容看起来更生动。
        // 通常与UIBlurEffect一起用，
        UIVisualEffectView *vibrancyView = [[UIVisualEffectView alloc] init];
        vibrancyView.frame = self.view.frame;
        [blurView.contentView addSubview:vibrancyView];
        
        UIVisualEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
        vibrancyView.effect = vibrancyEffect;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        label.center = vibrancyView.center;
        label.text = @"Vibrancy Effect";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        [vibrancyView.contentView addSubview:label];
    }
}

@end
