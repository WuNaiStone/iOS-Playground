//
//  ViewController.m
//  DemoUITextView
//
//  Created by icetime17 on 16/2/16.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"

#define PlaceHolder @"This is placeholder"

@interface ViewController () <
    UITextViewDelegate
>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 100)];
    textView.backgroundColor = [UIColor whiteColor];
    textView.font = [UIFont systemFontOfSize:20.f];
    textView.text = PlaceHolder;
    textView.textColor = [UIColor grayColor];
    textView.delegate = self;
    [self.view addSubview:textView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
}

- (void)actionTap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:PlaceHolder]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length == 0) {
        textView.text = PlaceHolder;
        textView.textColor = [UIColor grayColor];
    }
}

@end
