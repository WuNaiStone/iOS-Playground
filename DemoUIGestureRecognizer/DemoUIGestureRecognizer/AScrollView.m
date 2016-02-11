//
//  AScrollView.m
//  DemoUIGestureRecognizer
//
//  Created by zj－db0465 on 16/1/7.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "AScrollView.h"

@implementation AScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        [self addGestures];
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

#pragma mark - gestures

- (void)addGestures {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionGesture:)];
    [self addGestureRecognizer:tapGesture];
    
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(actionGesture:)];
    longGesture.minimumPressDuration = 2.0f;
    [self addGestureRecognizer:longGesture];
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(actionGesture:)];
    swipeGesture.numberOfTouchesRequired = 1;
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipeGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(actionGesture:)];
    [self addGestureRecognizer:panGesture];
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(actionGesture:)];
    [self addGestureRecognizer:pinchGesture];
    
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(actionGesture:)];
    [self addGestureRecognizer:rotationGesture];
    
    UIScreenEdgePanGestureRecognizer *screenEdgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(actionGesture:)];
    screenEdgePanGesture.edges = UIRectEdgeAll;
    [self addGestureRecognizer:screenEdgePanGesture];
}

- (void)actionGesture:(UIGestureRecognizer *)sender {
    NSLog(@"actionGesture : %@", sender);
    NSLog(@"numberOfTouches : %ld\n", (long)sender.numberOfTouches);
    if ([sender isKindOfClass:[UISwipeGestureRecognizer class]]) {
        NSLog(@"Swipe : %@", sender);
    }
}

#pragma mark - touch events

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = (UITouch *)[touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    NSLog(@"AScrollView touchesBegan : %@", NSStringFromCGPoint(touchPoint));
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = (UITouch *)[touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    NSLog(@"AScrollView touchesMoved : %@", NSStringFromCGPoint(touchPoint));
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = (UITouch *)[touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    NSLog(@"AScrollView touchesEnded : %@", NSStringFromCGPoint(touchPoint));
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = (UITouch *)[touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    NSLog(@"AScrollView touchesCancelled : %@", NSStringFromCGPoint(touchPoint));
}

@end
