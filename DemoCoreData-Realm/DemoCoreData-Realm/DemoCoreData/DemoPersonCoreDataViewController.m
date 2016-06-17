//
//  DemoPersonCoreDataViewController.m
//  DemoCoreData-Realm
//
//  Created by Chris Hu on 16/6/16.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

#import "DemoPersonCoreDataViewController.h"
#import "DemoPersonCoreData.h"
#import "PersonCoreData.h"

@interface DemoPersonCoreDataViewController ()

@end

@implementation DemoPersonCoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self demoCoreData];
}

- (void)demoCoreData {
//    [[DemoPersonCoreData sharedInstance] addPersonCoreData];
    
    NSArray *fetchedObjects = [[DemoPersonCoreData sharedInstance] queryPersonCoreData];
    
    for (PersonCoreData *person in fetchedObjects) {
        NSLog(@"person : %@", person.description);
    }
}

@end
