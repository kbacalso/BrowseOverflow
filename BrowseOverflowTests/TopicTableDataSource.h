//
//  EmptyTableViewDataSource.h
//  BrowseOverflow
//
//  Created by Taki Bacalso on 14/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *TopicTableDidSelectTopicNotification;

@class Topic;

@interface TopicTableDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *topics;
}

- (void)setTopics:(NSArray *)newTopics;
- (Topic *)topicForIndexPath:(NSIndexPath *)indexPath;

@end
