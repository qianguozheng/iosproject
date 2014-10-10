//
//  XYZAddToDoItemViewController.h
//  XYZTableViewController
//
//  Created by weeds on 14-10-8.
//  Copyright (c) 2014年 weeds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZToDoItem.h"
@interface XYZAddToDoItemViewController : UIViewController

@property XYZToDoItem *toDoItem;
-(IBAction)TextField_DidEndOnExit:(id)sender;
@end
