//
//  PersonCoreData.m
//  DemoCoreData-Realm
//
//  Created by Chris Hu on 16/6/17.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

#import "PersonCoreData.h"

@implementation PersonCoreData

// Insert code here to add functionality to your managed object subclass

- (NSString *)description
{
    NSMutableString *desc = [NSMutableString stringWithFormat:@"\nPersonCoreData:\n"];
    [desc appendString:[NSString stringWithFormat:@"\t name:    %@\n", self.name]];
    [desc appendString:[NSString stringWithFormat:@"\t age:     %@\n", self.age]];
    [desc appendString:[NSString stringWithFormat:@"\t city:    %@\n", self.city]];
    [desc appendString:[NSString stringWithFormat:@"\t job:     %@\n", self.job]];
    [desc appendString:[NSString stringWithFormat:@"\t email:   %@\n", self.email]];
    [desc appendString:[NSString stringWithFormat:@"\t wechatId:%@\n", self.wechatId]];
    [desc appendString:[NSString stringWithFormat:@"\t avatar:  %@\n", self.avatar]];
    [desc appendString:[NSString stringWithFormat:@"\t height:  %@\n", self.height]];
    [desc appendString:[NSString stringWithFormat:@"\t weight:  %@\n", self.weight]];
    
    return desc;
}

@end
