
#import "UserModel.h"

@implementation UserModel

- (id) initWithDictionary:(NSDictionary *)dictionary {

    self = [self init];
    if (self == nil) return nil;
    
    _userId : [dictionary[@"userId"] copy];
    _username = [dictionary[@"name"] copy];
    _password = [dictionary[@"password"] copy];
    
    return self;
}

- (id) initWithCoder:(NSCoder *)coder {

    self = [self init];
    if (self == nil) return nil;
    
    _userId = [coder decodeIntegerForKey:@"userId"];
    _username = [coder decodeObjectForKey:@"name"];
    _password = [coder decodeObjectForKey:@"password"];
    
    return self;
}
                                                           
@end
