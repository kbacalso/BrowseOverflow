//
//  QuestionBuilder.h
//  BrowseOverflow
//
//  Created by taki bacalso on 07/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *QuestionBuilderErrorDomain;

enum {
    QuestionBuilderInvalidJSONError,
    QuestionBuilderMissingDataError,
};

@class Question;

@interface QuestionBuilder : NSObject

@property (strong) Question *questionToFill;

- (NSArray *)questionsFromJSON:(NSString *)objectNotation
                         error:(NSError **)error;

- (void)fillInDetailsForQuestion:(Question *)question
                        fromJSON:(NSString *)objectNotation;

@end
