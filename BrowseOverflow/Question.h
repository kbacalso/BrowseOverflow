//
//  Question.h
//  BrowseOverflow
//
//  Created by taki bacalso on 01/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Answer;
@class Person;

@interface Question : NSObject

@property NSInteger questionID;
@property NSDate *date;
@property NSString *title;
@property NSInteger score;
@property (readonly) NSArray *answers;
@property (strong) Person *asker;
@property

- (void)addAnswer:(Answer *)answer;

@end
