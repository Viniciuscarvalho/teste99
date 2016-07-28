
#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface APIManager : NSObject

+(void)saveUserData:(NSDictionary *)userData;
+(NSDictionary *)getUserData;

+ (void) signupUser:(NSString *)name onSuccess:(void(^)(id data))success onFailure:(void(^)(NSError*error))failure;
+ (void) locationDriver:(NSArray)sw pointNortheast:(NSArray)ne onSuccess:(void(^)(NSMutableArray*data))success onFailure:(void(^)(NSError*error))failure;
+ (void) requestTaxi:(NSString *)ride onSuccess:(void(^)(id data))success onFailure:(void(^)(NSError*error))failure;


@end
