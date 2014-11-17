//
//  PostDetailsViewController.h
//  BookBazaar
//
//  Created by Wade Wilkey on 16/11/2014.
//  Copyright (c) 2014 Wade Wilkey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserClass.h"

@interface PostDetailsViewController : UIViewController
{
    UserClass *user;
}
@property (weak, nonatomic) IBOutlet UILabel *booknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (nonatomic) UserClass *userObject;

@end
