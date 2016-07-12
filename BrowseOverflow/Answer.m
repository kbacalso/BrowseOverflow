//
//  Answer.m
//  BrowseOverflow
//
//  Created by taki bacalso on 01/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import "Answer.h"

@implementation Answer

- (NSComparisonResult)compare:(Answer *)otherAnswer
{
    if (_accepted && !(otherAnswer.accepted)) {
        return NSOrderedAscending;
    } else if (!_accepted && otherAnswer.accepted) {
        return NSOrderedDescending;
    }
    
    if (_score > otherAnswer.score) {
        return NSOrderedAscending;
    } else if (_score < otherAnswer.score) {
        return NSOrderedDescending;
    } else {
        return NSOrderedSame;
    }
}

@end
