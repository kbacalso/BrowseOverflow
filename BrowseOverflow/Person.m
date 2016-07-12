//
//  Person.m
//  BrowseOverflow
//
//  Created by taki bacalso on 01/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)initWithName:(NSString *)name
              avatarLocation:(NSString *)avatarLocation
{
    self = [super init];
    
    if (self) {
        _name = [name copy];
        _avatarURL = [NSURL URLWithString:avatarLocation];
    }
    
    return self;
}

@end
