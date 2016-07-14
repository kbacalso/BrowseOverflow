//
//  MockStackOverflowManager.m
//  BrowseOverflow
//
//  Created by Taki Bacalso on 13/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import "MockStackOverflowManager.h"

@implementation MockStackOverflowManager

- (NSInteger)topicFailureErrorCode
{
    return topicFailureErrorCode;
}

- (void)searchingForQuestionsFailedWithError:(NSError *)error
{
    topicFailureErrorCode = error.code;
}

- (void)receivedQuestionsJSON:(NSString *)objectNotation
{
    topicSearchString = objectNotation;
}

- (NSString *)topicSearchString
{
    return topicSearchString;
}

@end
