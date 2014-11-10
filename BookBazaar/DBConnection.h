//
//  DBConnection.h
//  BookBazaar
//
//  Created by Wade Wilkey on 31/10/2014.
//  Copyright (c) 2014 Wade Wilkey. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "UserClass.h"

@protocol LoginProtocol <NSObject>

- (void)itemsDownloaded:(NSArray *)items;

@end

@interface DataModel : NSObject

@property (nonatomic, weak) id<LoginProtocol> delegate;

- (void)downloadItems;

@end
