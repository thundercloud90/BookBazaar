//
//  ManagePostsTableView.m
//  BookBazaar
//
//  Created by Wade Wilkey on 3/12/2014.
//  Copyright (c) 2014 Wade Wilkey. All rights reserved.
//

#import "ManagePostsTableView.h"

@interface ManagePostsTableView ()

@end

@implementation ManagePostsTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    
    postInfo = [[NSMutableArray alloc] init];

    
    [self downloadItems];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return postInfo.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    row=[indexPath row];
}

- (void)downloadItems
{
    // Download the json file
    //NSString * query = [NSString stringWithFormat:@"http://67.182.205.14/cs3450/service.php?query=SELECT * FROM post FULL JOIN user ON post.userID=user.id WHERE user.id='%@'", ];
    //NSString * query = [NSString stringWithFormat:@"http://67.182.205.14/cs3450/service.php?query=SELECT * FROM post"];
    NSString * query = [NSString stringWithFormat:@"http://67.182.205.14/cs3450/service.php?query=SELECT * FROM Postings INNER JOIN Books ON Postings.Books_ISBN=Books.ISBN"];

    NSString * stringURL = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *jsonFileUrl = [NSURL URLWithString:stringURL];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
}

- (void)removeItemFromDB:(NSString *)deletePostISBN
{
    //NSString * query = [NSString stringWithFormat:@"http://67.182.205.14/cs3450/service.php?query=DELETE FROM post WHERE postID='%@'", deletePostID];
    NSString * query = [NSString stringWithFormat:@"http://67.182.205.14/cs3450/service.php?query=DELETE FROM Postings WHERE Book_ISBN='%@'", deletePostISBN];

    NSString * stringURL = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *jsonFileUrl = [NSURL URLWithString:stringURL];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
}


#pragma mark NSURLConnectionDataProtocol Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Initialize the data object
    downloadedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the newly downloaded data
    [downloadedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:downloadedData options:NSJSONReadingAllowFragments error:&error];
    
    for (int i = 0; i < jsonArray.count; i++)
    {
        NSDictionary *jsonElement = jsonArray[i];
        /*
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
        */
        
        Post *newPost = [[Post alloc] init];
        newPost.bookName = jsonElement[@"BookName"];
        newPost.authorName = jsonElement[@"BookAuthor"];
        newPost.isbnNum = jsonElement[@"ISBN"];
        newPost.bookCondition = jsonElement[@"Condition"];
        newPost.price = jsonElement[@"Price"];
        newPost.imagePath = jsonElement[@"FileName"];
        
        [postInfo addObject:newPost];
    }
    
    // Reload the table view
    [self.listTableView reloadData];
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

    Post *post = postInfo[indexPath.row];
    NSString *detailStr = [[NSString alloc] initWithFormat:@"UserID: %@", post.bookName ];
    myCell.detailTextLabel.text = detailStr;
    myCell.textLabel.text = [post bookName];
    
    return myCell;
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        _pathToDelete = indexPath;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete Post"
                                                        message:@"Are you sure you want to proceed?"
                                                       delegate:nil
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK"
                                                ,nil];
        [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
        
        [alert show];
        Post *deletePost = [postInfo objectAtIndex:indexPath.row];
        NSString *deletedPostID = deletePost.isbnNum;
         [postInfo removeObjectAtIndex:indexPath.row];
        [self removeItemFromDB:deletedPostID];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if ([title isEqualToString:@"Cancel"]){
        [self.tableView reloadRowsAtIndexPaths:@[self.pathToDelete] withRowAnimation:UITableViewRowAnimationAutomatic];
    }else{
        
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
