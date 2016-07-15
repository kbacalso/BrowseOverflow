//
//  BrowseOverflowViewController.m
//  BrowseOverflow
//
//  Created by Taki Bacalso on 14/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import "BrowseOverflowViewController.h"
#import "TopicTableDataSource.h"
#import "Topic.h"
#import "QuestionListTableDataSource.h"

@implementation BrowseOverflowViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userDidSelectTopicNotification:)
                                                 name:TopicTableDidSelectTopicNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:TopicTableDidSelectTopicNotification
                                                  object:nil];
    
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.delegate = self.dataSource;
    self.tableView.dataSource = self.dataSource;
}

- (void)userDidSelectTopicNotification:(NSNotification *)note
{
    Topic *selectedTopic = (Topic *)[note object];
    
    QuestionListTableDataSource *questionDataSource = [[QuestionListTableDataSource alloc] init];
    questionDataSource.topic = selectedTopic;
    
    BrowseOverflowViewController *nextViewController = [[BrowseOverflowViewController alloc] init];
    nextViewController.dataSource = questionDataSource;
    
    [[self navigationController] pushViewController:nextViewController
                                           animated:YES];
    
}

@end
