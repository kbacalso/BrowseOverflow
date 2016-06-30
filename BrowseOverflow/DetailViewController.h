//
//  DetailViewController.h
//  BrowseOverflow
//
//  Created by taki bacalso on 30/06/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

