

#import <Foundation/Foundation.h>

@interface UserModel : NSObject <NSCoding>

@property (nonatomic) NSInteger userId;
@property (nonatomic) NSString *username;
@property (nonatomic) NSString *password;
@property (nonatomic) NSString *phone;
@property (nonatomic) NSString *loginToken;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
