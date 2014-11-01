//
//  LoginViewController.m
//  BookBazaar
//
//  Created by Wade Wilkey on 23/10/2014.
//  Copyright (c) 2014 Wade Wilkey. All rights reserved.
//

#import "LoginViewController.h"



@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize uNameTextField;
@synthesize pWordTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitButton:(id)sender {
    NSString *username = self.uNameTextField.text;
    NSString *password = self.pWordTextField.text;
    NSLog(@"Here!: %@, %@", username, password);
    [self downloadItems];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.uNameTextField resignFirstResponder];
    [self.pWordTextField resignFirstResponder];

}

- (void)downloadItems
{
    
}
@end
