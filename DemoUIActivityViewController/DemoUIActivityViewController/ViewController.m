//
//  ViewController.m
//  DemoUIActivityViewController
//
//  Created by zj－db0465 on 15/11/9.
//  Copyright © 2015年 icetime17. All rights reserved.
//

#import "ViewController.h"

@interface CustomActivity : UIActivity

@property (nonatomic) UIImage *shareImage;
@property (nonatomic, copy) NSString *URL;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray *shareContentArray;
-(instancetype)initWithImage:(UIImage *)shareImage atURL:(NSString *)URL atTitle:(NSString *)title atShareContentArray:(NSArray *)shareContentArray;

@end

@implementation CustomActivity

- (instancetype)initWithImage:(UIImage *)shareImage
                        atURL:(NSString *)URL
                      atTitle:(NSString *)title
          atShareContentArray:(NSArray *)shareContentArray {
    if (self = [super init]) {
        _shareImage = shareImage;
        _URL = URL;
        _title = title;
        _shareContentArray = shareContentArray;
    }
    return self;
}

+ (UIActivityCategory)activityCategory {
    return UIActivityCategoryShare;
}

- (NSString *)activityType {
    return _title;
}

- (NSString *)activityTitle {
    return _title;
}

- (UIImage *)activityImage {
    return _shareImage;
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    return YES;
}

- (UIViewController *)activityViewController {
    return nil;
}

- (void)performActivity {
    if (nil == _title) {
        return;
    }
    
    NSLog(@"%@", _shareContentArray);
    NSLog(@"%@", _title);
}

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
    [btn setTitle:@"Activity ViewController" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionActivityViewController:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)actionActivityViewController:(UIButton *)sender {
    NSString *title = @"My Title";
    NSString *content = @"My Content";
    UIImage *image = [UIImage imageNamed:@"CustomActivity"];
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSArray *activityItems = @[title, content, image, url];
    CustomActivity *customActivity = [[CustomActivity alloc] initWithImage:image atURL:url atTitle:title atShareContentArray:activityItems];
    
    NSArray *apps = @[customActivity];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:apps];
    activityVC.excludedActivityTypes = @[UIActivityTypeMessage, UIActivityTypeCopyToPasteboard];
    [self presentViewController:activityVC animated:YES completion:nil];
}

@end
