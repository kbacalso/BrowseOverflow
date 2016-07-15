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
#import "Topic.h"
#import "QuestionListTableDataSource.h"


@interface BrowseOverflowViewControllerTests : XCTestCase

@end


static const char *notificationKey      = "BrowseOverflowViewControllerTestsAssociatedNotificationKey";

@implementation BrowseOverflowViewController (TestNotificaitonDelivery)

- (void)browseOverflowControllerTests_userDidSelectTopicNotification:(NSNotification *)note
{
    objc_setAssociatedObject(self,
                             notificationKey,
                             note,
                             OBJC_ASSOCIATION_ASSIGN);
}

@end


static const char *viewDidAppearKey     = "BrowseOverflowViewControllerTestsViewDidAppearKey";
static const char *viewWillDisappearKey = "BrowseOverflowViewControllerTestsViewWillDisappearKey";

@implementation UIViewController (TestSuperclassCalled)

- (void)browseOverflowViewControllerTests_viewDidAppear:(BOOL)animated
{
    NSNumber *parameter = [NSNumber numberWithBool:animated];
    objc_setAssociatedObject(self, viewDidAppearKey, parameter, OBJC_ASSOCIATION_RETAIN);
}

- (void)browseOverflowViewControllerTests_viewWillDisappear:(BOOL)animated
{
    NSNumber *parameter = [NSNumber numberWithBool:animated];
    objc_setAssociatedObject(self, viewWillDisappearKey, parameter, OBJC_ASSOCIATION_RETAIN);
}

@end

@implementation BrowseOverflowViewControllerTests
{
    BrowseOverflowViewController                    *viewController;
    UITableView                                     *tableView;
    id <UITableViewDataSource, UITableViewDelegate> dataSource;
    
    SEL realViewDidAppear, testViewDidAppear;
    SEL realViewWillDisappear, testViewWillDisappear;
    SEL realUserDidSelectTopic, testUserDidSelectTopic;
    
    UINavigationController *navController;
}

+ (void)swapInstanceMethodsForClass:(Class)cls
                           selector:(SEL)sel1
                        andSelector:(SEL)sel2
{
    Method method1 = class_getInstanceMethod(cls, sel1);
    Method method2 = class_getInstanceMethod(cls, sel2);
    
    method_exchangeImplementations(method1, method2);
}

- (void)setUp
{
    viewController = [[BrowseOverflowViewController alloc] init];
    tableView = [[UITableView alloc] init];
    viewController.tableView = tableView;
    
    dataSource = [[TopicTableDataSource alloc] init];
    
    viewController.dataSource = dataSource;
    
    
    objc_removeAssociatedObjects(viewController);
    
    
    realViewDidAppear = @selector(viewDidAppear:);
    testViewDidAppear = @selector(browseOverflowViewControllerTests_viewDidAppear:);
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[UIViewController class]
                                                          selector:realViewDidAppear
                                                       andSelector:testViewDidAppear];
    
    
    realViewWillDisappear = @selector(viewWillDisappear:);
    testViewWillDisappear = @selector(browseOverflowViewControllerTests_viewWillDisappear:);
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[UIViewController class]
                                                          selector:realViewWillDisappear
                                                       andSelector:testViewWillDisappear];
    
    
    realUserDidSelectTopic = @selector(userDidSelectTopicNotification:);
    testUserDidSelectTopic = @selector(browseOverflowControllerTests_userDidSelectTopicNotification:);
    
    
    navController = [[UINavigationController alloc] initWithRootViewController:viewController];
}

- (void)tearDown
{
    viewController = nil;
    tableView = nil;
    dataSource = nil;
    
    
    objc_removeAssociatedObjects(viewController);
    
    
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[UIViewController class]
                                                          selector:realViewDidAppear
                                                       andSelector:testViewDidAppear];
    
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[UIViewController class]
                                                          selector:realViewWillDisappear
                                                       andSelector:testViewWillDisappear];
    
    navController = nil;
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

- (void)testDefaultStateOfViewControllerDoesNotReceiveNotifications
{
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[BrowseOverflowViewController class]
                                                          selector:realUserDidSelectTopic
                                                       andSelector:testUserDidSelectTopic];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:TopicTableDidSelectTopicNotification
                                                        object:nil];
    
    XCTAssertNil(objc_getAssociatedObject(viewController, notificationKey),
                 @"Notification should not be received before -viewDidAppear:");
    
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[BrowseOverflowViewController class]
                                                          selector:realUserDidSelectTopic
                                                       andSelector:testUserDidSelectTopic];
}

- (void)testViewControllerReceivesTableSelectionNotificationAfterViewDidAppear
{
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[BrowseOverflowViewController class]
                                                          selector:realUserDidSelectTopic
                                                       andSelector:testUserDidSelectTopic];
    
    [viewController viewDidAppear:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:TopicTableDidSelectTopicNotification
                                                        object:nil];
    
    XCTAssertNotNil(objc_getAssociatedObject(viewController, notificationKey),
                    @"After -viewDidAppear: the view controller should handle"
                    @"selection notifications");
    
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[BrowseOverflowViewController class]
                                                          selector:realUserDidSelectTopic
                                                       andSelector:testUserDidSelectTopic];
}

- (void)testViewControllerDoesNotReceiveTableSelectNotificationAfterViewWillDisappear
{
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[BrowseOverflowViewController class]
                                                          selector:realUserDidSelectTopic
                                                       andSelector:testUserDidSelectTopic];
    
    [viewController viewDidAppear:NO];
    [viewController viewWillDisappear:NO];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:TopicTableDidSelectTopicNotification
                                                        object:nil];
    
    XCTAssertNil(objc_getAssociatedObject(viewController, notificationKey),
                 @"After -viewWillDisappear: is called, the view controller"
                 @"should no longer respond to topic selection notifications");
    
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[BrowseOverflowViewController class]
                                                          selector:realUserDidSelectTopic
                                                       andSelector:testUserDidSelectTopic];
}

- (void)testViewControllerCallsSuperViewDidAppear
{
    [viewController viewDidAppear:NO];
    
    XCTAssertNotNil(objc_getAssociatedObject(viewController, viewDidAppearKey),
                    @"-viewDidAppear: should call through to superclass"
                    @"implementation");
}

- (void)testViewControllerCallsSuperViewWillDisappear
{
    [viewController viewWillDisappear:NO];
    
    XCTAssertNotNil(objc_getAssociatedObject(viewController, viewWillDisappearKey),
                    @"-viewWillDisappear: should call through to superclass"
                    @"implementaion");
}

- (void)testSelectingTopicPushesNewViewController
{
    [viewController userDidSelectTopicNotification:nil];
    
    UIViewController *currentTopVC = navController.topViewController;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        XCTAssertFalse([currentTopVC isEqual:viewController],
                       @"New view controller should be pushed onto the stack");
        
        XCTAssertTrue([currentTopVC isKindOfClass:[BrowseOverflowViewController class]],
                      @"New view controller should be a BrowseOverflowViewController");
    });
}

- (void)testNewViewControllerHasAQuestionListDataSourceForTheSelectedTopic
{
    Topic *iPhoneTopic = [[Topic alloc] initWithName:@"iPhone"
                                                 tag:@"iphone"];
    
    NSNotification *iPhoneTopicSelectedNotification = [NSNotification notificationWithName:TopicTableDidSelectTopicNotification
                                                                                    object:iPhoneTopic];
    [viewController userDidSelectTopicNotification:iPhoneTopicSelectedNotification];
    
    BrowseOverflowViewController *nextViewController = (BrowseOverflowViewController *)navController.topViewController;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        XCTAssertTrue([nextViewController.dataSource isKindOfClass:[QuestionListTableDataSource class]],
                      @"Selecting a topic should push a list of questions");
        
        XCTAssertEqualObjects([(QuestionListTableDataSource *)nextViewController.dataSource topic],
                              iPhoneTopic,
                              @"The questions to display should come from the selected topic");
    });
}

@end
