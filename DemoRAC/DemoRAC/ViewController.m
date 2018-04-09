//
//  ViewController.m
//  DemoRAC
//
//  Created by Chris Hu on 06/04/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

/**
 RAC特性: 逻辑清晰, 流畅
 RACSignal可以添加subscriber, 消息同样有(next, error, completed).
 completed/error只能一次且不能同时存在.
 Signal可以进行merge, combine等操作.
 combineLatest要等到所有的Signal都有了新值之后才会发送.
 UITextField直接使用rac_textSignal进行subscribe即可.
 UIButton使用rac_command进行事件监听.
 
 RACDisposable用于释放资源.
 */

@interface ViewController () <
    UITextFieldDelegate
>

@property (nonatomic, strong) UIButton *btnCapture;


@property (weak, nonatomic) IBOutlet UITextField *textFieldUserName;
@property (weak, nonatomic) IBOutlet UITextField *textFiledPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;


@property (weak, nonatomic) IBOutlet UISlider *sliderRed;
@property (weak, nonatomic) IBOutlet UISlider *sliderGreen;
@property (weak, nonatomic) IBOutlet UISlider *sliderBlue;
@property (weak, nonatomic) IBOutlet UISlider *sliderAlpha;

@property (weak, nonatomic) IBOutlet UITextField *textFieldRed;
@property (weak, nonatomic) IBOutlet UITextField *textFieldGreen;
@property (weak, nonatomic) IBOutlet UITextField *textFieldBlue;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAlpha;

@property (weak, nonatomic) IBOutlet UIView *viewColorBlock;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.btnCapture];
    
    self.textFieldUserName.delegate = self;
    self.textFiledPassword.delegate = self;
    self.btnLogin.enabled = NO;
    
    [self setupLoginRAC];
}

- (UIButton *)btnCapture {
    if (!_btnCapture) {
        _btnCapture = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 80) / 2, self.view.frame.size.height - 100, 80, 80)];
        [_btnCapture setImage:[UIImage imageNamed:@"btn.camera.capture"] forState:UIControlStateNormal];
        
        // 1, button
        [_btnCapture setRac_command:[[RACCommand alloc] initWithEnabled:nil signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                NSLog(@"capture");
                
                // 1
                // 订阅button事件, enable属性默认在next/completed事件之后才有继续有效
                [subscriber sendNext:[NSDate date].description];
                // next如果不加的话, 即不发送next事件即可
                // 但completed如果不加的话, 则button点击一次之后即为disabled状态
                // 通过这个特性可以很方便地防止重复点击
                [subscriber sendCompleted];
                
                // 2
                // 点击button之后, 3s后才能继续点击
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [subscriber sendNext:[NSDate date].description];
//                    [subscriber sendCompleted];
//                });
                
                return [RACDisposable disposableWithBlock:^{
                    
                }];
            }];
        }]];
        
        // 那么, 如何订阅button事件发的消息呢(如next)
        [[[_btnCapture rac_command] executionSignals] subscribeNext:^(RACSignal<id> * _Nullable x) {
            NSLog(@"button next %@", x);
            [x subscribeNext:^(id  _Nullable x) {
                NSLog(@"%@", x);
            }];
        } error:^(NSError * _Nullable error) {
            NSLog(@"button error");
        } completed:^{
            NSLog(@"button completed");
        }];
    }
    return _btnCapture;
}

/*
// MARK: - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *str = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSString *username = self.textFieldUserName.text;
    NSString *password = self.textFiledPassword.text;
    
    if (textField == self.textFieldUserName) {
        username = str;
    } else if (textField == self.textFiledPassword) {
        password = str;
    }
    
    if (username.length > 0 && password.length >= 6) {
        self.btnLogin.enabled = YES;
    } else {
        self.btnLogin.enabled = NO;
    }
    
    return YES;
}
*/

- (void)setupLoginRAC {
    // 2, Login
    [self.textFieldUserName.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"username: %@", x);
    }];
    [self.textFiledPassword.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"password: %@", x);
    }];
    
    
//    RACSignal *signalBtnLoginEnable = [self.textFieldUserName.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
//        return @(value.length > 0);
//    }];
    RACSignal *signalBtnLoginEnable = [[RACSignal combineLatest:@[self.textFieldUserName.rac_textSignal, self.textFiledPassword.rac_textSignal]] map:^id _Nullable(RACTuple * _Nullable value) {
        return @([value[0] length] > 0 && [value[1] length] >= 6);
    }];
    self.btnLogin.rac_command = [[RACCommand alloc] initWithEnabled:signalBtnLoginEnable signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal empty];
    }];
    
    
    // 3, Color block
    RACSignal *signalRed = [self bind:_sliderRed withTextField:_textFieldRed];
    RACSignal *signalGreen = [self bind:_sliderGreen withTextField:_textFieldGreen];
    RACSignal *signalBlue = [self bind:_sliderBlue withTextField:_textFieldBlue];
    RACSignal *signalAlpha = [self bind:_sliderAlpha withTextField:_textFieldAlpha];
    
    // 必须三个信号量都有新值的时候才会触发.
    [[[RACSignal combineLatest:@[signalRed, signalGreen, signalBlue, signalAlpha]] map:^id _Nullable(RACTuple * _Nullable value) {
        CGFloat red = [value[0] floatValue];
        CGFloat green = [value[1] floatValue];
        CGFloat blue = [value[2] floatValue];
        CGFloat alpha = [value[3] floatValue];
        return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    }] subscribeNext:^(RACTuple * _Nullable x) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.viewColorBlock.backgroundColor = (UIColor *)x;
        });
    }];
    
    /*
    RACSignal *signalColor = [[RACSignal combineLatest:@[signalRed, signalGreen, signalBlue, signalAlpha]] map:^id _Nullable(RACTuple * _Nullable value) {
        CGFloat red = [value[0] floatValue];
        CGFloat green = [value[1] floatValue];
        CGFloat blue = [value[2] floatValue];
        CGFloat alpha = [value[3] floatValue];
        return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    }];
    // 或者, 直接使用RAC的宏来将信号量作用于对象的属性
    RAC(self.viewColorBlock, backgroundColor) = signalColor;
     */
}

- (RACSignal *)bind:(UISlider *)slider withTextField:(UITextField *)textField {
    RACSignal *textSignal = [[textField rac_textSignal] take:1];
    
    // slider的新值
    RACChannelTerminal *signalSlider = [slider rac_newValueChannelWithNilValue:nil];
    RACChannelTerminal *signalTextField = [textField rac_newTextChannel];
    [signalTextField subscribe:signalSlider];
    [[signalSlider map:^id _Nullable(id  _Nullable value) {
        return [NSString stringWithFormat:@"%.1f", [value floatValue]];
    }] subscribe:signalTextField];
    
    // merge不管先后顺序
    return [[signalSlider merge:signalTextField] merge:textSignal];
}

@end
