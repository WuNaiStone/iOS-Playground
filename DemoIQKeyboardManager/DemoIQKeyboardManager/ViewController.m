//
//  ViewController.m
//  DemoIQKeyboardManager
//
//  Created by Chris Hu on 16/10/27.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import <IQKeyboardManager/IQKeyboardReturnKeyHandler.h>

@interface ViewController ()

@end

@implementation ViewController
{

    IQKeyboardReturnKeyHandler *_keyboardReturnKeyHandler;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 自动跳至下一个输入框, 按照addSubview的顺序。
    _keyboardReturnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    _keyboardReturnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDone;
}


@end
