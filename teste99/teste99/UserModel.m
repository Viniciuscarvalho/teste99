
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
        self.loginToken = @"received value";
    }];
    
}

//- (void) saveOnSuccess:(NSString *)name onSuccess:(void(^)[(id data)success onFailure:(void(^)(NSError *error))failure {
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:WS_AUTH_USER password:WS_AUTH_PASS];
//    
//    [manager POST:URL_CREATE_USERS
//       parameters:@{@"name": "username"}
//          success:^(AFHTTPRequestOperation *operation, id responseObject) {
//              NSLog(@"JSON: %@", responseObject);
//              success(responseObject);
//          } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
//              NSLog(@"Error: %@", error);
//              failure(error);
//          }];
// }
                                                           
@end
