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
    author = _authorTF.text;
    bookCondition = _bookConditionTF.text;
    
    [self insertDBItems];
    
}

-(void)insertDBItems
{
    
    NSString * query = [NSString stringWithFormat:@"http://67.182.205.14/cs3450/postService.php?query=INSERT INTO post (PhoneNum, ISBN_num, bookName, bookCondition, bookPrice, bookAuthor) VALUES ('%@', '%@', '%@', '%@', '%@', '%@')", globalUser.phoneNumber, isbnNum, bookName, bookCondition, bookPrice, author];
    NSString * stringURL = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *jsonFileUrl = [NSURL URLWithString:stringURL];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    NSLog(@"%@", stringURL);
     
    /*
    NSString * query = [NSString stringWithFormat:@"http://67.182.205.14/cs3450/postService.php?query=INSERT INTO Books (ISBN, BookName, Author, Edition) VALUES ('%@', '%@', '%@', '%@')", isbnNum, bookName, author, @""];
    NSString * stringURL = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *jsonFileUrl = [NSURL URLWithString:stringURL];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    NSLog(@"%@", stringURL);
    
    NSString * queryPost = [NSString stringWithFormat:@"http://67.182.205.14/cs3450/postService.php?query=INSERT INTO Postings (Books_ISBN, Price, User_PhoneNum) VALUES ('%@', '%@', '%@')", isbnNum, bookPrice, globalUser.phoneNumber];
    NSString * stringURLPost = [queryPost stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *jsonFileUrlPost = [NSURL URLWithString:stringURLPost];
    NSURLRequest *urlRequestPost = [[NSURLRequest alloc] initWithURL:jsonFileUrlPost];
    [NSURLConnection connectionWithRequest:urlRequestPost delegate:self];
    NSLog(@"%@", stringURLPost);
     */

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
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Book Bazaar"
                                                            message:@"Posted Successfully"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil
                                  ,nil];
            [alert show];
            [self.navigationController popViewControllerAnimated:TRUE];

        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Book Bazaar"
                                                            message:@"Post Failed"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil
                                  ,nil];
            [alert show];
        }
        

}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    

}
@end
