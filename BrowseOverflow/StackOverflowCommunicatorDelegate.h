//
//  StackOverflowCommunicatorDelegate.h
//  BrowseOverflow
//
//  Created by Taki Bacalso on 13/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

@protocol StackOverflowCommunicatorDelegate <NSObject>

- (void)searchingForQuestionsFailedWithError:(NSError *)error;
- (void)receivedQuestionsJSON:(NSString *)objectNotation;

@end