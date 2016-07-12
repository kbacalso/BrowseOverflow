//
//  StackOverflowManager.h
//  BrowseOverflow
//
//  Created by taki bacalso on 01/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *StackOverflowManagerError;
extern NSString *StackOverflowManagerSearchFailedError;

enum {
    StackOverflowManagerErrorQuestionSearchCode
};

@class Topic;
@class QuestionBuilder;
@class StackOverflowCommunicator;

@protocol StackOverflowManagerDelegate;

@interface StackOverflowManager : NSObject

@property (weak, nonatomic) id<StackOverflowManagerDelegate> delegate;
@property (strong) StackOverflowCommunicator *communicator;
@property (strong) QuestionBuilder *questionBuilder;

- (void)fetchQuestionsOnTopic:(Topic *)topic;
- (void)searchingForQuestionsFailedWithError:(NSError *)error;
- (void)receivedQuestionsJSON:(NSString *)objectNotation;

@end
