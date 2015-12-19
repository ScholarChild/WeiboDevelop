//
//  WeiboDevelopTests.m
//  WeiboDevelopTests
//
//  Created by Ibokan on 15/12/2.
//  Copyright (c) 2015年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "WBDate.h"
#import "EmoticonTransfer.h"
#import "NSObject+UnicodeDestribution.h"

@interface WeiboDevelopTests : XCTestCase

@end

@implementation WeiboDevelopTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    EmoticonTransfer* transfer = [EmoticonTransfer shareTransfer];
    NSArray* groupNames = [transfer getAllImageEmoticonGroupName];
    for (NSString* groupName in groupNames) {
        NSDictionary* group = [transfer getImagaEmoticonListWithGroupName:groupName];
        NSArray* allCode = [group allKeys];
        NSLog(@"-------------------");
        for (NSString* code in allCode) {
            NSString* imageName = [transfer imageEmojiNamewithCode:code];
            UIImage* image = [UIImage imageNamed:imageName];
            NSLog(@"%@",image);
        }
    }
    NSLog(@"-------------------");
}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

@end
