//
//  LocationManager.h
//  teste99
//
//  Created by Vinicius Carvalho on 25/07/16.
//  Copyright © 2016 Vinicius Carvalho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "UserModel.h"

@interface LocationManager : NSObject

+ (LocationManager *)sharedManager;

- (void)setGeofenceForUser:(UserModel *)user;

@end
