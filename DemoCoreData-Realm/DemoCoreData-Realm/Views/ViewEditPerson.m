//
//  ViewEditPerson.m
//  DemoCoreData-Realm
//
//  Created by Chris Hu on 16/6/17.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

#import "ViewEditPerson.h"

@implementation ViewEditPerson

- (void)awakeFromNib {
    NSLog(@"%s", __func__);
}

- (IBAction)actionCancel:(UIButton *)sender {
    self.hidden = YES;
}

- (IBAction)actionDone:(UIButton *)sender {
    self.hidden = YES;
    
    RLMRealm *realm         = [RLMRealm defaultRealm];
    if (_personRealm) {
        [realm transactionWithBlock:^{
            [self updatePersonRealm];
        }];
    } else {
        _personRealm = [[PersonRealm alloc] init];
        [realm transactionWithBlock:^{
            [self updatePersonRealm];
            [realm addObject:_personRealm];
        }];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(ViewEditPersonActionDone)]) {
        [_delegate ViewEditPersonActionDone];
    }
}

- (IBAction)actionDelete:(UIButton *)sender {
    self.hidden = YES;
    
    RLMRealm *realm         = [RLMRealm defaultRealm];
    if (_personRealm) {
        [realm transactionWithBlock:^{
            [realm deleteObject:_personRealm];
        }];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(ViewEditPersonActionDone)]) {
        [_delegate ViewEditPersonActionDone];
    }
}

- (void)updatePersonRealm {
    _personRealm.name       = _textFieldName.text;
    _personRealm.age        = _textFieldAge.text.integerValue;
    _personRealm.city       = _textFieldCity.text;
    _personRealm.job        = _textFieldJob.text;
    _personRealm.email      = _textFieldEmail.text;
    _personRealm.wechatId   = _textFieldWechatId.text;
    _personRealm.avatar     = _textFieldAvatar.text;
    _personRealm.height     = _textFieldHeight.text.floatValue;
    _personRealm.weight     = _textFieldWeight.text.floatValue;
}

- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    
    _btnDelete.hidden = _personRealm ? NO : YES;
    
    if (!hidden) {
        if (_personRealm) {
            [self showPersonRealm];
        } else {
            [self resetAllValues];
        }
    }
}

- (void)showPersonRealm {
    _textFieldName.text     = _personRealm.name;
    _textFieldAge.text      = [NSString stringWithFormat:@"%ld", _personRealm.age];
    _textFieldCity.text     = _personRealm.city;
    _textFieldJob.text      = _personRealm.job;
    _textFieldEmail.text    = _personRealm.email;
    _textFieldWechatId.text = _personRealm.wechatId;
    _textFieldAvatar.text   = _personRealm.avatar;
    _textFieldHeight.text   = [NSString stringWithFormat:@"%f", _personRealm.height];
    _textFieldWeight.text   = [NSString stringWithFormat:@"%f", _personRealm.weight];
}

- (void)resetAllValues {
    _textFieldName.text     = @"";
    _textFieldAge.text      = @"";
    _textFieldCity.text     = @"";
    _textFieldJob.text      = @"";
    _textFieldEmail.text    = @"";
    _textFieldWechatId.text = @"";
    _textFieldAvatar.text   = @"";
    _textFieldHeight.text   = @"";
    _textFieldWeight.text   = @"";
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
