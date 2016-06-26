//
//  ViewController.m
//  DemoMagicalRecord
//
//  Created by zj－db0465 on 16/1/13.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"

#import <MagicalRecord/MagicalRecord.h>

#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self insertPerson];    
    [self deletePerson];
    [self updatePerson];
    [self queryPerson];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertPerson{
    Person *person = [Person MR_createEntity];
    
    person.firstname = @"Chris";
    person.lastname = @"Hu";
    person.age = @18;
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (void)deletePerson {
    NSArray *persons18 = [Person MR_findByAttribute:@"age" withValue:@28];
    for (Person *p in persons18) {
        [p MR_deleteEntity];
    }
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (void)queryPerson {
    Person *firstPerson = [Person MR_findFirst];
    NSLog(@"firstPerson : %@, %@, %@", firstPerson.age, firstPerson.firstname, firstPerson.lastname);
    
    NSArray *persons = [Person MR_findAll];
    NSLog(@"persons : %@", persons);

    NSArray *personsSorted = [Person MR_findAllSortedBy:@"lastname" ascending:YES];
    NSArray *persons18 = [Person MR_findByAttribute:@"age" withValue:@18];
}

- (void)updatePerson {
    NSArray *persons18 = [Person MR_findByAttribute:@"age" withValue:@18];
    for (Person *p in persons18) {
        p.age = @28;
    }
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

@end
