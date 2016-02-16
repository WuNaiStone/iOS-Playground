//
//  ViewController.m
//  DemoCoreMotion
//
//  Created by zj－db0465 on 16/2/16.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"

#import <CoreMotion/CoreMotion.h>

@interface ViewController () <

    UIAccelerometerDelegate
>

@end

@implementation ViewController {

    UILabel *xlabel;
    UILabel *ylabel;
    UILabel *zlabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addLabels];
    
//    [self demoUIAccelerometer];
    
    [self demoCoreMotion];
}

- (void)addLabels {
    xlabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    [self.view addSubview:xlabel];
    
    ylabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 150, 200, 50)];
    [self.view addSubview:ylabel];
    
    zlabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 200, 50)];
    [self.view addSubview:zlabel];
}

- (void)demoUIAccelerometer {
    UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
    accelerometer.delegate = self;
    accelerometer.updateInterval = 0.1f;
    
}

#pragma mark - UIAccelerometerDelegate

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    xlabel.text = [NSString stringWithFormat:@"%.5f", acceleration.x];
    ylabel.text = [NSString stringWithFormat:@"%.5f", acceleration.y];
    zlabel.text = [NSString stringWithFormat:@"%.5f", acceleration.z];
}

- (void)demoCoreMotion {
    CMMotionManager *motionManager = [[CMMotionManager alloc] init];
    if (motionManager.accelerometerAvailable) {
        motionManager.accelerometerUpdateInterval = 0.1f;
        [motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            if (error) {
                [motionManager stopAccelerometerUpdates];
            } else {
                xlabel.text = [NSString stringWithFormat:@"%.5f", accelerometerData.acceleration.x];
                ylabel.text = [NSString stringWithFormat:@"%.5f", accelerometerData.acceleration.y];
                zlabel.text = [NSString stringWithFormat:@"%.5f", accelerometerData.acceleration.z];
            }
        }];
    } else {
        NSLog(@"accelerometerAvailable not.");
    }
}

@end
