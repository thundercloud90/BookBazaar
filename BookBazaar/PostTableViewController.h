//
//  PostTableViewController.h
//  BookBazaar
//
//  Created by Wade Wilkey on 8/11/2014.
//  Copyright (c) 2014 Wade Wilkey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserClass.h"
#import "PostDetailsViewController.h"

@interface PostTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, NSURLConnectionDelegate>
{
    NSMutableData *_downloadedData;
    NSMutableArray *userInfo;
    
}


@property (strong, nonatomic) IBOutlet UITableView *listTableView;

@end
