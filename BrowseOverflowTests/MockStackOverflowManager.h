//
//  MockStackOverflowManager.h
//  BrowseOverflow
//
//  Created by Taki Bacalso on 13/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import "StackOverflowManager.h"

@interface MockStackOverflowManager : StackOverflowManager
{
    NSInteger   topicFailureErrorCode;
    NSString    *topicSearchString;
}

- (NSInteger)topicFailureErrorCode;
- (NSString *)topicSearchString;

@end
