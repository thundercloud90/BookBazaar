//
//  ViewController.m
//  BookBazaar
//
//  Created by Wade Wilkey on 9/10/2014.
//  Copyright (c) 2014 Wade Wilkey. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    globalUser = [[UserClass alloc] init];

    [_postBookButton setHidden:YES];
    [_managePostButton setHidden:YES];
    

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    if(isLoggedIn)
    {
        [_postBookButton setHidden:NO];
    }
    
    if(isAdmin)
    {
        [_managePostButton setHidden:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
