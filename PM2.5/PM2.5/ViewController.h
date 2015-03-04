//
//  ViewController.h
//  PM2.5
//
//  Created by weeds on 15/3/4.
//  Copyright (c) 2015年 weeds. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef GLOBAL_H
#define GLOBAL_H

NSMutableArray *(^GlobalArray)();

#endif

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *msgText;

@end

