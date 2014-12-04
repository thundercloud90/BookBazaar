//
//  ViewController.h
//  BookBazaar
//
//  Created by Wade Wilkey on 9/10/2014.
//  Copyright (c) 2014 Wade Wilkey. All rights reserved.
//


#import "UserClass.h"
#import <UIKit/UIKit.h>

UserClass *globalUser;
bool isLoggedIn;
bool isAdmin;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *postBookButton;
@property (weak, nonatomic) IBOutlet UIButton *managePostButton;



@end

