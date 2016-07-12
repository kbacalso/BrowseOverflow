//
//  StackOverflowManagerDelegate.h
//  BrowseOverflow
//
//  Created by taki bacalso on 06/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Topic;

@protocol StackOverflowManagerDelegate <NSObject>

- (void)fetchingQuestionsFailedWithError:(NSError *)error;
- (void)didReceiveQuestions:(NSArray *)questions;

@end