//
//  ViewTableViewCellPerson.h
//  DemoCoreData-Realm
//
//  Created by Chris Hu on 16/6/16.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewTableViewCellPerson : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbAge;
@property (weak, nonatomic) IBOutlet UILabel *lbCity;
@property (weak, nonatomic) IBOutlet UILabel *lbJob;

@end
