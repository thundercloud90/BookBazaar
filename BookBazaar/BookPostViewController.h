//
//  BookPostViewController.h
//  BookBazaar
//
//  Created by Wade Wilkey on 18/11/2014.
//  Copyright (c) 2014 Wade Wilkey. All rights reserved.
//
#import "ViewController.h"
#import <UIKit/UIKit.h>

@interface BookPostViewController : UIViewController
{
    NSString *bookName;
    NSString *isbnNum;
    NSString *bookPrice;
    NSString *bookCondition;
    NSMutableData *dbReturnCode;
}
@property (weak, nonatomic) IBOutlet UITextField *bookNameTF;
@property (weak, nonatomic) IBOutlet UITextField *isbnNumTF;
@property (weak, nonatomic) IBOutlet UITextField *bookPriceTF;
- (IBAction)submitButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *bookConditionTF;
@property (weak, nonatomic) IBOutlet UILabel *successLabel;

@end
