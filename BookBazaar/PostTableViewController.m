//
//  PostTableViewController.m
//  BookBazaar
//
//  Created by Wade Wilkey on 8/11/2014.
//  Copyright (c) 2014 Wade Wilkey. All rights reserved.
//

#import "PostTableViewController.h"

@interface PostTableViewController ()
{
    NSArray *listItems;
}

@end

@implementation PostTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    
    listItems = [[NSArray alloc] init];
    postInfo = [[NSMutableArray alloc] init];
    [self downloadItems];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return postInfo.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Configure the cell...
    
    NSString *cellIdentifier = @"BasicCell";
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    Post *post = postInfo[indexPath.row];
    NSString *price = [[NSString alloc] initWithString:@""];
    if([[post price] isEqual:[NSNull null]])
        {
            price = @"0";
        }
    else
    {
        price = [post price];
    }
    myCell.detailTextLabel.text = price;
    myCell.textLabel.text = [post bookName];
    NSLog(@"Here");
    return myCell;
    
}


- (void)downloadItems
{
    // Download the json file
      //  NSString * query = [NSString stringWithFormat:@"http://67.182.205.14/cs3450/user/post/"];
    //NSString * query = [NSString stringWithFormat:@"http://67.182.205.14/cs3450/service.php?query=SELECT * FROM post"];
    //NSString * query = [NSString stringWithFormat:@"http://67.182.205.14/cs3450/service.php?query=SELECT * FROM Postings INNER JOIN Books ON Books.ISBN=Postings.Books_ISBN"];
    
    
    NSString * query = [NSString stringWithFormat:@"http://67.182.205.14:3000/book/"];
    NSString * stringURL = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *jsonFileUrl = [NSURL URLWithString:stringURL];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:jsonFileUrl];
    urlRequest.HTTPMethod = @"GET";
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    


  /*
    NSString * query = [NSString stringWithFormat:@"http://67.182.205.14/cs3450/service.php?query=SELECT * FROM Postings INNER JOIN Books ON Books.ISBN=Postings.Books_ISBN"];
    NSString * stringURL = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *jsonFileUrl = [NSURL URLWithString:stringURL];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:jsonFileUrl];
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
   */
    
}


#pragma mark NSURLConnectionDataProtocol Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Initialize the data object
    _downloadedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the newly downloaded data
    [_downloadedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{

    NSError* localError;
    id bookObjects = [NSJSONSerialization JSONObjectWithData:_downloadedData
                                                            options:0
                                                              error:&localError];
    

    NSMutableArray* books = [[NSMutableArray alloc] init];
    for (NSDictionary* bookDict in bookObjects[@"books"]) {
        Post *newPost = [[Post alloc] init];
        newPost.bookName = bookDict[@"BookName"];
        newPost.authorName = bookDict[@"Author"];
        newPost.isbnNum = bookDict[@"Books_ISBN"];
        newPost.bookCondition = bookDict[@"Condition"];
        newPost.price = bookDict[@"Price"];

        [postInfo addObject:newPost];
    }
    
        [self.listTableView reloadData];

/*
    // Loop through Json objects, create question objects and add them to our questions array
    for (int i = 0; i < rtnArray.count; i++)
    {
        NSDictionary *jsonElement = rtnArray[i];

        
        Post *newPost = [[Post alloc] init];
       
        newPost.bookName = jsonElement[@"BookName"];
        newPost.authorName = jsonElement[@"Author"];
        //newPost.postID = jsonElement[@"postID"];
        newPost.isbnNum = jsonElement[@"Books_ISBN"];
        newPost.bookCondition = jsonElement[@"Condition"];
        //newPost.timestamp = jsonElement[@"timestamp"];
        newPost.price = jsonElement[@"Price"];
        //newPost.imagePath = jsonElement[@"imagePath"];
        //newPost.userID = jsonElement[@"userID"];
        /*
        newPost.bookName = jsonElement[@"bookName"];
        newPost.authorName = jsonElement[@"bookAuthor"];
        newPost.isbnNum = jsonElement[@"ISBN_num"];
        newPost.bookCondition = jsonElement[@"bookCondition"];
        newPost.price = jsonElement[@"bookPrice"];
        newPost.imagePath = jsonElement[@"imagePath"];
 

        
       [postInfo addObject:newPost];
    
    }

    
    // Reload the table view
    [self.listTableView reloadData];
    */
    
    /*  //Good!!!
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
    
    // Loop through Json objects, create question objects and add them to our questions array
    for (int i = 0; i < jsonArray.count; i++)
    {
        NSDictionary *jsonElement = jsonArray[i];
        
        
        Post *newPost = [[Post alloc] init];
        newPost.bookName = jsonElement[@"bookName"];
        newPost.authorName = jsonElement[@"bookAuthor"];
        //newPost.postID = jsonElement[@"postID"];
        newPost.isbnNum = jsonElement[@"ISBN_num"];
        newPost.bookCondition = jsonElement[@"bookCondition"];
        //newPost.timestamp = jsonElement[@"timestamp"];
        newPost.price = jsonElement[@"bookPrice"];
        newPost.imagePath = jsonElement[@"imagePath"];
        //newPost.userID = jsonElement[@"userID"];
        
        [postInfo addObject:newPost];
    }
    
    // Reload the table view
    [self.listTableView reloadData];
     */
    
    
}


-(void)fillData
{
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
     if([[segue identifier] isEqualToString:@"segue"])
     {
         NSIndexPath *path = [self.tableView indexPathForSelectedRow];
         PostDetailsViewController *vc;
         vc = [segue destinationViewController];
         NSLog(@"%ld", (long)path.row);
         Post *postObj = postInfo[path.row];
        
         vc.postObject = postObj;
         NSLog(@"Segue");
     }

     else{
         NSLog(@"%@", @"error");
     }
     
     
 }


@end
