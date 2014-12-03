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
    [_invalidLoginLabel setHidden:true];
    collectData = NO;
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
    [self downloadItems:username];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.uNameTextField resignFirstResponder];
    [self.pWordTextField resignFirstResponder];

}

-(void)validatePassword:(NSString *)correctPassword
{
    NSLog([NSString stringWithFormat:@"Entered: %@ Correct: %@", self.pWordTextField.text, correctPassword]);
    if([correctPassword isEqualToString:self.pWordTextField.text])
    {
        NSString * username = self.uNameTextField.text;
        NSString * query = [NSString stringWithFormat:@"http://67.182.205.14/cs3450/service.php?query=SELECT * FROM user WHERE username='%@'", username];
        NSString * stringURL = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *jsonFileUrl = [NSURL URLWithString:stringURL];
        NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
        //[NSURLConnection connectionWithRequest:urlRequest delegate:self];
        _conn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
        
        NSError *error;
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:downloadedData options:NSJSONReadingAllowFragments error:&error];
        NSDictionary *jsonElement2 = jsonArray[0];

        globalUser.firstName = [[NSString alloc] initWithString:jsonElement2[@"firstName"]];
        globalUser.lastName = jsonElement2[@"lastName"];
        globalUser.emailAddr = jsonElement2[@"emailAddr"];
        globalUser.phoneNumber = jsonElement2[@"phoneNumber"];
        globalUser.city = jsonElement2[@"city"];
        globalUser.state = jsonElement2[@"state"];
        globalUser.userID = jsonElement2[@"id"];
        
        isLoggedIn = YES;
        [self.conn cancel];
        [self.navigationController popViewControllerAnimated:TRUE];
    }
    else
    {
        [_invalidLoginLabel setHidden:false];
       // NSData* imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:@"http://67.182.205.14/cs3450/bookImages/photo2.JPG"]];

//        [self testImage].image = [[UIImage alloc] initWithData:imageData];
        
    }
}

-(void)downloadItems:(NSString*) username
{
    //NSString * username = self.uNameTextField.text;
    NSString * query = [NSString stringWithFormat:@"http://67.182.205.14/cs3450/service.php?query=SELECT * FROM user WHERE username='%@'", username];
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
    // Parse the JSON that came in
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:downloadedData options:NSJSONReadingAllowFragments error:&error];
    
   
    // Create an array to store the locations
    NSString * correctPassword;

    
    // Loop through Json objects, create question objects and add them to our questions array
    for (int i = 0; i < jsonArray.count; i++)
    {
        NSDictionary *jsonElement = jsonArray[i];
        
        correctPassword = jsonElement[@"password"];
     
    }
    
    [self validatePassword:correctPassword];
    
    // Ready to notify delegate that data is ready and pass back items
}
@end
