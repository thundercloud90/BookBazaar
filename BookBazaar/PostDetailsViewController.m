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
    NSLog(@"%@", _postObject.isbnNum);
    _booknameLabel.text = _postObject.bookName;
    _authorLabel.text = _postObject.authorName;
    _isbnLabel.text = _postObject.isbnNum;
    _conditionLabel.text = _postObject.bookCondition;
    _priceLabel.text = _postObject.price;
    [_activityIndic startAnimating];
    [self downloadItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)downloadItems
{
    //NSString * username = self.uNameTextField.text;
    NSString * query = [NSString stringWithFormat:@"http://67.182.205.14/cs3450/service.php?query=SELECT * FROM Users JOIN Postings ON Users.PhoneNum=Postings.User_PhoneNum JOIN Books ON Postings.Books_ISBN=Books.ISBN WHERE Books.ISBN='%@'", _postObject.isbnNum];
    //NSString * query = [NSString stringWithFormat:@"http://67.182.205.14/cs3450/service.php?query=SELECT * FROM user WHERE id='%@'", _postObject.userID];
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
    
    _usernameLabel.text = jsonElement[@"UsersName"];
    _cityLabel.text = jsonElement[@"City"];
    _phoneLabel.text = jsonElement[@"PhoneNum"];
    _emailLabel.text = jsonElement[@"Email"];
    
    //[self imageThread];
   
    

}

-(void)imageThread
{
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //Call your function or whatever work that needs to be done
        //Code in this part is run on a background thread
        /*
        if([_postObject.imagePath isEqual:nil])
        {
            [self bookImage].image = [UIImage imageNamed:@"ina.png"];
        }
        else{
         */
         NSData* imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://67.182.205.14/cs3450/bookImages/%@", _postObject.imagePath]]];
        
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            
            //Stop your activity indicator or anything else with the GUI
            //Code here is run on the main thread
            [self bookImage].image = [[UIImage alloc] initWithData:imageData];
            [_activityIndic stopAnimating];
            
        });
    });
}


@end
