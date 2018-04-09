//
//  DemoLocationViewController.m
//  DemoRAC
//
//  Created by Chris Hu on 08/04/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

#import "DemoLocationViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface DemoLocationViewController () <
    CLLocationManagerDelegate
>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger isNewName;


@property (weak, nonatomic) IBOutlet UILabel *lbLocation;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder *geoCoder;

@end

@implementation DemoLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RACSignal *signalName = RACObserve(self, name);
    [signalName subscribeNext:^(id  _Nullable x) {
        // 开始订阅的时候, 就会执行一次
        NSLog(@"name: %@", x);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.name = @"This is a new name";
    });
    
    
    // 将两个属性绑定起来.
//    RAC(self, isNewName) = RACObserve(self, name);
    
    [self setupLocationRAC];
}

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    return _locationManager;
}

- (CLGeocoder *)geoCoder {
    if (!_geoCoder) {
        _geoCoder = [[CLGeocoder alloc] init];
    }
    return _geoCoder;
}

/**
 返回是否允许定位的信号量

 @return RACSignal with bool
 */
- (RACSignal *)signalLocationAuthorized {
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    
    if (authorizationStatus == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestAlwaysAuthorization];
        
        return [[self rac_signalForSelector:@selector(locationManager:didChangeAuthorizationStatus:) fromProtocol:@protocol(CLLocationManagerDelegate)] map:^id _Nullable(RACTuple * _Nullable value) {
            return @([value[1] integerValue] == kCLAuthorizationStatusAuthorizedAlways);
        }];
    }
    return [RACSignal return:@(authorizationStatus == kCLAuthorizationStatusAuthorizedAlways)];
}

- (void)setupLocationRAC {
    [[[[[self signalLocationAuthorized] filter:^BOOL(id  _Nullable value) {
        
        // 是否允许定位
        return [value boolValue];
        
    }] then:^RACSignal * _Nonnull{
        
        return [[[[[[self rac_signalForSelector:@selector(locationManager:didUpdateLocations:) fromProtocol:@protocol(CLLocationManagerDelegate)] map:^id _Nullable(RACTuple * _Nullable value) {
            return value[1];
        }] merge:[[self rac_signalForSelector:@selector(locationManager:didFailWithError:) fromProtocol:@protocol(CLLocationManagerDelegate)] map:^id _Nullable(RACTuple * _Nullable value) {
            return [RACSignal error:value[1]];
            // 信号量包括: 位置信息, 及error
        }]] take:1] initially:^{
            // 信号量开始之前调用
            [self.locationManager startUpdatingLocation];
        }] finally:^{
            // 信号量发送之后调用
            [self.locationManager stopUpdatingLocation];
        }];
        
    }] flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        
        // 解析位置信息
        CLLocation *location = [value firstObject];
        NSLog(@"location: %@", location);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [self.geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                if (error) {
                    [subscriber sendError:error];
                } else {
                    [subscriber sendNext:[placemarks firstObject]];
                    [subscriber sendCompleted];
                }
            }];
            
            return [RACDisposable disposableWithBlock:^{
                
            }];
        }];
        
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
        CLPlacemark *place = (CLPlacemark *)x;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.lbLocation.text = [NSString stringWithFormat:@"%@%@%@%@", place.administrativeArea, place.locality, place.subLocality, place.thoroughfare];
        });
    }];
}

@end
