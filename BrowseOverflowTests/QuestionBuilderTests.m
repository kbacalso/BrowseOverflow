//
//  QuestionBuilderTests.m
//  BrowseOverflow
//
//  Created by taki bacalso on 07/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "QuestionBuilder.h"
#import "Question.h"
#import "Person.h"

static NSString *questionJSON = @"{"
@"items: ["
@"{"
@"tags: ["
@"       \"ios\","
@"       \"iphone\","
@"       \"xcode\","
@"       \"swift\","
@"       \"ipad\""
@"       ],"
@"owner: {"
@"reputation: 509,"
@"user_id: 3468651,"
@"user_type: \"registered\","
@"accept_rate: 50,"
@"profile_image: \"https://i.stack.imgur.com/VCLH7.png?s=128&g=1\","
@"display_name: \"Taki\","
@"link: \"http://stackoverflow.com/users/3468651/oleshko\""
@"},"
@"is_answered: true,"
@"view_count: 8666,"
@"accepted_answer_id: 25973816,"
@"answer_count: 3,"
@"score: 18,"
@"last_activity_date: 1467881052,"
@"creation_date: 1411387529,"
@"last_edit_date: 1467881052,"
@"question_id: 25973733,"
@"link: \"http://stackoverflow.com/questions/25973733/status-bar-height-in-swift\","
@"title: \"Status bar height in swift\""
@"}"
@"        ],"
@"has_more: true,"
@"quota_max: 300,"
@"quota_remaining: 287"
@"}";


@interface QuestionBuilderTests : XCTestCase

@end

@implementation QuestionBuilderTests
{
    QuestionBuilder *questionBuilder;
    Question *question;
}

- (void)setUp
{
    questionBuilder = [[QuestionBuilder alloc] init];
    question = [[questionBuilder questionsFromJSON:questionJSON
                                             error:NULL] objectAtIndex:0];
}

- (void)tearDown
{
    questionBuilder = nil;
    question = nil;
}

- (void)testThatNilIsNotAnAcceptableParameter
{
    XCTAssertThrows([questionBuilder questionsFromJSON:nil error:NULL],
                    @"Lack of data should have been handled elsewhere");
}

- (void)testNilReturnedWhenStringIsNotJSON
{
    XCTAssertNil([questionBuilder questionsFromJSON:@"Not JSON" error:NULL],
                 @"This parameter should not be parsable");
}

- (void)testErrorSetWhenStringIsNotJSON
{
    NSError *error = nil;
    [questionBuilder questionsFromJSON:@"Not JSON" error:&error];
    XCTAssertNotNil(error, @"An error occured, we should be told");
}

- (void)testPassingNullErrorDoesNotCauseCrash
{
    XCTAssertNoThrow([questionBuilder questionsFromJSON:@"Not JSON" error:NULL],
                     @"Using a NULL error parameter should not be a prroblem");
}

- (void)testRealJSONWithoutQuestionsArrayIsError
{
    NSString *jsonString = @"{ \"noquestions\" :  true }";
    XCTAssertNil([questionBuilder questionsFromJSON:jsonString error:NULL],
                 @"No questions to parse in this JSON");
}

- (void)testRealJSONWithoutQuestionsReturnsMissingDataError
{
    NSString *jsonString = @"{ \"noquestions\": true }";
    NSError *error = nil;
    [questionBuilder questionsFromJSON:jsonString error:&error];
    XCTAssertEqual([error code], QuestionBuilderMissingDataError,
                   @"This case should not be an invalid JSON error");
}

- (void)testJSONWithOneQuestionReturnsOneQuestionObject
{
    NSError *error = nil;
    NSArray *questions = [questionBuilder questionsFromJSON:questionJSON error:&error];
    XCTAssertEqual([questions count], (NSUInteger)1, @"The builder should have created a question");
}

- (void)testQuestionCreatedFromJSONHasPropertiesPresentedInJSON
{
    XCTAssertEqual(question.questionID,
                   25973733,
                   @"The question ID should match the data we sent");
    
    XCTAssertEqual([question.date timeIntervalSince1970],
                   (NSTimeInterval)1411387529,
                   @"The date of the question should match the data");
    
    XCTAssertEqualObjects(question.title,
                          @"Status bar height in swift",
                          @"Title should match the provided data");
    
    XCTAssertEqual(question.score,
                   18,
                   @"Score should match the data");
    
    Person *asker = question.maker;
    
    XCTAssertEqualObjects([asker.avatarURL absoluteString],
                          @"Taki",
                          @"Looks like I should have asked this question");
    
    XCTAssertEqualObjects([asker.avatarURL absoluteString],
                          @"https://i.stack.imgur.com/VCLH7.png?s=128&g=1\\",
                          @"The avatar URL should match the provided data");
}

- (void)testBuildingQuestionBodyWithNoDataCannotBeTried
{
    XCTAssertThrows([questionBuilder fillInDetailsForQuestion:question fromJSON:nil],
                    @"Not receiving data should have been handled earlier");
}

- (void)testBuildingQuestionBodyWithNoQuestionCannotBeTried
{
    XCTAssertThrows([questionBuilder fillInDetailsForQuestion:nil fromJSON:questionJSON],
                    @"No reason to expect that a nil question is passed");
}

- (void)testNonJSONDataDoesNotCauseABodyToBeAddedToAQuestion
{
    [questionBuilder fillInDetailsForQuestion:question fromJSON:stringIsNotJSON];
    XCTAssertNil(question.body, @"Body should not have been added");
}

- (void)testJSONWhichDoesNotContainABodyDoesNotCauseBodyToBeAdded
{
    [questionBuilder fillInDetailsForQuestion:question fromJSON:noQuestionsJSONString];
    XCTAssertNil(question.body, @"There was no body to add");
}

- (void)testBodyContainedInJSONIsAddedToQuestion
{
    [questionBuilder fillInDetailsForQuestion:question
                                     fromJSON:questionJSON];
    
    XCTAssertEqualObjects(question.body,
                          @"<p>I've been tr",
                          @"The correct question body is added");
}

@end
