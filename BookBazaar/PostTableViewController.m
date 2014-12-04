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

    myCell.detailTextLabel.text = [post price];
    myCell.textLabel.text = [post bookName];
    
    return myCell;
    
}


- (void)downloadItems
{
    // Download the json file
    NSString * query = [NSString stringWithFormat:@"http://67.182.205.14/cs3450/service.php?query=SELECT * FROM post"];
    NSString * stringURL = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *jsonFileUrl = [NSURL URLWithString:stringURL];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    
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
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
    
    // Loop through Json objects, create question objects and add them to our questions array
    for (int i = 0; i < jsonArray.count; i++)
    {
        NSDictionary *jsonElement = jsonArray[i];

        
        Post *newPost = [[Post alloc] init];
        newPost.bookName = jsonElement[@"bookName"];
        newPost.authorName = jsonElement[@"bookAuthor"];
        newPost.postID = jsonElement[@"postID"];
        newPost.isbnNum = jsonElement[@"ISBN_num"];
        newPost.bookCondition = jsonElement[@"bookCondition"];
        newPost.timestamp = jsonElement[@"timestamp"];
        newPost.price = jsonElement[@"bookPrice"];
        newPost.imagePath = jsonElement[@"imagePath"];
        newPost.userID = jsonElement[@"userID"];
        
        [postInfo addObject:newPost];
    }
    
    // Reload the table view
    [self.listTableView reloadData];
    
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
     if([[segue identifier] isEqualToString:@"segue"])
     {
         NSIndexPath *path = [self.tableView indexPathForSelectedRow];
         PostDetailsViewController *vc;
         vc = [segue destinationViewController];
        
         Post *postObj = postInfo[path.row];
         vc.postObject = postObj;
     }

     else{
         NSLog(@"%@", @"error");
     }
     
     
 }


@end
