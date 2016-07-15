//
//  BrowseOverflowViewControllerTests.m
//  BrowseOverflow
//
//  Created by Taki Bacalso on 14/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BrowseOverflowViewController.h"
#import <objc/objc-runtime.h>
#import "TopicTableDataSource.h"

@interface BrowseOverflowViewControllerTests : XCTestCase

@end

@implementation BrowseOverflowViewControllerTests
{
    BrowseOverflowViewController                    *viewController;
    UITableView                                     *tableView;
    id <UITableViewDataSource, UITableViewDelegate> dataSource;
}

- (void)setUp
{
    viewController = [[BrowseOverflowViewController alloc] init];
    tableView = [[UITableView alloc] init];
    viewController.tableView = tableView;
    
    dataSource = [[TopicTableDataSource alloc] init];
    
    viewController.dataSource = dataSource;
}

- (void)tearDown
{
    viewController = nil;
    tableView = nil;
    dataSource = nil;
}

- (void)testViewControllerHasATableViewProperty
{
    objc_property_t tableViewProperty = class_getProperty([viewController class], "tableView");
    XCTAssertTrue(tableViewProperty != NULL, @"BrowseOverflowViewController needs a table view");
}

- (void)testViewControllerHasADataSourceProperty
{
    objc_property_t dataSourceProperty = class_getProperty([viewController class], "dataSource");
    XCTAssertTrue(dataSourceProperty != NULL, @"View Controller needs a data source");
}

- (void)testViewControllerConnectsDataSourceInViewDidLoad
{
    [viewController viewDidLoad];
    
    XCTAssertEqualObjects([tableView dataSource],
                          dataSource,
                          @"View controller should have set the table view's data source");
}

- (void)testViewControllerConnectsDelegateInViewDidLoad
{
    [viewController viewDidLoad];
    
    XCTAssertEqualObjects([tableView delegate],
                          dataSource,
                          @"View controller should have set the table view's delegate");
}

@end
