//
//  EmptyTableViewDelegate.h
//  BrowseOverflow
//
//  Created by Taki Bacalso on 14/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopicTableDataSource;

@interface TopicTableDelegate : NSObject <UITableViewDelegate>

@property (strong) TopicTableDataSource *tableDataSource;

@end
