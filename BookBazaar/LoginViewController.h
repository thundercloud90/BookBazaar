//
//  LoginViewController.h
//  BookBazaar
//
//  Created by Wade Wilkey on 23/10/2014.
//  Copyright (c) 2014 Wade Wilkey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <NSURLConnectionDelegate>
{
    NSMutableData *downloadedData;
}
@property (weak, nonatomic) IBOutlet UITextField *uNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *pWordTextField;


@end
