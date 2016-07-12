//
//  Question.m
//  BrowseOverflow
//
//  Created by taki bacalso on 01/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import "Question.h"

@implementation Question
{
    NSMutableSet *answerSet;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        answerSet = [[NSMutableSet alloc] init];
    }
    
    return self;
}

- (void)addAnswer:(Answer *)answer
{
    [answerSet addObject:answer];
}

- (NSArray *)answers
{
    return [[answerSet allObjects] sortedArrayUsingSelector:@selector(compare:)];
}

@end
