//
//  RegisterViewController.m
//  BookBazaar
//
//  Created by Wade Wilkey on 8/11/2014.
//  Copyright (c) 2014 Wade Wilkey. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_pwErrorLabel setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getUserInfo:(id)sender {
    firstName = _firstNameTF.text;
    lastName = _lastNameTF.text;
    emailAddr = _emailAddrTF.text;
    phoneNum = _phoneNumTF.text;
    city = _cityTF.text;
    state = @"UT";
    username = _usernameTF.text;
    password = _passwordTF.text;
    NSString* passwordCheck = _rtPasswordTF.text;
    if(![password isEqualToString:passwordCheck])
    {
        [_pwErrorLabel setHidden:NO];
    }
    
    else{
         NSLog(@"%@, %@, %@, %@", firstName, lastName, emailAddr, phoneNum);
    }
    
   
}

-(void)insertDBItems
{
    NSString * query = [NSString stringWithFormat:@"http://67.182.205.14/cs3450/service.php?query=INSERT INTO user (username, password, firstName, lastName, emailAddr, phoneNumber, city, state) VALUES (%@, %@, %@, %@, %@, %@, %@, %@)", username, password, firstName, lastName, emailAddr, phoneNum, city, state];
    NSString * stringURL = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *jsonFileUrl = [NSURL URLWithString:stringURL];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
}

#pragma mark NSURLConnectionDataProtocol Methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    downloadedData = [[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [downloadedData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Create an array to store the locations
    NSString * correctPassword;
    // Parse the JSON that came in
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:downloadedData options:NSJSONReadingAllowFragments error:&error];
    
    // Loop through Json objects, create question objects and add them to our questions array
    for (int i = 0; i < jsonArray.count; i++)
    {
        NSDictionary *jsonElement = jsonArray[i];
        
        correctPassword = jsonElement[@"password"];
        
    }
    
    
    
    // Ready to notify delegate that data is ready and pass back items
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
