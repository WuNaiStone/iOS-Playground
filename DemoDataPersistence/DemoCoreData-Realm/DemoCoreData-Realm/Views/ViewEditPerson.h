//
//  ViewEditPerson.h
//  DemoCoreData-Realm
//
//  Created by Chris Hu on 16/6/17.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonRealm.h"

@protocol ViewEditPersonDelegate <NSObject>

- (void)ViewEditPersonActionDone;

@end

@interface ViewEditPerson : UIView

@property (strong, nonatomic) PersonRealm *personRealm;

@property (weak, nonatomic) id<ViewEditPersonDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *textFieldName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAge;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCity;
@property (weak, nonatomic) IBOutlet UITextField *textFieldJob;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *textFieldWechatId;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAvatar;
@property (weak, nonatomic) IBOutlet UITextField *textFieldHeight;
@property (weak, nonatomic) IBOutlet UITextField *textFieldWeight;

@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnDone;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;

@end
