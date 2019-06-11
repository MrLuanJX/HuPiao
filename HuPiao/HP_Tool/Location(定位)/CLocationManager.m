//
//  CLocationManager.m
//  MMLocationManager
//
//  Created by WangZeKeJi on 14-12-10.
//  Copyright (c) 2014年 Chen Yaoqiang. All rights reserved.
//

#import "CLocationManager.h"
@interface CLocationManager (){
    CLLocationManager *_manager;

}
@property (nonatomic, strong) LocationBlock locationBlock;
@property (nonatomic, strong) NSStringBlock cityBlock;
@property (nonatomic, strong) NSStringBlock addressBlock;
@property (nonatomic, strong) LocationErrorBlock errorBlock;
/*第一次点击允许定位*/
@property(nonatomic,copy)FirstAllowLocation firstAllow;

@end

@implementation CLocationManager

+ (CLocationManager *)shareLocation{
    
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (id)init {
    
    self = [super init];
    if (self) {
    }
    return self;
}

//获取经纬度
- (void) getLocationCoordinate:(LocationBlock) locaiontBlock
{
    self.locationBlock = [locaiontBlock copy];
    [self startLocation];
}

- (void) getLocationCoordinate:(LocationBlock) locaiontBlock  withAddress:(NSStringBlock) addressBlock FirstTime:(void (^)(void))FirstAllow
{
    self.locationBlock = [locaiontBlock copy];
    self.addressBlock = [addressBlock copy];
    self.firstAllow=[FirstAllow copy];
    [self startLocation];
}

- (void) getAddress:(NSStringBlock)addressBlock
{
    self.addressBlock = [addressBlock copy];
    [self startLocation];
}

//获取省市
- (void) getCity:(NSStringBlock)cityBlock
{
    self.cityBlock = [cityBlock copy];
    [self startLocation];
}

- (void) getCity:(NSStringBlock)cityBlock error:(LocationErrorBlock) errorBlock
{
    self.cityBlock = [cityBlock copy];
    self.errorBlock = [errorBlock copy];
    [self startLocation];
}

#pragma mark CLLocationManagerDelegate
//iOS6.0以上苹果的推荐方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = [locations lastObject];
    
     //获取当前城市经纬度
    _lastCoordinate = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude ,currentLocation.coordinate.longitude);
    
    if (_locationBlock) {
        _locationBlock(_lastCoordinate);
        _locationBlock = nil;
    }
    
    NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
    
    [standard setObject:@(currentLocation.coordinate.latitude) forKey:LastLatitude];
    [standard setObject:@(currentLocation.coordinate.longitude) forKey:LastLongitude];
    [standard synchronize];
    
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks,NSError *error)
     {
         if (placemarks.count > 0) {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];

             // Country(国家)  State(城市)  SubLocality(区)
             NSDictionary *test = [placemark addressDictionary];
             
             //省市地址
             self.lastCity = [test objectForKey:@"State"];
             [standard setObject:self.lastCity forKey:LastCity];
             
             //详细地址
             self.lastAddress = test[@"FormattedAddressLines"][0];
             [standard setObject:self.lastAddress forKey:LastAddress];
             
             //省市区
             NSString*pro=test[@"City"];
             NSString*city=test[@"State"];
             if ([pro containsString:@"北京"]
                 ||[pro containsString:@"天津"]
                 ||[pro containsString:@"重庆"]
                 ||[pro containsString:@"上海"]) {
                 city = test[@"SubLocality"];
                 
                 self.lastAddress= [pro stringByAppendingString:[NSString stringWithFormat:@" %@",city]];
             }else{
                 self.lastAddress= [city stringByAppendingString:[NSString stringWithFormat:@",%@",pro]];
             }
   
         }
         if (self.cityBlock) {
             self.cityBlock(self.lastCity);
             self.cityBlock = nil;
         }
         if (self.addressBlock) {
             self.addressBlock(self.lastAddress);
             self.addressBlock = nil;
         }
         
         
     }];
    
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager*)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    if (status==kCLAuthorizationStatusAuthorizedWhenInUse) {
           //保存GPS信息
        if (self.firstAllow) {
            self.firstAllow();
        }
    }
}

-(void)startLocation
{
//     if([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied)
    if([CLLocationManager locationServicesEnabled])
    {
        _manager = [[CLLocationManager alloc]init];
        _manager.delegate = self;
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        [_manager requestWhenInUseAuthorization]; //使用中授权
//        [_manager requestAlwaysAuthorization]; // 永久授权
        _manager.distanceFilter = 100;
        [_manager startUpdatingLocation];

    }
//    else
//    {
//        UIAlertView *alvertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"如果您需要开启定位服务,请到设置->隐私,打开定位服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alvertView show];
//        
//    }
    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    
    //访问被拒绝
    if ([error code] == kCLErrorDenied)
    {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
    //无法获取位置信息
    if ([error code] == kCLErrorLocationUnknown) {
        
    }
    [self stopUpdatingLocation];

}

- (void)stopUpdatingLocation{

    [_manager stopUpdatingLocation];
    _manager = nil;
}


@end
