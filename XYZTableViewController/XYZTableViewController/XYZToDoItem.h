//
//  XYZToDoItem.h
//  XYZTableViewController
//
//  Created by weeds on 14-10-7.
//  Copyright (c) 2014年 weeds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYZToDoItem : NSObject

@property NSString *itemName;
@property BOOL completed;
@property (readonly) NSDate *creationDate;

@end
