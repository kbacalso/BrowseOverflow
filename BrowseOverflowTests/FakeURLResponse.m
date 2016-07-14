//
//  FakeURLResponse.m
//  BrowseOverflow
//
//  Created by Taki Bacalso on 13/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import "FakeURLResponse.h"

@implementation FakeURLResponse

- (instancetype)initWithStatusCode:(NSInteger)code
{
    self = [super init];
    
    if (self) {
        _statusCode = code;
    }
    
    return self;
}

@end
