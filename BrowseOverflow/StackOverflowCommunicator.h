//
//  StackOverflowCommunicator.h
//  BrowseOverflow
//
//  Created by taki bacalso on 06/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowCommunicatorDelegate.h"

extern NSString *StackOverflowCommunicatorErrorDomain;

@interface StackOverflowCommunicator : NSObject <NSURLConnectionDataDelegate>
{
    @protected
    NSURL           *fetchingURL;
    NSURLConnection *fetchingConnection;
    NSMutableData *receivedData;
    
    @private
    void (^errorHandler)(NSError *);
    void (^successHandler)(NSString *);
}

@property (weak) id <StackOverflowCommunicatorDelegate> delegate;

- (void)searchForQuestionsWithTag:(NSString *)tag;
- (void)fetchQuestionBodyWithID:(NSInteger)questionID;

- (void)downloadInformationForQuestionWithID:(NSInteger)identifier;
- (void)downloadAnswersToQuestionID:(NSInteger)identifier;

- (void)cancelAndDiscardURLConnection;

@end
