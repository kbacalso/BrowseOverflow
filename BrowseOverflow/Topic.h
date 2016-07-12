//
//  Topic.h
//  BrowseOverflow
//
//  Created by taki bacalso on 30/06/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Question;

@interface Topic : NSObject

@property (readonly) NSString *name;
@property (readonly) NSString *tag;

- (instancetype)initWithName:(NSString *)newName tag:(NSString *)tag;
- (NSArray *)recentQuestions;
- (void)addQuestion:(Question *)question;

@end
