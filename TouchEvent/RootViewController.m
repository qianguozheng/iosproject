//
//  RootViewController.m
//  TouchEvent
//
//  Created by weeds on 14-10-19.
//  Copyright (c) 2014年 weeds. All rights reserved.
//

#import "RootViewController.h"
#import "XYZTouchView.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    XYZTouchView *aview = [[XYZTouchView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
    aview.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:aview];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
