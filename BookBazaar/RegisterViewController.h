//
//  RegisterViewController.h
//  BookBazaar
//
//  Created by Wade Wilkey on 8/11/2014.
//  Copyright (c) 2014 Wade Wilkey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController <NSURLConnectionDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSString* firstName;
    NSString* lastName;
    NSString* emailAddr;
    NSString* phoneNum;
    NSString* username;
    NSString* password;
    NSString *street;
    NSString *city;
    NSString *state;
    NSString *zipcode;
    NSMutableData *downloadedData;
    bool submitClicked;
    bool usernameAvailable;
    bool nullField;
    NSArray *stateArr;
    UIPickerView *picker;
    UITextField *stateField;
    
}
@property (weak, nonatomic) IBOutlet UITextField *firstNameTF;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTF;
@property (weak, nonatomic) IBOutlet UITextField *emailAddrTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *cityTF;

@property (weak, nonatomic) IBOutlet UITextField *rtPasswordTF;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UILabel *usernameValidity;

@property (weak, nonatomic) IBOutlet UILabel *pwErrorLabel;
- (IBAction)textDidChange:(id)sender;

- (IBAction)clickedSubmitButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *successLabel;
@property (weak, nonatomic) IBOutlet UILabel *nullFieldLabel;
@property (weak, nonatomic) IBOutlet UILabel *fnErrorLabel;
@property (weak, nonatomic) IBOutlet UILabel *lnErrorLabel;
@property (weak, nonatomic) IBOutlet UILabel *eaErrorLabel;
@property (weak, nonatomic) IBOutlet UILabel *pnErrorLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityErrorLabel;
@property (weak, nonatomic) IBOutlet UILabel *unErrorLabel;
@property (weak, nonatomic) IBOutlet UILabel *nullPWErrorLabel;

@property (weak, nonatomic) IBOutlet UIPickerView *statePicker;

-(IBAction)textFieldReturn:(id)sender;
-(NSString*)insertItems:(NSArray*)arr;


@end
