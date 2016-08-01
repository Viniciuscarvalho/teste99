

#import <Foundation/Foundation.h>

@interface DriverModel : NSObject <NSCoding>

@property (nonatomic, readonly) double latitude;
@property (nonatomic, readonly) double longitude;
@property (nonatomic, readonly) NSInteger *driverId;
@property (nonatomic) BOOL *driverAvailable;

- (id) initWithDictionary:(NSDictionary *)dictionary;

@end
