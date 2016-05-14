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
#import "ViewCircle.h"

typedef NS_ENUM(NSInteger, EnumDemoUIView) {
    DemoAutoResize = 0,
    DemoXXNib,
    DemoCircleView,
};

@interface DemoViewController ()

@end

@implementation DemoViewController {

    ViewCircle *scaleCircle;
}

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
        case DemoCircleView:
        {
            ViewCircle *baseCircle = [[ViewCircle alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
            baseCircle.center = self.view.center;
            [self.view addSubview:baseCircle];
            
            scaleCircle = [[ViewCircle alloc] initWithFrame:baseCircle.frame];
            scaleCircle.center = baseCircle.center;
            [self.view addSubview:scaleCircle];
            
            [self addButton];
            break;
        }
        default:
            break;
    }
}

- (void)addButton {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 50)];
    [btn setTitle:@"Button" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.view addSubview:btn];
}

- (void)actionButton:(UIButton *)sender {
    [UIView animateWithDuration:1 animations:^{
        scaleCircle.transform = CGAffineTransformMakeScale(1.1, 1.1);
        scaleCircle.alpha = 0.0f;
    } completion:^(BOOL finished) {
        scaleCircle.transform = CGAffineTransformMakeScale(1.0, 1.0);
        scaleCircle.alpha = 0.2f;
    }];
}
@end
