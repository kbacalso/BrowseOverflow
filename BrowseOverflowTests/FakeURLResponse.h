//
//  FakeURLResponse.h
//  BrowseOverflow
//
//  Created by Taki Bacalso on 13/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FakeURLResponse : NSObject

@property (assign) NSInteger statusCode;

- (instancetype)initWithStatusCode:(NSInteger)code;

@end
