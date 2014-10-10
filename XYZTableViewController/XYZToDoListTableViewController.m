//
//  XYZToDoListTableViewController.m
//  XYZTableViewController
//
//  Created by weeds on 14-10-7.
//  Copyright (c) 2014年 weeds. All rights reserved.
//

#import "XYZToDoListTableViewController.h"
#import "XYZToDoItem.h"
#import "XYZAddToDoItemViewController.h"

@interface XYZToDoListTableViewController ()

@property NSMutableArray *toDoItems;

@end

@implementation XYZToDoListTableViewController

- (void)loadInitialData {
    self.toDoItems = [[NSMutableArray alloc] init];
    XYZToDoItem *item1 = [[XYZToDoItem alloc] init];
    item1.itemName = @"Buy milk";
    [self.toDoItems addObject:item1];
    XYZToDoItem *item2 = [[XYZToDoItem alloc] init];
    item2.itemName = @"Buy eggs";
    [self.toDoItems addObject:item2];
    XYZToDoItem *item3 = [[XYZToDoItem alloc] init];
    item3.itemName = @"Read a book";
    [self.toDoItems addObject:item3];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadInitialData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.toDoItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Add by weeds to fix bug not registerClass for cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ListPrototypeCell"];
    
    //static NSString *CellIdentifier = @"ListPrototypeCell";
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"ListPrototypeCell" forIndexPath:indexPath];
    XYZToDoItem *toDoItem = [self.toDoItems objectAtIndex:indexPath.row];
    cell.textLabel.text = toDoItem.itemName;
    if (toDoItem.completed) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    //2014-10-9, weeds 长按UITableViewCell显示删除按钮
    UIButton * btnSetDefault;
    
    btnSetDefault = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [btnSetDefault setImage:[UIImage imageNamed:@"checkred.png"] forState:UIControlStateNormal];
    btnSetDefault.tag = indexPath.row;
    [btnSetDefault addTarget:self action:@selector(onButtonSetDefault:) forControlEvents:UIControlEventTouchUpInside];
    
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longPressGR.minimumPressDuration = 0.2;
    [self.view addGestureRecognizer:longPressGR];
    
    return cell;
}

//长按显示删除
-(void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    //if (__DEBUG__)
    {
        NSLog(@"LONG PRESS");
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        UIActionSheet* sheetShown = [[UIActionSheet alloc] initWithTitle:nil delegate:(id<UIActionSheetDelegate>)self cancelButtonTitle:nil  destructiveButtonTitle:nil otherButtonTitles:@"删除", nil];
        
        [sheetShown showInView:self.view];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    XYZToDoItem *tappedItem = [self.toDoItems objectAtIndex:indexPath.row];
    tappedItem.completed = !tappedItem.completed;
    [tableView reloadRowsAtIndexPaths:
    @[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
// Show data from "Add New ToDo Item" textField by DoneButton
- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
    XYZAddToDoItemViewController *source = [segue sourceViewController];
    XYZToDoItem *item = source.toDoItem;
    if (item != nil) {
        [self.toDoItems addObject:item];
        [self.tableView reloadData];
    }
}

@end
