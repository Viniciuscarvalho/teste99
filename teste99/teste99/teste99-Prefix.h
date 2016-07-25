//
//  teste99-Prefix.h
//  teste99
//
//  Created by Vinicius Carvalho on 25/07/16.
//  Copyright © 2016 Vinicius Carvalho. All rights reserved.
//

#ifndef teste99_Prefix_h
#define teste99_Prefix_h


#endif /* teste99_Prefix_h */

#define HOST @"http://ec2-54-88-12-34.compute-1.amazonaws.com"

#define URL_CREATE_USER [HOST stringByAppendingString:[NSString stringWithFormat:@"v1/users"]]
#define URL_EDIT_USER (userId) [HOST stringByAppendingString:[NSString stringWithFormat:@"v1/users/@%d", userId ]]
#define URL_LIST_USERS (userId) [HOST stringByAppendingString:[NSString stringWithFormat:@"v1/users/@%d", userId]]
#define URL_REQUEST_DRIVER [HOST stringByAppendingString:[NSString stringWithFormat:@"v1/ride"]]
#define URL_RACE_DATA (rideId) [HOST stringByAppendingString:[NSString stringWithFormat:@"v1/ride/@%d", rideId ]]