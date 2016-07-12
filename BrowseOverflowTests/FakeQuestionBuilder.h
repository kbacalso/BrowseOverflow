//
//  FakeQuestionBuilder.h
//  BrowseOverflow
//
//  Created by taki bacalso on 07/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import "QuestionBuilder.h"

@class Question;

@interface FakeQuestionBuilder : QuestionBuilder

@property (copy) NSString *JSON;
@property (copy) NSArray *arrayToReturn;
@property (copy) NSError *errorToSet;

@end
