

#import <Foundation/Foundation.h>

@interface DriverModel : NSObject <NSCoding>

@property (nonatomic, readonly) NSString *latitude;
@property (nonatomic, readonly) NSString *longitude;
@property (nonatomic, readonly) NSInteger *driverId;
@property (nonatomic) BOOL *driverAvailable;

- (id) initWithDictionary:(NSDictionary *)dictionary;

@end
