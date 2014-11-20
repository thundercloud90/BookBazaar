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
}

-(void)insertDBItems
{
    NSString * query = [NSString stringWithFormat:@""];
    NSString * stringURL = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *jsonFileUrl = [NSURL URLWithString:stringURL];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    /*
    if(submitClicked)
    {
        NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", output);
        if([output isEqualToString:@"Success!"])
        {
            [_successLabel setHidden:NO];
            _successLabel.text = @"Registration Successful";
        }
        
    }
     */
    

}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    // Parse the JSON that came in
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:dbReturnCode options:NSJSONReadingAllowFragments error:&error];
    
    // Loop through Json objects, create question objects and add them to our questions array
    if(jsonArray.count > 0)
    {
        
    }
    
    
    
    // Ready to notify delegate that data is ready and pass back items
}
@end
