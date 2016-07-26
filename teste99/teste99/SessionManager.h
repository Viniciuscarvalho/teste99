
#import <UIKit/UIKit.h>

@interface SessionManager : NSObject

+(void)saveUserData:(NSDictionary *)userData;
+(NSDictionary *)getUserData;

+ (void) signupUser:(NSString *)name onSuccess:(void(^)(id data))success onFailure:(void(^)(NSError*error))failure;
+ (void) locationDriver:(NSInteger)sw pointNortheast:(NSInteger)ne onSuccess:(void(^)(NSMutableArray*data))success onFailure:(void(^)(NSError*error))failure;


@end
