//
//  PostDetailsViewController.h
//  BookBazaar
//
//  Created by Wade Wilkey on 16/11/2014.
//  Copyright (c) 2014 Wade Wilkey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserClass.h"
#import "Post.h"

@interface PostDetailsViewController : UIViewController
{
    Post *newPost;
    NSMutableData *downloadedData;
}
@property (weak, nonatomic) IBOutlet UILabel *booknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *isbnLabel;
@property (weak, nonatomic) IBOutlet UILabel *conditionLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;


@property (nonatomic) Post *postObject;



@end
