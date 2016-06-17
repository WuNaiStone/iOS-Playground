//
//  DemoPersonCoreData.m
//  DemoCoreData-Realm
//
//  Created by Chris Hu on 16/6/17.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

#import "DemoPersonCoreData.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "PersonCoreData.h"

#define ENTITY_PERSON   @"PersonCoreData"

@interface DemoPersonCoreData ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation DemoPersonCoreData {
    
}

+ (instancetype)sharedInstance {
    static DemoPersonCoreData *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        sharedInstance.managedObjectContext = appDelegate.managedObjectContext;
        
    });
    
    return sharedInstance;
}

- (void)addPersonCoreData {
    PersonCoreData *person = (PersonCoreData *)[NSEntityDescription insertNewObjectForEntityForName:ENTITY_PERSON inManagedObjectContext:_managedObjectContext];
    
    person.name     = @"chris";
    person.age      = @18;
    person.city     = @"city 1";
    person.job      = @"job 1";
    person.email    = @"email 1";
    person.wechatId = @"wechatId 1";
    person.avatar   = @"avatar1.png";
    person.height   = @175;
    person.weight   = @65;
    
    [_managedObjectContext save:nil];
}

- (NSArray *)queryPersonCoreData {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_PERSON inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    
    /*
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"<#format string#>", <#arguments#>];
    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"<#key#>"
                                                                   ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    */
    
    NSError *error = nil;
    NSArray *fetchedObjects = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"fetchedObjects : nil");
    }
    
    return fetchedObjects;
}

@end
