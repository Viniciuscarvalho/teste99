

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface UserModel : RLMSObject

@property (nonatomic) NSInteger userId;
@property (nonatomic) NSString *username;
@property (nonatomic) NSString *password;
@property (nonatomic) NSString *phone;
@property (nonatomic) NSString *loginToken;
@property (nonatomic) NSLocale *location;

@end
