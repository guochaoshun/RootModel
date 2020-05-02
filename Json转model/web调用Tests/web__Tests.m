//
//  web__Tests.m
//  web调用Tests
//
//  Created by 郭朝顺 on 2018/4/21星期六.
//  Copyright © 2018年 乐乐. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface web__Tests : XCTestCase

@end

@implementation web__Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    NSLog(@"============");

    NSArray * a = @[@"1",@"2",@"3"] ;
    for (NSString * s in a) {
        NSLog(@"%@",s);
    }

    NSLog(@"============");
    

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
