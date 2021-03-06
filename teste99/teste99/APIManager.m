
#import "APIManager.h"
#import <AFNetworking/AFNetworking.h>
#import "UserModel.h"
#import "DriverModel.h"

@implementation APIManager

+ (void)saveUserData:(NSDictionary *)userData {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userData];
    [defaults setObject:data forKey:@"userData"];
    [defaults synchronize];
}

+ (NSDictionary *)getUserData {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"userData"];
    NSDictionary *userData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [defaults synchronize];
    return userData;
}

+ (void) signupUser:(NSString *)name onSuccess:(void(^)(id data))success onFailure:(void(^)(NSError*error))failure {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:URL_CREATE_USER
       parameters:@{@"name":name}
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"JSON: %@", responseObject);
              
              success(responseObject);
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
              failure(error);
          }];
}

+ (void) requestTaxi: (void(^)(id data))success onFailure:(void(^)(NSError*error))failure {

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [manager PUT:URL_REQUEST_DRIVER
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"JSON: %@", responseObject);
             
             [[operation responseObject] allHeaderFields];
             success(responseObject);
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
             failure(error);
         }];
    
}

+ (void) dataRacing:(NSInteger)rideId onSuccess:(void(^)(id data))success onFailure:(void(^)(NSError*error))failure {

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:URL_RACE_DATA(rideId)
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"JSON: %@", responseObject);
             
             success(responseObject);
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
             failure(error);
         }];

}

+ (void) listUsers:(NSInteger)userId onSuccess:(void(^)(id data))success onFailure:(void(^)(NSError*error))failure {

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:URL_LIST_USERS(userId)
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"JSON: %@", responseObject);
         
             success(responseObject);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         failure(error);
     }];

    
}


+ (void) locationDriver:(NSArray *)sw pointNortheast:(NSArray *)ne onSuccess:(void(^)(NSMutableArray*data))success onFailure:(void(^)(NSError*error))failure {

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:@"https://api.99taxis.com/lastLocations"
      parameters:@{@"sw":@("sw"), @"ne":@("ne")}
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"JSON: %@", responseObject);
             
             if([responseObject count] > 0) {
                 
                 NSMutableArray *locationDrivers = [NSMutableArray new];
                 
                 for (NSDictionary *locationDriver in responseObject) {
                     
                     DriverModel *driver = [[DriverModel alloc] initWithDictionary:locationDriver];
                     [locationDrivers addObject:driver];
                 
                 }
                 
                 success(locationDrivers);
             }
             
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"Error: %@", error);
                 failure(error);
             }];
    
}

@end

