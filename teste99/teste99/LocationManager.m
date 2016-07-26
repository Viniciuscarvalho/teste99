

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "LocationManager.h"
#import "UserModel.h"

@interface LocationManager() <CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager *locationManager;

@end

@implementation LocationManager

// Create a singleton of the LocationManager

+ (LocationManager *)sharedManager {
    static LocationManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (instancetype)init {
    if (self == [super init]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        return self;
    }
    return nil;
}


@end
