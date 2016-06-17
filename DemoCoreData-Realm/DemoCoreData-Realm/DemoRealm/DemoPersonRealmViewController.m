//
//  DemoPersonRealmViewController.m
//  DemoCoreData-Realm
//
//  Created by Chris Hu on 16/6/16.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

#import "DemoPersonRealmViewController.h"
#import "ViewTableViewCellPerson.h"
#import "DemoPersonRealm.h"
#import "PersonRealm.h"

@interface DemoPersonRealmViewController () <
    UITableViewDataSource,
    UITableViewDelegate
>

@end

@implementation DemoPersonRealmViewController {

    UITableView *_tableView;
    
    NSArray *_persons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavBar];
    
    [self initTableView];
    
    [self updateDataSource];
}

- (void)initNavBar {
    UIBarButtonItem *btnLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(actionAdd:)];
    self.navigationItem.leftBarButtonItem = btnLeft;
    
    UIBarButtonItem *btnRight = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(actionSorted:)];
    self.navigationItem.rightBarButtonItem = btnRight;
}

- (void)actionAdd:(UIBarButtonItem *)sender {
    for (NSInteger i = 0; i<1000; i++) {
        [[DemoPersonRealm sharedInstance] addPersonRealm];
    }
    
    [self updateDataSource];
}

- (void)actionSorted:(UIBarButtonItem *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sorted" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *actionSortedByAvatar = [UIAlertAction actionWithTitle:@"Avatar" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _persons = [[DemoPersonRealm sharedInstance] queryPersonRealmSortedBy:@"avatar"];
        [_tableView reloadData];
        
    }];
    
    UIAlertAction *actionSortedByHeight = [UIAlertAction actionWithTitle:@"Height" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _persons = [[DemoPersonRealm sharedInstance] queryPersonRealmSortedBy:@"height"];
        [_tableView reloadData];
        
    }];
    
    UIAlertAction *actionSortedByWeight = [UIAlertAction actionWithTitle:@"Weight" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _persons = [[DemoPersonRealm sharedInstance] queryPersonRealmSortedBy:@"weight"];
        [_tableView reloadData];
        
    }];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:actionSortedByAvatar];
    [alert addAction:actionSortedByHeight];
    [alert addAction:actionSortedByWeight];
    [alert addAction:actionCancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)initTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([ViewTableViewCellPerson class]) bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"UITableViewCell-Realm"];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
}

- (void)updateDataSource {
    _persons = [[DemoPersonRealm sharedInstance] queryPersonRealm];
    
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
    ViewTableViewCellPerson *cell = (ViewTableViewCellPerson *)[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell-Realm" forIndexPath:indexPath];
    
    PersonRealm *person     = (PersonRealm *)_persons[indexPath.row];
    cell.avatar.image       = [UIImage imageNamed:person.avatar];
    cell.lbName.text        = person.name;
    cell.lbWechatId.text    = person.wechatId;
    cell.lbAge.text         = [NSString stringWithFormat:@"%ld", (long)person.age];
    cell.lbCity.text        = person.city;
    cell.lbHeight.text      = [NSString stringWithFormat:@"%ld", (long)person.height];
    cell.lbWeight.text      = [NSString stringWithFormat:@"%ld", (long)person.weight];
    
    return cell;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
