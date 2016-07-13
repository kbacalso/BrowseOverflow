//
//  QuestionBuilder.m
//  BrowseOverflow
//
//  Created by taki bacalso on 07/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import "QuestionBuilder.h"
#import "Question.h"
#import "Person.h"

NSString *QuestionBuilderErrorDomain = @"QuestionBuilderErrorDomain";

@implementation QuestionBuilder

- (NSArray *)questionsFromJSON:(NSString *)objectNotation error:(NSError **)error
{
    NSParameterAssert(objectNotation != nil);
    
    NSData *unicodeNotation = [objectNotation dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *localError = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:unicodeNotation
                                                    options:0
                                                      error:&localError];
    
    NSDictionary *parsedObject = (id)jsonObject;
    if (parsedObject == nil) {
        
        if (error != NULL) {
            *error = [NSError errorWithDomain:QuestionBuilderErrorDomain
                                         code:QuestionBuilderInvalidJSONError
                                     userInfo:nil];
        }
        
        return nil;
        
    }
    
    
    NSArray *questions = [parsedObject objectForKey:@"items"];
    if (questions == nil) {
        
        if (error != NULL) {
            
            *error = [NSError errorWithDomain:QuestionBuilderErrorDomain
                                         code:QuestionBuilderMissingDataError
                                     userInfo:nil];
            
        }
        
        return nil;
        
    }
    
    return [self questionArrayFromArray:questions];
}

- (NSArray *)questionArrayFromArray:(NSArray *)rawArray
{
    NSArray *questionArray = [NSArray array];
    for (NSDictionary *questionDict in rawArray) {
        Question *question = [self questionFromDict:questionDict];
        questionArray = [questionArray arrayByAddingObject:question];
    }
    
    return questionArray;
}

- (Question *)questionFromDict:(NSDictionary *)questionDict
{
    Question *question = [[Question alloc] init];
    question.questionID = [questionDict[@"question_id"] integerValue];
    question.date = [NSDate dateWithTimeIntervalSince1970:[questionDict[@"creation_date"] integerValue]];
    question.title = questionDict[@"title"];
    question.score = [questionDict[@"score"] integerValue];
    question.asker = [self personFromDict:questionDict[@"owner"]];
    question.body = questionDict[@"body"];
    return question;
}

- (Person *)personFromDict:(NSDictionary *)personDict
{
    Person *person = [[Person alloc] initWithName:personDict[@"display_name"]
                                   avatarLocation:personDict[@"profile_image"]];
    
    return person;
}

- (void)fillInDetailsForQuestion:(Question *)question
                        fromJSON:(NSString *)objectNotation
{
    NSParameterAssert(question != nil);
    NSParameterAssert(objectNotation != nil);
    
    self.questionToFill = question;
    
    Question *fetchedQuestion = [[self questionsFromJSON:objectNotation
                                                  error:nil] firstObject];
    
    if (fetchedQuestion == nil) {
        question.body = nil;
        return;
    }
    
    question.body = fetchedQuestion.body;
    
}

@end
