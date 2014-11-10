//
//  DBConnection.m
//  BookBazaar
//
//  Created by Wade Wilkey on 31/10/2014.
//  Copyright (c) 2014 Wade Wilkey. All rights reserved.
//

#import "DBConnection.h"


@interface DataModel()
{
    NSMutableData *_downloadedData;
    NSString *username;
    NSString *password;
}
@end

@implementation DataModel

- (void)downloadItems
{
    // Download the json file
    NSString * query = [NSString stringWithFormat:@"http://67.182.205.14/cs3450/service.php?query=SELECT * FROM user"];
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
    // Create an array to store the locations
    NSMutableArray *_user = [[NSMutableArray alloc] init];
    
    // Parse the JSON that came in
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
    
    // Loop through Json objects, create question objects and add them to our questions array
    for (int i = 0; i < jsonArray.count; i++)
    {
        NSDictionary *jsonElement = jsonArray[i];
        
        UserClass *userinfo = [[UserClass alloc] init];
        userinfo.firstName = jsonElement[@"firstName"];
        userinfo.lastName = jsonElement[@"lastName"];
        userinfo.username = jsonElement[@"username"];
        userinfo.emailAddr = jsonElement[@"emailAddr"];
        userinfo.phoneNumber = jsonElement[@"phoneNumber"];
        userinfo.city = jsonElement[@"city"];
        userinfo.state = jsonElement[@"state"];
        
        [_user addObject:userinfo];
    }
    
    // Ready to notify delegate that data is ready and pass back items
    if (self.delegate)
    {
        [self.delegate itemsDownloaded:_user];
    }
}

@end