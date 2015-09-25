//
//  ViewController.m
//  DemoSoundRecordPlay
//
//  Created by zj－db0465 on 15/9/23.
//  Copyright © 2015年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController {
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn0 = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
    btn0.layer.borderColor = [[UIColor grayColor] CGColor];
    btn0.layer.borderWidth = 2.0f;
    [btn0 setTitle:@"action audio player" forState:UIControlStateNormal];
    [btn0 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn0 setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [btn0 addTarget:self action:@selector(actionAudioPlayer) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn0];

    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 50)];
    btn1.layer.borderColor = [[UIColor grayColor] CGColor];
    btn1.layer.borderWidth = 2.0f;
    [btn1 setTitle:@"press and record" forState:UIControlStateNormal];
    [btn1 setTitle:@"release and save" forState:UIControlStateHighlighted];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [btn1 addTarget:self action:@selector(pressAndRecord:) forControlEvents:UIControlEventTouchDown];
    [btn1 addTarget:self action:@selector(releaseAndSave:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 50)];
    btn2.layer.borderColor = [[UIColor grayColor] CGColor];
    btn2.layer.borderWidth = 2.0f;
    [btn2 setTitle:@"click and play" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [btn2 addTarget:self action:@selector(clickAndPlay:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 400, self.view.frame.size.width, 50)];
    btn3.layer.borderColor = [[UIColor grayColor] CGColor];
    btn3.layer.borderWidth = 2.0f;
    [btn3 setTitle:@"request microphone" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [btn3 addTarget:self action:@selector(requestMicrophone) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [[UIButton alloc] initWithFrame:CGRectMake(0, 500, self.view.frame.size.width, 50)];
    btn4.layer.borderColor = [[UIColor grayColor] CGColor];
    btn4.layer.borderWidth = 2.0f;
    [btn4 setTitle:@"remove microphone" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [btn4 addTarget:self action:@selector(removeMicrophone) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)actionAudioPlayer {
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"magic_animation" ofType:@"m4a"]];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    player.meteringEnabled = YES;
    player.volume = 0.1f;
    [player prepareToPlay];
    [player play];
}

- (void)requestMicrophone {
}

- (void)removeMicrophone {
}

- (IBAction)pressAndRecord:(UIButton *)sender {
}

- (IBAction)releaseAndSave:(UIButton *)sender {
}

- (IBAction)clickAndPlay:(UIButton *)sender {
}

@end
