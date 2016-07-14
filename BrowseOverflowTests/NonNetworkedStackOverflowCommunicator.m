//
//  NonNetworkedStackOverflowCommunicator.m
//  BrowseOverflow
//
//  Created by Taki Bacalso on 13/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import "NonNetworkedStackOverflowCommunicator.h"

@implementation NonNetworkedStackOverflowCommunicator

- (void)setReceivedData:(NSData *)newData
{
    receivedData = [newData mutableCopy];
}

- (NSData *)receivedData
{
    return [receivedData copy];
}

@end
