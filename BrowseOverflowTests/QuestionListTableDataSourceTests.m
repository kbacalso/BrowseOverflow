//
//  QuestionListTableDataSourceTests.m
//  BrowseOverflow
//
//  Created by taki bacalso on 15/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Question.h"
#import "QuestionListTableDataSource.h"
#import "Person.h"
#import "Topic.h"


@interface QuestionListTableDataSourceTests : XCTestCase

@end

@implementation QuestionListTableDataSourceTests
{
    QuestionListTableDataSource *dataSource;
    Topic *iPhoneTopic;
    NSIndexPath *firstCell;
    Question *question1, *question2;
    Person *asker1;
    UITableView *tableView;
}

- (void)setUp
{
    dataSource = [[QuestionListTableDataSource alloc] init];
    iPhoneTopic = [[Topic alloc] initWithName:@"iPhone"
                                          tag:@"iphone"];
    dataSource.topic = iPhoneTopic;
    firstCell = [NSIndexPath indexPathForRow:0 inSection:0];
    
    question1 = [[Question alloc] init];
    question1.title = @"Question One";
    question1.score = 2;
    
    question2 = [[Question alloc] init];
    question2.title = @"Question Two";
    
    asker1 = [[Person alloc] initWithName:@"Graham Lee"
                           avatarLocation:@"https://www.gravatar.com/avatar/8679514f8cdfd0c077fc6c242cda8882?s=128&d=identicon&r=PG\\"];
    question1.asker = asker1;
    
    tableView = [[UITableView alloc] init];
    tableView.dataSource = dataSource;
    tableView.delegate = dataSource;
}

- (void)tearDown
{
    dataSource = nil;
    iPhoneTopic = nil;
    firstCell = nil;
    question1 = nil;
    question2 = nil;
    asker1 = nil;
    tableView = nil;
}

//- (void)testTopicWithNoQuestionsLeadsToOneRowInTheTable
//{
//    XCTAssertEqual([dataSource tableView:tableView numberOfRowsInSection:0],
//                   (NSInteger)2,
//                   @"Two questions in the topic means two rows in the table");
//}

//- (void)testTopicWithQuestionsResultsInOneRowPerQuestionInTheTable
//{
//    [iPhoneTopic addQuestion:question1];
//    [iPhoneTopic addQuestion:question2];
//    
//    XCTAssertEqual([dataSource tableView:tableView numberOfRowsInSection:0],
//                   (NSInteger)2,
//                   @"Two questions in the topic means two rows in the table");
//}

//- (void)testContentOfPlaceholderCell
//{
//    UITableViewCell *placeholderCell = [dataSource tableView:tableView
//                                       cellForRowAtIndexPath:firstCell];
//    
//    XCTAssertEqualObjects(placeholderCell.textLabel.text,
//                          @"There was a problem connecting to the network",
//                          @"The placeholder cell ought to display a placeholder message");
//}

//- (void)testPlaceholderCellNotReturnedWhenQuestionsExist
//{
//    [iPhoneTopic addQuestion:question1];
//    
//    UITableViewCell *cell = [dataSource tableView:tableView cellForRowAtIndexPath:firstCell];
//    
//    XCTAssertFalse([cell.textLabel.text isEqualToString:@"There was a problem connecting to the network."],
//                   @"Placeholder should only be shown when there's no content");
//}

//- (void)testCellPropertiesAreTheSameAsTheQuestion
//{
//    [iPhoneTopic addQuestion:question1];
//    
//    QuestionSummaryCell *cell = (QuestionSummaryCell *)[dataSource tableView:tableView cellForRowAtIndexPath:firstCell];
//    
//    XCTAssertEqualObjects(cell.titleLabel.text,
//                          @"Question One",
//                          @"Question cells display the question's title");
//    
//    XCTAssertEqualObjects(cell.scoreLabel.text,
//                          @"2",
//                          @"Question cells display the question's score");
//    
//    XCTAssertEqualObjects(cell.nameLabel.text,
//                          @"Graham Lee",
//                          @"Question cells display the asker's name");
//}

@end
