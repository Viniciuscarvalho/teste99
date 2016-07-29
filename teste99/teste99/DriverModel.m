

#import "DriverModel.h"

@implementation DriverModel

- (id)initWithDictionary:(NSDictionary *)dictionary {

    self = [self init];
    if (self == nil) return nil;
    
    _latitude = dictionary[@"latitude"];
    _longitude = dictionary[@"longitude"];
    _driverId = dictionary[@"driverId"];
    
    return self;
}

- (id) initWithCoder:(NSCoder *)coder {

    self = [self init];
    if (self == nil) return nil;
    
    _latitude = [coder decodeObjectForKey:@"latitude"];
    _longitude = [coder decodeObjectForKey:@"longitude"];
    _driverId = [coder decodeIntegerForKey:@"driverId"];
    
    return self;

}

@end
