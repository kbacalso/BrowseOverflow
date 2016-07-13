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
@"\"items\":["
@"{"
@"    \"tags\":["
@"            \"iphone\","
@"            \"uitextfield\""
@"            ],"
@"    \"owner\":{"
@"        \"reputation\":19499,"
@"        \"user_id\":343204,"
@"        \"user_type\":\"registered\","
@"        \"accept_rate\":49,"
@"        \"profile_image\":\"https://www.gravatar.com/avatar/8679514f8cdfd0c077fc6c242cda8882?s=128&d=identicon&r=PG\","
@"        \"display_name\":\"Snow Crash\","
@"        \"link\":\"http://stackoverflow.com/users/343204/snow-crash\""
@"    },"
@"    \"is_answered\":true,"
@"    \"view_count\":28886,"
@"    \"accepted_answer_id\":8532938,"
@"    \"answer_count\":8,"
@"    \"score\":19,"
@"    \"last_activity_date\":1468320890,"
@"    \"creation_date\":1324031474,"
@"    \"question_id\":8532874,"
@"    \"link\":\"http://stackoverflow.com/questions/8532874/clear-uitextfield-placeholder-text-on-tap\","
@"    \"title\":\"Clear UITextField Placeholder text on tap\","
@"    \"body\":\"<p>I've been trying to use persistent keychain references. </p>\""
@"}"
@"],"
@"\"has_more\":true,"
@"\"quota_max\":300,"
@"\"quota_remaining\":292"
@"}";

static NSString *stringIsNotJSON = @"Fake JSON";

static NSString *noQuestionsJSONString = @"{}";




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
                   8532874,
                   @"The question ID should match the data we sent");
    
    XCTAssertEqual([question.date timeIntervalSince1970],
                   (NSTimeInterval)1324031474,
                   @"The date of the question should match the data");
    
    XCTAssertEqualObjects(question.title,
                          @"Clear UITextField Placeholder text on tap",
                          @"Title should match the provided data");
    
    XCTAssertEqual(question.score,
                   19,
                   @"Score should match the data");
    
    Person *asker = question.asker;
    
    XCTAssertEqualObjects(asker.name,
                          @"Snow Crash",
                          @"Looks like Snow Crash should have asked this question");
    
    XCTAssertEqualObjects([asker.avatarURL absoluteString],
                          @"https://www.gravatar.com/avatar/8679514f8cdfd0c077fc6c242cda8882?s=128&d=identicon&r=PG",
                          @"The avatar URL should match the provided data");
}

- (void)testQuestionCreatedFromEmptyObjectIsStillValidObject
{
    NSString *emptyQuestion = @"{ \"items\": [{}] }";
    NSArray *questions = [questionBuilder questionsFromJSON:emptyQuestion
                                                      error:NULL];
    XCTAssertEqual([questions count],
                   (NSUInteger)1,
                   @"QuestionBuilder must handle partial input");
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
    [questionBuilder fillInDetailsForQuestion:question
                                     fromJSON:stringIsNotJSON];
    XCTAssertNil(question.body, @"Body should not have been added");
}

- (void)testJSONWhichDoesNotContainABodyDoesNotCauseBodyToBeAdded
{
    [questionBuilder fillInDetailsForQuestion:question
                                     fromJSON:noQuestionsJSONString];
    XCTAssertNil(question.body, @"There was no body to add");
}

- (void)testBodyContainedInJSONIsAddedToQuestion
{
    [questionBuilder fillInDetailsForQuestion:question
                                     fromJSON:questionJSON];
    
    XCTAssertEqualObjects(question.body,
                          @"<p>I've been trying to use persistent keychain references. </p>",
                          @"The correct question body is added");
}

@end
