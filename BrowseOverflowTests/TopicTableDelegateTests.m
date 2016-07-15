//
//  TopicTableDelegateTests.m
//  BrowseOverflow
//
//  Created by Taki Bacalso on 14/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TopicTableDataSource.h"
#import "Topic.h"

@interface TopicTableDelegateTests : XCTestCase

@end

@implementation TopicTableDelegateTests
{
    NSNotification          *receivedNotification;
    TopicTableDataSource    *dataSource;
    Topic                   *iPhoneTopic;
    UITableView             *tableView;
}

- (void)setUp
{
    dataSource = [[TopicTableDataSource alloc] init];
    iPhoneTopic = [[Topic alloc] initWithName:@"iPhone"
                                          tag:@"iphone"];
    
    tableView = [[UITableView alloc] init];
    tableView.dataSource = dataSource;
    
    [dataSource setTopics:[NSArray arrayWithObject:iPhoneTopic]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveNotification:)
                                                 name:TopicTableDidSelectTopicNotification
                                               object:nil];
}

- (void)tearDown
{
    receivedNotification = nil;
    dataSource = nil;
    iPhoneTopic = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveNotification:(NSNotification *)note
{
    receivedNotification = note;
}

- (void)testDelegatePostsNotificationOnSelectionShowingWhichTopicWasSelected
{
    NSIndexPath *selection = [NSIndexPath indexPathForRow:0 inSection:0];
    [dataSource tableView:tableView didSelectRowAtIndexPath:selection];
    
    XCTAssertEqualObjects([receivedNotification name],
                          @"TopicTableDidSelectTopicNotification",
                          @"The delegate should notify that a topic was selected");
    
    XCTAssertEqualObjects([receivedNotification object],
                          iPhoneTopic,
                          @"The notification should indicate which topic was selected");
}


@end
