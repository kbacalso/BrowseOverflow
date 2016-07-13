//
//  StackOverflowManager.m
//  BrowseOverflow
//
//  Created by taki bacalso on 01/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import "StackOverflowManager.h"
#import "StackOverflowManagerDelegate.h"
#import "Topic.h"
#import "MockStackOverflowCommunicator.h"
#import "QuestionBuilder.h"
#import "Question.h"

NSString *StackOverflowManagerError = @"StackOverflowManagerError";
NSString *StackOverflowManagerSearchFailedError = @"StackOverflowManagerSearchFailedError";

@implementation StackOverflowManager

- (void)setDelegate:(id<StackOverflowManagerDelegate>)newDelegate
{
    if (newDelegate &&
        ![newDelegate conformsToProtocol:@protocol(StackOverflowManagerDelegate)]) {
        [[NSException exceptionWithName:NSInvalidArgumentException
                                 reason:@"Delegate object does not conform to the delegate protocol" 
                               userInfo:nil]
         raise];
    }
    
    _delegate = newDelegate;
}

- (void)fetchQuestionsOnTopic:(Topic *)topic
{
    [_communicator searchForQuestionsWithTag:[topic tag]];
}

- (void)searchingForQuestionsFailedWithError:(NSError *)error
{
    NSDictionary *errorInfo = [NSDictionary dictionaryWithObject:error forKey:NSUnderlyingErrorKey];
    
    NSError *reportableError = [NSError errorWithDomain:StackOverflowManagerError
                                                   code:StackOverflowManagerErrorQuestionSearchCode
                                               userInfo:errorInfo];
    
    [_delegate fetchingQuestionsFailedWithError:reportableError];
}

- (void)receivedQuestionsJSON:(NSString *)objectNotation
{
    NSError *error = nil;
    NSArray *questions = [self.questionBuilder questionsFromJSON:objectNotation error:&error];
    
    if (!questions) {
        
        NSDictionary *errorInfo = nil;
        
        if (error) {
            errorInfo = [NSDictionary dictionaryWithObject:error forKey:NSUnderlyingErrorKey];
        }
        
        NSError *reportableError = [NSError errorWithDomain:StackOverflowManagerSearchFailedError
                                                       code:StackOverflowManagerErrorQuestionSearchCode
                                                   userInfo:errorInfo];
        
        [_delegate fetchingQuestionsFailedWithError:reportableError];
        
    } else {
        
        [_delegate didReceiveQuestions:questions];
        
    }
}

- (void)fetchBodyForQuestion:(Question *)question
{
    self.questionNeedingBody = question;
    [_communicator fetchQuestionBodyWithID:[question questionID]];
}

- (void)fetchingQuestionBodyFailedWithError:(NSError *)error
{
    NSDictionary *errorInfo = [NSDictionary dictionaryWithObject:error forKey:NSUnderlyingErrorKey];
    
    NSError *reportableError = [NSError errorWithDomain:StackOverflowManagerError
                                                   code:StackOverflowManagerErrorQuestionFetchBodyCode
                                               userInfo:errorInfo];
    
    [_delegate fetchingQuestionBodyFailedWithError:reportableError];
}

- (void)receivedQuestionBodyJSON:(NSString *)objectNotation
{
    [_questionBuilder fillInDetailsForQuestion:self.questionNeedingBody fromJSON:objectNotation];
    self.questionNeedingBody = nil;
}

@end
