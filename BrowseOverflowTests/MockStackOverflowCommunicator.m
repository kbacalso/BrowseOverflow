//
//  MockStackOverflowCommunicator.m
//  BrowseOverflow
//
//  Created by taki bacalso on 06/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import "MockStackOverflowCommunicator.h"

@implementation MockStackOverflowCommunicator
{
    BOOL wasAskedToFetchQuestions;
    BOOL wasAskedToFetchBody;
}

- (void)searchForQuestionsWithTag:(NSString *)tag
{
    wasAskedToFetchQuestions = YES;
}

- (void)fetchQuestionBodyWithID:(NSInteger)questionID
{
    wasAskedToFetchBody = YES;
}

- (BOOL)wasAskedToFetchQuestions
{
    return wasAskedToFetchQuestions;
}

- (BOOL)wasAskedToFetchBody
{
    return wasAskedToFetchBody;
}

@end
