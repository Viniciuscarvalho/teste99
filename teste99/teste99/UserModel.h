

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface UserModel : RLMSObject

@property (nonatomic) NSInteger userId;
@property (nonatomic) NSString *username;
@property (nonatomic) NSString *password;
@property (nonatomic) NSString *loginToken;

//- (void) saveOnSuccess:(NSString *)name onSuccess:(void(^)[(id data)success onFailure:(void(^)(NSError *error))failure;

@end
