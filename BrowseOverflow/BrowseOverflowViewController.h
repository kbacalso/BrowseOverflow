//
//  BrowseOverflowViewController.h
//  BrowseOverflow
//
//  Created by Taki Bacalso on 14/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowseOverflowViewController : UIViewController

@property (strong) IBOutlet UITableView *tableView;
@property (strong) id <UITableViewDataSource, UITableViewDelegate> dataSource;

@end
