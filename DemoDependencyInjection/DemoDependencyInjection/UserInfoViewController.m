//
//  UserInfoViewController.m
//  DemoDependencyInjection
//
//  Created by zj－db0465 on 14/03/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

#import "UserInfoViewController.h"

@interface UserInfoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lbName;

@property (weak, nonatomic) IBOutlet UILabel *lbAge;

@property (weak, nonatomic) IBOutlet UILabel *lbCity;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setUser:(User *)user {
    _user = user;
    
    _lbName.text = _user.name;
    _lbAge.text = [NSString stringWithFormat:@"%ld", (long)_user.age];
    _lbCity.text = _user.city;
}

- (IBAction)actionChangeUser:(UIButton *)sender {
    
}

@end
