//
//  MockStackOverflowManagerDelegate.m
//  BrowseOverflow
//
//  Created by taki bacalso on 06/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import "MockStackOverflowManagerDelegate.h"
#import "Topic.h"

@implementation MockStackOverflowManagerDelegate

- (void)fetchingQuestionsFailedWithError:(NSError *)error
{
    self.fetchError = error;
}

- (void)didReceiveQuestions:(NSArray *)questions
{
    self.receivedQuestions = questions;
}

@end
