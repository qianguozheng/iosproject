//
//  XYZAddToDoItemViewController.m
//  XYZTableViewController
//
//  Created by weeds on 14-10-8.
//  Copyright (c) 2014年 weeds. All rights reserved.
//

#import "XYZAddToDoItemViewController.h"

@interface XYZAddToDoItemViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@end

@implementation XYZAddToDoItemViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if (sender != self.doneButton) return;
    if (self.textField.text.length > 0) {
        self.toDoItem = [[XYZToDoItem alloc] init];
        self.toDoItem.itemName = self.textField.text;
        self.toDoItem.completed = NO;
    }
}

//测试发现以下两个textView没有起到应有的作用
/*
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSLog(@"se");
    if ([text isEqualToString:@"\n"])
    {
        NSLog(@"shouldChangeTextInRange");
        [textView resignFirstResponder];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"RETURN");
    return YES;
}
*/


//点击RETURN按钮，隐藏键盘
-(IBAction)TextField_DidEndOnExit:(id)sender
{
    [sender resignFirstResponder];
}

@end
