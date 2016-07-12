//
//  FakeQuestionBuilder.m
//  BrowseOverflow
//
//  Created by taki bacalso on 07/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import "FakeQuestionBuilder.h"
#import "Question.h"

@implementation FakeQuestionBuilder

- (NSArray *)questionsFromJSON:(NSString *)objectNotation
                         error:(NSError **)error
{
    self.JSON = objectNotation;
    
    if (error) {
        *error = self.errorToSet;
    }
    
    return _arrayToReturn;
}

@end
