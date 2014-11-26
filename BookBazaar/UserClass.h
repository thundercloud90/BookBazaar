//
//  User.h
//  BookBazaar
//
//  Created by Wade Wilkey on 9/11/2014.
//  Copyright (c) 2014 Wade Wilkey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserClass : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *emailAddr;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *userID;

@end
