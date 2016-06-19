//
//  DemoPersonCoreDataViewController.m
//  DemoCoreData-Realm
//
//  Created by Chris Hu on 16/6/16.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

#import "DemoPersonCoreDataViewController.h"
#import "ViewTableViewCellPerson.h"
#import "DemoPersonCoreData.h"
#import "PersonCoreData.h"

@interface DemoPersonCoreDataViewController () <
    UITableViewDataSource,
    UITableViewDelegate
>

@end

@implementation DemoPersonCoreDataViewController {

    UITableView *_tableView;
    
    NSArray *_persons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self demoCoreData];
    
    [self initTableView];
    
    [self updateDataSource];
}

- (void)demoCoreData {
//    [[DemoPersonCoreData sharedInstance] addPersonCoreData];
    
    NSArray *fetchedObjects = [[DemoPersonCoreData sharedInstance] queryPersonCoreData];
    
    for (PersonCoreData *person in fetchedObjects) {
        NSLog(@"person : %@", person.description);
    }
}

- (void)initTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([ViewTableViewCellPerson class]) bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"UITableViewCell-CoreData"];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
}

- (void)updateDataSource {
    _persons = [[DemoPersonCoreData sharedInstance] queryPersonCoreData];
    
    [_tableView reloadData];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _persons.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.f;
}

- (ViewTableViewCellPerson *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ViewTableViewCellPerson *cell = (ViewTableViewCellPerson *)[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell-CoreData" forIndexPath:indexPath];
    
    PersonCoreData *person     = (PersonCoreData *)_persons[indexPath.row];
    cell.avatar.image       = [UIImage imageNamed:person.avatar];
    cell.lbName.text        = person.name;
    cell.lbWechatId.text    = person.wechatId;
    cell.lbAge.text         = [NSString stringWithFormat:@"%@", person.age];
    cell.lbCity.text        = person.city;
    cell.lbHeight.text      = [NSString stringWithFormat:@"%@", person.height];
    cell.lbWeight.text      = [NSString stringWithFormat:@"%@", person.weight];
    
    return cell;
}

@end
