//
//  EmptyTableViewDataSource.m
//  BrowseOverflow
//
//  Created by Taki Bacalso on 14/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import "TopicTableDataSource.h"
#import "Topic.h"

NSString *topicCellReuseIdentifier = @"Topic";
NSString *TopicTableDidSelectTopicNotification = @"TopicTableDidSelectTopicNotification";

@implementation TopicTableDataSource

- (void)setTopics:(NSArray *)newTopics
{
    NSParameterAssert(newTopics != nil);
    topics = newTopics;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSParameterAssert(section == 0);
    return [topics count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSParameterAssert(indexPath.section == 0);
    NSParameterAssert(indexPath.row < topics.count);
    
    
    UITableViewCell *topicCell = [tableView dequeueReusableCellWithIdentifier:topicCellReuseIdentifier];
    
    if (!topicCell) {
        topicCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:topicCellReuseIdentifier];
    }
    
    topicCell.textLabel.text = [[self topicForIndexPath:indexPath] name];
    
    return topicCell;
}

- (Topic *)topicForIndexPath:(NSIndexPath *)indexPath
{
    return [topics objectAtIndex:[indexPath row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNotification *note = [NSNotification notificationWithName:TopicTableDidSelectTopicNotification
                                                         object:[self topicForIndexPath:indexPath]];
    
    [[NSNotificationCenter defaultCenter] postNotification:note];
}

@end
