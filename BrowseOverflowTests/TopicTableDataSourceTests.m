//
//  TopicTableDataSourceTests.m
//  BrowseOverflow
//
//  Created by Taki Bacalso on 14/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TopicTableDataSource.h"
#import "Topic.h"

@interface TopicTableDataSourceTests : XCTestCase

@end

@implementation TopicTableDataSourceTests
{
    TopicTableDataSource *dataSource;
    NSArray *topicsList;
    UITableView *tableView;
}

- (void)setUp
{
    tableView = [[UITableView alloc] init];
    dataSource = [[TopicTableDataSource alloc] init];
    tableView.dataSource = dataSource;
    
    Topic *sampleTopic = [[Topic alloc] initWithName:@"iPhone"
                                                 tag:@"iphone"];
    
    topicsList = [NSArray arrayWithObject:sampleTopic];
    [dataSource setTopics:topicsList];
}

- (void)tearDown
{
    dataSource = nil;
    topicsList = nil;
}

- (void)testOneTableRowForOneTopic
{
    XCTAssertEqual((NSInteger)[topicsList count],
                   [dataSource tableView:tableView numberOfRowsInSection:0],
                   @"As there's one topic, there should be one row in the table");
}

- (void)testTwoTableRowsForTwoTopics
{
    Topic *topic1 = [[Topic alloc] initWithName:@"Mac OS X"
                                            tag:@"macosx"];
    
    Topic *topic2 = [[Topic alloc] initWithName:@"Cocoa" tag:@"cocoa"];
    
    NSArray *twoTopicsList = [NSArray arrayWithObjects:topic1, topic2, nil];
    [dataSource setTopics:twoTopicsList];
    
    XCTAssertEqual((NSInteger)[twoTopicsList count],
                   [dataSource tableView:tableView numberOfRowsInSection:0],
                   @"There should be two row in the table for two topics");
}

- (void)testOneSectionInTheTableView
{
    XCTAssertThrows([dataSource tableView:tableView numberOfRowsInSection:1],
                    @"Data source doesn't allow asking about additional sections");
}

- (void)testDataSourceCellCreationExpectsOneSection
{
    NSIndexPath *secondSection = [NSIndexPath indexPathForRow:0 inSection:1];
    XCTAssertThrows([dataSource tableView:tableView
                    cellForRowAtIndexPath:secondSection],
                    @"Data source will not prepare cells for unexpected sections");
}

- (void)testDataSourceCellCreationWillNotCreateMoreRowsThanItHasTopics
{
    NSIndexPath *afterLastTopic = [NSIndexPath indexPathForRow:[topicsList count]
                                                     inSection:0];
    
    XCTAssertThrows([dataSource tableView:tableView cellForRowAtIndexPath:afterLastTopic],
                    @"Data source will not prepare more cells than there are topics");
}

- (void)testCellCreatedByDataSourceContainsTopicTitleAsTextLabel
{
    NSIndexPath *firstTopic = [NSIndexPath indexPathForRow:0
                                                 inSection:0];
    
    UITableViewCell *firstCell = [dataSource tableView:tableView
                                 cellForRowAtIndexPath:firstTopic];
    
    NSString *cellTitle = firstCell.textLabel.text;
    
    XCTAssertEqualObjects(@"iPhone",
                          cellTitle,
                          @"Cell's title should be equal to the topic's title");
}

- (void)testDataSourceIndicatesWhichTopicIsRepresentedForAnIndexPath
{
    NSIndexPath *firstRow = [NSIndexPath indexPathForRow:0
                                               inSection:0];
    
    Topic *firstTopic = [dataSource topicForIndexPath:firstRow];
    
    XCTAssertEqualObjects(firstTopic.tag,
                          @"iphone",
                          @"The iPhone Topic is at row 0");
}

@end
