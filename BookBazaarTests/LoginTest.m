//
//  LoginTest.m
//  BookBazaar
//
//  Created by Wade Wilkey on 18/11/2014.
//  Copyright (c) 2014 Wade Wilkey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "LoginViewController.h"

@interface LoginTest : XCTestCase

@end

@implementation LoginTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLogin {
    NSString *username = @"papajoe";
    NSString *password = @"joejoe";
    LoginViewController *lvc;
    [lvc downloadItems:username];
    
    

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


@end
