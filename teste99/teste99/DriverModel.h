

#import <Foundation/Foundation.h>

@interface DriverModel : NSObject

@property (weak, nonatomic) NSString *latitude;
@property (weak, nonatomic) NSString *longitude;
@property (nonatomic) NSInteger *driverId;
@property (nonatomic) BOOL *driverAvailable;


@end
