//
//  DemoViewController.m
//  DemoUIViewRelatedAll
//
//  Created by icetime17 on 16/2/13.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "DemoViewController.h"
#import "UIViewAutoResize.h"
#import "ViewBase.h"

typedef NS_ENUM(NSInteger, EnumDemoUIView) {
    DemoAutoResize = 0,
    DemoXXNib,
};

@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self showDemos];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showDemos {
    switch ([self.demos indexOfObject:self.title]) {
        case DemoAutoResize:
        {
            UIViewAutoResize *view = [[UIViewAutoResize alloc] initWithFrame:self.view.frame];
            [self.view addSubview:view];
            break;
        }
        case DemoXXNib:
        {
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ViewBase" owner:self options:nil];
            ViewBase *view = (ViewBase *)[array objectAtIndex:0];
            [self.view addSubview:view];
            break;
        }
        default:
            break;
    }
}

@end
