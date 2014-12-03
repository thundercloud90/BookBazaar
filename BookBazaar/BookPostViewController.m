//
//  BookPostViewController.m
//  BookBazaar
//
//  Created by Wade Wilkey on 18/11/2014.
//  Copyright (c) 2014 Wade Wilkey. All rights reserved.
//

#import "BookPostViewController.h"

@interface BookPostViewController ()

@end

@implementation BookPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_successLabel setHidden:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)submitButton:(id)sender {
    bookName = _bookNameTF.text;
    isbnNum = _isbnNumTF.text;
    bookPrice = _bookPriceTF.text;
    bookCondition = _bookConditionTF.text;
    [self insertDBItems];
}

-(void)insertDBItems
{
    
    NSString * query = [NSString stringWithFormat:@"http://67.182.205.14/cs3450/postService.php?query=INSERT INTO post (userID, ISBN_num, bookName, bookCondition, bookPrice) VALUES ('%@', '%@', '%@', '%@', '%@')", globalUser.userID, isbnNum, bookName, bookCondition, bookPrice];
    NSString * stringURL = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *jsonFileUrl = [NSURL URLWithString:stringURL];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    NSLog(@"%@", stringURL);
}

#pragma mark NSURLConnectionDataProtocol Methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    dbReturnCode = [[NSMutableData alloc] init];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
   
        NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", output);
        if([output isEqualToString:@"Success!"])
        {
            [_successLabel setHidden:NO];
            _successLabel.text = @"Registration Successful";
        }
        

}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    

}
@end
