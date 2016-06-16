//
//  ViewTableViewCellPerson.m
//  DemoCoreData-Realm
//
//  Created by Chris Hu on 16/6/16.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

#import "ViewTableViewCellPerson.h"

@implementation ViewTableViewCellPerson

- (void)awakeFromNib {
    self.backgroundColor = [UIColor colorWithRed:((arc4random() % 255) / 255.0)
                    green:((arc4random() % 255) / 255.0)
                     blue:((arc4random() % 255) / 255.0)
                    alpha:1.0f];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
