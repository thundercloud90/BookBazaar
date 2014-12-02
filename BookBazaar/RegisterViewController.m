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
    [_successLabel setHidden:YES];
    [_fnErrorLabel setHidden:YES];
    [_lnErrorLabel setHidden:YES];
    [_eaErrorLabel setHidden:YES];
    [_pnErrorLabel setHidden:YES];
    [_cityErrorLabel setHidden:YES];
    [_unErrorLabel setHidden:YES];
    [_nullPWErrorLabel setHidden:YES];
    [_usernameTF setDelegate:self];
    submitClicked = NO;
    usernameAvailable = NO;
    nullField = YES;
    [_usernameValidity setHidden:YES];
    [_nullFieldLabel setHidden:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)insertDBItems
{
    NSString * query = [NSString stringWithFormat:@"http://67.182.205.14/cs3450/postService.php?query=INSERT INTO user (username, password, firstName, lastName, emailAddr, phoneNumber, city, state) VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')", username, password, firstName, lastName, emailAddr, phoneNum, city, @"UT"];
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
    if(submitClicked)
    {
        NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", output);
        if([output isEqualToString:@"Success!"])
        {
            [_successLabel setHidden:NO];
            _successLabel.text = @"Registration Successful";
            [self.navigationController popViewControllerAnimated:TRUE];
            
        }
        else
        {
            [_successLabel setHidden:NO];
            _successLabel.text = @"Registration Failed. Contact System Admin";
        }

    }
    
    else
    {
        [downloadedData appendData:data];
        
        
    }
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if(!submitClicked)
    {
        // Parse the JSON that came in
        NSError *error;
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:downloadedData options:NSJSONReadingAllowFragments error:&error];
    
    // Loop through Json objects, create question objects and add them to our questions array
        if(jsonArray.count > 0)
        {
            _usernameValidity.text = @"Unavailable";
            _usernameValidity.textColor = [UIColor redColor];
            [_usernameValidity setHidden:NO];
            usernameAvailable = NO;
        }
        
        else
        {
            _usernameValidity.text = @"Available";
            _usernameValidity.textColor = [UIColor greenColor];
            [_usernameValidity setHidden:NO];
            usernameAvailable = YES;
        }
        
    
    }
    
    // Ready to notify delegate that data is ready and pass back items
}

- (IBAction)textDidChange:(id)sender {
    username = _usernameTF.text;
    if(![username isEqualToString:@""])
    {
    NSString * query = [NSString stringWithFormat:@"http://67.182.205.14/cs3450/service.php?query=SELECT * FROM user WHERE username='%@'", username];
    NSString * stringURL = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *jsonFileUrl = [NSURL URLWithString:stringURL];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    }
    
    else{
        [_usernameValidity setHidden:YES];
        usernameAvailable = NO;
    }
}

- (IBAction)clickedSubmitButton:(id)sender {
    //We now need to check for null fields and guard against empty inserts.
    //TODO -- 
    firstName = _firstNameTF.text;
    if([firstName isEqualToString:@""])
    {
        [_fnErrorLabel setHidden:NO];
        nullField = YES;
    }
    else
    {
        [_fnErrorLabel setHidden:YES];
        nullField = NO;
    }
    
    lastName = _lastNameTF.text;
    if([lastName isEqualToString:@""])
    {
        [_lnErrorLabel setHidden:NO];
        nullField = YES;
    }
    else
    {
        [_lnErrorLabel setHidden:YES];
        nullField = NO;
    }
    
    emailAddr = _emailAddrTF.text;
    if([emailAddr isEqualToString:@""])
    {
        [_eaErrorLabel setHidden:NO];
        nullField = YES;
    }
    else
    {
        [_eaErrorLabel setHidden:YES];
        nullField = NO;
    }
    
    phoneNum = _phoneNumTF.text;
    if([phoneNum isEqualToString:@""])
    {
        [_pnErrorLabel setHidden:NO];
        nullField = YES;
    }
    else
    {
        [_pnErrorLabel setHidden:YES];
        nullField = NO;
    }
    
    city = _cityTF.text;
    if([city isEqualToString:@""])
    {
        [_cityErrorLabel setHidden:NO];
        nullField = YES;
    }
    else
    {
        [_cityErrorLabel setHidden:YES];
        nullField = NO;
    }
    
    state = @"UT";
    
    username = _usernameTF.text;
    if([username isEqualToString:@""])
    {
        [_unErrorLabel setHidden:NO];
        nullField = YES;
    }
    else
    {
        [_unErrorLabel setHidden:YES];
        nullField = NO;
    }
    
    password = _passwordTF.text;
    if([password isEqualToString:@""])
    {
        [_nullPWErrorLabel setHidden:NO];
        nullField = YES;
    }
    else
    {
        [_nullPWErrorLabel setHidden:YES];
        nullField = NO;
    }
    
    if(nullField)
    {
        [_nullFieldLabel setHidden:NO];
    }
    
    NSString* passwordCheck = _rtPasswordTF.text;
    
    if(![password isEqualToString:passwordCheck])
    {
        [_pwErrorLabel setHidden:NO];
    }
    else if(!usernameAvailable)
    {
        _successLabel.text = @"Username Unavailable. Retry";
        [_successLabel setHidden:NO];
    }
    else if(!nullField){
        NSLog(@"%@, %@, %@, %@", firstName, lastName, emailAddr, phoneNum);
         submitClicked = YES;
        [self insertDBItems];
       
    }
    
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
