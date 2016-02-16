//
//  CSTextView.m
//  DemoUITextView
//
//  Created by zj－db0465 on 16/2/16.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "CSTextView.h"

@implementation CSTextView

- (instancetype)initWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder
{
    self = [super initWithFrame:frame];
    if (self) {
        self.placeHolder = placeHolder;
        [self addEditingOperations];
    }
    return self;
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    _placeHolder = placeHolder;
    
    self.text = _placeHolder;
    self.textColor = [UIColor grayColor];
}

- (void)addEditingOperations {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
}

- (void)didBeginEditing:(NSNotification *)sender {
    if ([self.text isEqualToString:_placeHolder]) {
        self.text = @"";
        self.textColor = [UIColor blackColor];
    }
}

- (void)didEndEditing:(NSNotification *)sender {
    if (self.text.length == 0) {
        self.text = _placeHolder;
        self.textColor = [UIColor grayColor];
    }
}

@end
