//
//  ViewController.m
//  BatteryTestAppOC
//
//  Created by rcadmin on 4/7/15.
//  Copyright (c) 2015 rcadmin. All rights reserved.
//

#import "ViewController.h"

#import "IOKit/IOPSKeys.h"
#import "IOKit/IOPowerSources.h"

#import "AFNetworking/AFNetworking.h"


@interface ViewController ()


@property (weak, nonatomic) IBOutlet UILabel *deviceName;
@property (weak, nonatomic) IBOutlet UILabel *deviceUUID;
@property (weak, nonatomic) IBOutlet UILabel *batteryPercentage;
@property (weak, nonatomic) IBOutlet UILabel *networkLabel;


@end


@implementation ViewController

    const NSString *batteryLevelURL = @"http://10.32.36.22:8017/batteryLevel/level";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self reportDeviceInfo];
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self
//                        selector:@selector(reportDeviceInfo) userInfo:nil repeats:true];

    [[UIApplication sharedApplication] setKeepAliveTimeout:600 handler:^{[self reportDeviceInfo];}];
}


-(void) reportDeviceInfo {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:batteryLevelURL parameters:[self getDeviceInfo]
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"succeed in reporting device info.");
            self.networkLabel.textColor = UIColor.blackColor;
            self.networkLabel.text = @"Succeed in reporting this device info.";
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"fail to report device info.");
            self.networkLabel.textColor = UIColor.redColor;
            self.networkLabel.text = @"Fail to report device info. please check network.";
        }];
}


-(NSMutableDictionary*) getDeviceInfo {
    NSMutableDictionary *deviceInfo = [NSMutableDictionary dictionaryWithCapacity:5];
    
    UIDevice *device = [UIDevice currentDevice];
    NSString *name = device.name;
    NSString *uuid = [NSString stringWithFormat:@"%@", device.identifierForVendor.UUIDString];
    [deviceInfo setObject:name forKey:@"name"];
    [deviceInfo setObject:uuid forKey:@"uuid"];
    
    [UIDevice currentDevice].batteryMonitoringEnabled = true;
    double percentage = [self getBatteryLevel];
    [deviceInfo setObject:[NSString stringWithFormat:@"%.1f", percentage] forKey:@"batteryLevel"];
    [UIDevice currentDevice].batteryMonitoringEnabled = false;
    
    self.deviceName.text = name;
    self.deviceUUID.lineBreakMode = NSLineBreakByTruncatingMiddle;
    self.deviceUUID.text = uuid;
    self.batteryPercentage.text = [NSString stringWithFormat:@"%.1f\%", percentage];

    return deviceInfo;
}


-(double) getBatteryLevel{
    // returns a blob of power source information in an opaque CFTypeRef
    CFTypeRef blob = IOPSCopyPowerSourcesInfo();
    // returns a CFArray of power source handles, each of type CFTypeRef
    CFArrayRef sources = IOPSCopyPowerSourcesList(blob);
    CFDictionaryRef pSource = NULL;
    const void *psValue;
    // returns the number of values currently in an array
    int numOfSources = CFArrayGetCount(sources);
    // error in CFArrayGetCount
    if (numOfSources == 0) {
        NSLog(@"Error in CFArrayGetCount");
        return -1.0f;
    }
    
    // calculating the remaining energy
    for (int i=0; i<numOfSources; i++) {
        // returns a CFDictionary with readable information about the specific power source
        pSource = IOPSGetPowerSourceDescription(blob, CFArrayGetValueAtIndex(sources, i));
        if (!pSource) {
            NSLog(@"Error in IOPSGetPowerSourceDescription");
            return -1.0f;
        }
        psValue = (CFStringRef) CFDictionaryGetValue(pSource, CFSTR(kIOPSNameKey));
        
        int curCapacity = 0;
        int maxCapacity = 0;
        double percentage;
        
        psValue = CFDictionaryGetValue(pSource, CFSTR(kIOPSCurrentCapacityKey));
        CFNumberGetValue((CFNumberRef)psValue, kCFNumberSInt32Type, &curCapacity);
        
        psValue = CFDictionaryGetValue(pSource, CFSTR(kIOPSMaxCapacityKey));
        CFNumberGetValue((CFNumberRef)psValue, kCFNumberSInt32Type, &maxCapacity);
        
        percentage = ((double) curCapacity / (double) maxCapacity * 100.0f);
        NSLog(@"curCapacity : %d / maxCapacity: %d , percentage: %.1f ", curCapacity, maxCapacity, percentage);
        return percentage;
    }
    return -1.0f;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
