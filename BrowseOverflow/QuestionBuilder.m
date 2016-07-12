//
//  QuestionBuilder.m
//  BrowseOverflow
//
//  Created by taki bacalso on 07/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import "QuestionBuilder.h"

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
    
    return nil;
}

@end
