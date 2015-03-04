//
//  ViewController.m
//  PM2.5
//
//  Created by weeds on 15/3/4.
//  Copyright (c) 2015年 weeds. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

NSMutableArray *(^GlobalArray)() = ^(){
    __strong static NSMutableArray *mutableArray = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mutableArray = [NSMutableArray new];
    });
    return mutableArray;
};

static NSMutableArray *arr;
static NSNumber *str;
- (void) loadData{
    self.msgText.text = @"loading....";
    
    NSURL *url = [NSURL URLWithString:@"http://aqicn.org/publishingdata/json"];
    
    NSString *post=@"postData";
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    [request setTimeoutInterval:10.0];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror:%@%d", error.localizedDescription,error.code);
                               }else{
                                   
                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                   
                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   
                                   NSLog(@"HttpResponseCode:%d", responseCode);
                                   NSLog(@"HttpResponseBody %@",responseString);
                                   
                                   
                                   NSData *resData = [[NSData alloc] initWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding]];
                                   
                                   NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
                                   
                                   NSLog(@"resultDic=%@", resultDic);

                                   arr = [[resultDic valueForKey:@"pollutants"] valueForKey:@"value"];
                                   str = [[arr objectAtIndex:0] objectAtIndex:0];
                                   NSLog(@"PM2.5=%@", [[arr objectAtIndex:0] objectAtIndex:0]);
                                   
                                   
                               }
                           }];
        dispatch_async(dispatch_get_main_queue(),^{
            self.msgText.text = str.stringValue;
        });
        
    });
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadData];
    // start reloadData
}

- (IBAction)reloadData:(id)sender {
    NSLog(@"Button Clicked");
    [self loadData];
        NSLog(@"Button Clicked");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
