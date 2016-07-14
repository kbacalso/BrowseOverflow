//
//  StackOverflowManager.h
//  BrowseOverflow
//
//  Created by taki bacalso on 01/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowCommunicatorDelegate.h"

extern NSString *StackOverflowManagerError;
extern NSString *StackOverflowManagerSearchFailedError;

enum {
    StackOverflowManagerErrorQuestionSearchCode,
    StackOverflowManagerErrorQuestionFetchBodyCode,
};

@class Topic;
@class Question;
@class QuestionBuilder;
@class StackOverflowCommunicator;


@protocol StackOverflowManagerDelegate;

@interface StackOverflowManager : NSObject <StackOverflowCommunicatorDelegate>

@property (weak, nonatomic) id<StackOverflowManagerDelegate> delegate;
@property (strong) StackOverflowCommunicator *communicator;
@property (strong) QuestionBuilder *questionBuilder;
@property (strong) Question *questionNeedingBody;

- (void)fetchQuestionsOnTopic:(Topic *)topic;
- (void)searchingForQuestionsFailedWithError:(NSError *)error;
- (void)receivedQuestionsJSON:(NSString *)objectNotation;

- (void)fetchBodyForQuestion:(Question *)question;
- (void)fetchingQuestionBodyFailedWithError:(NSError *)error;

- (void)receivedQuestionBodyJSON:(NSString *)objectNotation;

@end
