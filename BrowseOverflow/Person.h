//
//  Person.h
//  BrowseOverflow
//
//  Created by taki bacalso on 01/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (readonly) NSString   *name;
@property (readonly) NSURL      *avatarURL;

- (instancetype)initWithName:(NSString *)name
              avatarLocation:(NSString *)avatarLocation;

@end
