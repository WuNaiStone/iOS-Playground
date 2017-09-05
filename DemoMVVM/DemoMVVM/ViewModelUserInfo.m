//
//  ViewModelUserInfo.m
//  DemoMVVM
//
//  Created by Chris Hu on 2017/9/4.
//  Copyright © 2017年 com.icetime. All rights reserved.
//

#import "ViewModelUserInfo.h"


// context of KVO
static NSInteger ctxKVOName     = 0;
static NSInteger ctxKVOAge      = 1;
static NSInteger ctxKVOCity     = 2;


@implementation ViewModelUserInfo

/**
 Using KVO to bind
 */
- (void)bind
{
    // Model update View
    [_modelUserInfo addObserver:self
                     forKeyPath:@"name"
                        options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial
                        context:&ctxKVOName];
    [_modelUserInfo addObserver:self
                     forKeyPath:@"age"
                        options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial
                        context:&ctxKVOAge];
    [_modelUserInfo addObserver:self
                     forKeyPath:@"city"
                        options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial
                        context:&ctxKVOCity];
    
    
    // View update Model
    [_viewUserInfo.textFieldName addTarget:self
                                    action:@selector(actionViewTextFieldChanged:)
                          forControlEvents:UIControlEventEditingChanged];
    [_viewUserInfo.textFieldAge addTarget:self
                                   action:@selector(actionViewTextFieldChanged:)
                         forControlEvents:UIControlEventEditingChanged];
    [_viewUserInfo.textFieldCity addTarget:self
                                    action:@selector(actionViewTextFieldChanged:)
                          forControlEvents:UIControlEventEditingChanged];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == &ctxKVOName) {
        
        NSString *newName = change[NSKeyValueChangeNewKey];
        if (![newName isKindOfClass:[NSNull class]] && newName) {
            _viewUserInfo.textFieldName.text = newName;
        }
        
    } else if (context == &ctxKVOAge) {
        
        NSNumber *newAge = change[NSKeyValueChangeNewKey];
        if (![newAge isKindOfClass:[NSNull class]] && newAge) {
            _viewUserInfo.textFieldAge.text = [NSString stringWithFormat:@"%@", newAge];
        }
        
    } else if (context == &ctxKVOCity) {
        
        NSString *newCity = change[NSKeyValueChangeNewKey];
        if (![newCity isKindOfClass:[NSNull class]] && newCity) {
            _viewUserInfo.textFieldCity.text = newCity;
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)actionViewTextFieldChanged:(UITextView *)sender
{
    if ([sender isEqual:_viewUserInfo.textFieldName]) {
        _modelUserInfo.name = sender.text;
    } else if ([sender isEqual:_viewUserInfo.textFieldAge]) {
        _modelUserInfo.age = [sender.text integerValue];
    } else if ([sender isEqual:_viewUserInfo.textFieldCity]) {
        _modelUserInfo.city = sender.text;
    }
}

@end
