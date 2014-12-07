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
    [_phoneNumTF setDelegate:self];
    submitClicked = NO;
    usernameAvailable = NO;
    nullField = YES;
    [_usernameValidity setHidden:YES];
    [_nullFieldLabel setHidden:YES];
    

    stateArr = @[@"AK", @"AL", @"AR", @"AZ", @"CA", @"CO", @"CT", @"DE", @"FL", @"GA", @"HI", @"IA", @"ID", @"IL", @"IN", @"KS", @"KY", @"LA", @"MA", @"MD", @"ME", @"MI", @"MN", @"MO", @"MS", @"MT", @"NC", @"ND", @"NE", @"NH", @"NJ", @"NM", @"NV", @"NY", @"OH", @"OK", @"OR", @"PA", @"RI", @"SC", @"SD", @"TN", @"TX", @"UT", @"VA", @"VT", @"WA", @"WI", @"WV", @"WY"];
    
    self.statePicker.dataSource = self;
    self.statePicker.delegate = self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*)testInsert:(NSArray*)testArr
{
    firstName = testArr[0];
    lastName = testArr[1];
    emailAddr = testArr[2];
    phoneNum = testArr[3];
    city = testArr[4];
    state = testArr[5];
    zipcode = testArr[6];
    password = testArr[7];
    
    [self insertDBItems];
    if(![downloadedData isEqual:[NSNull null]])
    {
        return @"Success";
    }
    else
    {
        return @"Failure";
    }
    
}


-(void)insertDBItems
{
    //NSString * query = [NSString stringWithFormat:@"http://67.182.205.14/cs3450/postService.php?query=INSERT INTO user (username, password, firstName, lastName, emailAddr, phoneNumber, city, state) VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')", username, password, firstName, lastName, emailAddr, phoneNum, city, @"UT"];
    
    NSString * query = [NSString stringWithFormat:@"http://67.182.205.14/cs3450/postService.php?query=INSERT INTO Login ( `UserName`, `Password`, `User_PhoneNum` ) VALUES ('%@', '%@', '%@') ", emailAddr, password, phoneNum];
    NSString * stringURL = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *jsonFileUrl = [NSURL URLWithString:stringURL];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    
    NSString * queryPost = [NSString stringWithFormat:@"http://67.182.205.14/cs3450/postService.php?query=INSERT INTO Users (`PhoneNum`, `Email`, `FirstName`, `LastName`, `City`, `State`, `ZipCode`, `IsAdmin`)  VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')", phoneNum, emailAddr, firstName, lastName, city, state, zipcode];
    NSString * stringURLPost = [queryPost stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *jsonFileUrlPost = [NSURL URLWithString:stringURLPost];
    NSURLRequest *urlRequestPost = [[NSURLRequest alloc] initWithURL:jsonFileUrlPost];
    [NSURLConnection connectionWithRequest:urlRequestPost delegate:self];
    NSLog(@"%@", stringURLPost);
     
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
    //username = _usernameTF.text;
    phoneNum = _phoneNumTF.text;
    if(![phoneNum isEqualToString:@""])
    {
    NSString * query = [NSString stringWithFormat:@"http://67.182.205.14/cs3450/service.php?query=SELECT * FROM Login WHERE UsersName='%@'", phoneNum];
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


// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return stateArr.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return stateArr[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    state = [stateArr objectAtIndex:row];
}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

@end
