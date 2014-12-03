//
//  Post.h
//  BookBazaar
//
//  Created by Wade Wilkey on 2/12/2014.
//  Copyright (c) 2014 Wade Wilkey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject

@property (nonatomic, strong) NSString *bookName;
@property (nonatomic, strong) NSString *authorName;
@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *isbnNum;
@property (nonatomic, strong) NSString *bookCondition;
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, strong) NSString *userID;

@end
