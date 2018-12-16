//
//  ViewUserInfo.m
//  DemoMVVM
//
//  Created by Chris Hu on 2017/9/4.
//  Copyright © 2017年 com.icetime. All rights reserved.
//

#import "ViewUserInfo.h"

// context of KVO
static int ctxKVOName     = 0;
static int ctxKVOAge      = 1;
static int ctxKVOCity     = 2;

@interface ViewUserInfo()

@property (nonatomic, strong) UITextField *textFieldName;
@property (nonatomic, strong) UITextField *textFieldAge;
@property (nonatomic, strong) UITextField *textFieldCity;

@property (nonatomic, strong) ViewModelUserInfo *viewModelUserInfo;

@end

@implementation ViewUserInfo

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        
        self.textFieldName = [[UITextField alloc] initWithFrame:CGRectMake(20, 50, 300, 30)];
        self.textFieldName.text = @"name";
        [self addSubview:self.textFieldName];
        
        self.textFieldAge = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, 300, 30)];
        self.textFieldAge.text = @"age";
        [self addSubview:self.textFieldAge];
        
        self.textFieldCity = [[UITextField alloc] initWithFrame:CGRectMake(20, 150, 300, 30)];
        self.textFieldCity.text = @"city";
        [self addSubview:self.textFieldCity];
    }
    return self;
}

- (void)bindWithViewModel:(ViewModelUserInfo *)viewModelUserInfo {
    _viewModelUserInfo = viewModelUserInfo;
    
    // View -> Model
    /**
     Using UserEvent to bind
     */
    [self.textFieldName addTarget:self
                           action:@selector(actionViewTextFieldChanged:)
                 forControlEvents:UIControlEventEditingChanged];
    [self.textFieldAge addTarget:self
                          action:@selector(actionViewTextFieldChanged:)
                forControlEvents:UIControlEventEditingChanged];
    [self.textFieldCity addTarget:self
                           action:@selector(actionViewTextFieldChanged:)
                 forControlEvents:UIControlEventEditingChanged];
    
    
    // Model -> View
    /**
     Using KVO to bind
     */
    [_viewModelUserInfo addObserver:self
                         forKeyPath:@"name"
                            options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial
                            context:&ctxKVOName];
    [_viewModelUserInfo addObserver:self
                         forKeyPath:@"age"
                            options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial
                            context:&ctxKVOAge];
    [_viewModelUserInfo addObserver:self
                         forKeyPath:@"city"
                            options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial
                            context:&ctxKVOCity];
}

- (void)actionViewTextFieldChanged:(UITextView *)sender
{
    NSLog(@"View -> Model");
    
    if ([sender isEqual:self.textFieldName]) {
        self.viewModelUserInfo.name = sender.text;
    } else if ([sender isEqual:self.textFieldAge]) {
        self.viewModelUserInfo.age = [sender.text intValue];
    } else if ([sender isEqual:self.textFieldCity]) {
        self.viewModelUserInfo.city = sender.text;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == &ctxKVOName) {
        
        NSString *newName = change[NSKeyValueChangeNewKey];
        if (![newName isKindOfClass:[NSNull class]] && newName) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.textFieldName.text = newName;
            });
        }
        
    } else if (context == &ctxKVOAge) {
        
        NSNumber *newAge = change[NSKeyValueChangeNewKey];
        if (![newAge isKindOfClass:[NSNull class]] && newAge) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.textFieldAge.text = [NSString stringWithFormat:@"%@", newAge];
            });
        }
        
    } else if (context == &ctxKVOCity) {
        
        NSString *newCity = change[NSKeyValueChangeNewKey];
        if (![newCity isKindOfClass:[NSNull class]] && newCity) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.textFieldCity.text = newCity;
            });
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
