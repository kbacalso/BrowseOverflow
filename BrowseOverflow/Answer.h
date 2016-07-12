//
//  Answer.h
//  BrowseOverflow
//
//  Created by taki bacalso on 01/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Person;

@interface Answer : NSObject

@property NSString *text;
@property Person *person;
@property NSInteger score;
@property (getter=isAccepted) BOOL accepted;

- (NSComparisonResult)compare:(Answer *)otherAnswer;

@end
