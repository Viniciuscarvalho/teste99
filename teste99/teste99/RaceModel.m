

#import "RaceModel.h"

@implementation RaceModel

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [self init];
    if (self == nil) return nil;
    
    _rideId : [dictionary[@"rideId"] copy];
    _message = [dictionary[@"msg"] copy];
    
    return self;
}

- (id) initWithCoder:(NSCoder *)coder {
    
    self = [self init];
    if (self == nil) return nil;
    
    _rideId : [coder decodeObjectForKey:@"rideId"];
    _message : [coder decodeObjectForKey:@"msg"];
    
    return self;
    
}


@end
