//
//  ManagePostsTableView.h
//  BookBazaar
//
//  Created by Wade Wilkey on 3/12/2014.
//  Copyright (c) 2014 Wade Wilkey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "UserClass.h"

NSInteger row;
@interface ManagePostsTableView : UITableViewController <UITableViewDataSource, UITableViewDelegate, NSURLConnectionDelegate, UIAlertViewDelegate>
{
    NSMutableArray *postInfo;
    NSMutableData *downloadedData;
    
}

@property (strong, nonatomic) IBOutlet UITableView *listTableView;
@property (strong) NSIndexPath *pathToDelete;

@end
