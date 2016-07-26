
#import "UserModel.h"
#import "AFNetworking.h"
#import <Realm/Realm.h>

@implementation UserModel

+ (NSString *)primaryKey {
    
    return @"username";
}

+ (NSArray<NSString *> *)ignoredProperties {

    return @[@"password"];
}

- (void) login {

    [self.realm transactionWithBlock:^{
        self.loginToken = @"token";
    }];
    
}

                                                           
@end
