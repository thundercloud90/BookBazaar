//
//  PostDetailsViewController.m
//  BookBazaar
//
//  Created by Wade Wilkey on 16/11/2014.
//  Copyright (c) 2014 Wade Wilkey. All rights reserved.
//

#import "PostDetailsViewController.h"

@interface PostDetailsViewController ()

@end

@implementation PostDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _booknameLabel.text = _postObject.bookName;
    _authorLabel.text = _postObject.authorName;
    _isbnLabel.text = _postObject.isbnNum;
    _conditionLabel.text = _postObject.bookCondition;
    _priceLabel.text = _postObject.price;
    [self downloadItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)downloadItems
{
    //NSString * username = self.uNameTextField.text;
    NSString * query = [NSString stringWithFormat:@"http://67.182.205.14/cs3450/service.php?query=SELECT * FROM user WHERE id='%@'", _postObject.userID];
    NSString * stringURL = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *jsonFileUrl = [NSURL URLWithString:stringURL];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
}

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
    NSDictionary *jsonElement = jsonArray[0];
    

    _usernameLabel.text = jsonElement[@"username"];
    _cityLabel.text = jsonElement[@"city"];
    _phoneLabel.text = jsonElement[@"phoneNumber"];
    
}


@end
