//
//  BrowseOverflowViewController.m
//  BrowseOverflow
//
//  Created by Taki Bacalso on 14/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import "BrowseOverflowViewController.h"
#import "TopicTableDataSource.h"

@implementation BrowseOverflowViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.delegate = self.dataSource;
    self.tableView.dataSource = self.dataSource;
}

@end
