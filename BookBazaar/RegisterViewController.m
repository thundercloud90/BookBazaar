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
    [_usernameTF setDelegate:self];
    submitClicked = NO;
    usernameAvailable = NO;
    [_usernameValidity setHidden:YES];
    
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
    else if(!usernameAvailable)
    {
        _successLabel.text = @"Username Unavailable. Retry";
        [_successLabel setHidden:NO];
    }
    else{
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
