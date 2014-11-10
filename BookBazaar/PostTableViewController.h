//
//  PostTableViewController.h
//  BookBazaar
//
//  Created by Wade Wilkey on 8/11/2014.
//  Copyright (c) 2014 Wade Wilkey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBConnection.h"

@interface PostTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, LoginProtocol>


@property (strong, nonatomic) IBOutlet UITableView *listTableView;

@end
