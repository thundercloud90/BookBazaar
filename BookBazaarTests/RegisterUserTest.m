//
//  RegisterUserTest.m
//  BookBazaar
//
//  Created by Wade Wilkey on 6/12/2014.
//  Copyright (c) 2014 Wade Wilkey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "RegisterViewController.h"

@interface RegisterUserTest : XCTestCase

@end

@implementation RegisterUserTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRegister {
    NSString *firstName = @"Test";
    NSString *lastName = @"Test";
    NSString *emailAddr = @"test@test.com";
    NSString *phoneNum = @"0000000000";
    NSString *city = @"testCity";
    NSString *state = @"testState";
    NSString *zipcode = @"00000";
    NSString *password = @"testPW";
    
    NSArray *testArr = [[NSArray alloc] initWithObjects:firstName, lastName, emailAddr, phoneNum, city, state, zipcode, password, nil];
    
    RegisterViewController *rvc;
    NSString *rc = [rvc insertItems:testArr];
    XCTAssertEqual(rc, @"Success", @"Should return 'Success'");
    
   
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
