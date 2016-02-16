//
//  CSTextView.h
//  DemoUITextView
//
//  Created by zj－db0465 on 16/2/16.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSTextView : UITextView

@property (nonatomic) NSString *placeHolder;

- (instancetype)initWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder;

@end
