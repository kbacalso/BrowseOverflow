//
//  InspectableStackOverflowCommunicator.h
//  BrowseOverflow
//
//  Created by Taki Bacalso on 13/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import "StackOverflowCommunicator.h"

@interface InspectableStackOverflowCommunicator : StackOverflowCommunicator

- (NSURL *)URLToFetch;
- (NSURLConnection *)currentURLConnection;

@end
