//
//  LocColCommentRoomViewController.m
//  CommEffPivot
//
//  Created by Cassandra Shi on 11/30/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import "LocColCommentRoomViewController.h"
#import "LocColChatTableViewController.h"

@interface LocColCommentRoomViewController ()
//@property (strong, nonatomic) IBOutlet UITextView *comment_display;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UITextField *textfield;
@property (strong, nonatomic) IBOutlet UITableViewCell *messageCell;
@property (strong, nonatomic) IBOutlet UITableViewController *mytbvc;
@property (nonatomic, strong) NSMutableArray *messages;


@end

@implementation LocColCommentRoomViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger num = self.tableview.editing ? _messages.count + 1: _messages.count;
    NSLog(@"num: %d", num);
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"Cell";
    BOOL b_addCell = (indexPath.row == _messages.count);
    if (b_addCell) // set identifier for add row
        CellIdentifier = @"AddCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        if (!b_addCell) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    if (b_addCell)
        cell.textLabel.text = @"Add ...";
    else
        cell.textLabel.text = [_messages objectAtIndex:indexPath.row];
    
    return cell;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _messages.count)
        return UITableViewCellEditingStyleInsert;
    else
        return UITableViewCellEditingStyleDelete;
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableview setEditing:editing animated:animated];
    if(editing) {
        [self.tableview beginUpdates];
        [self.tableview insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:_messages.count inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableview endUpdates];
    } else {
        [self.tableview beginUpdates];
        [self.tableview deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:_messages.count inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableview endUpdates];
        // place here anything else to do when the done button is clicked
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = -130; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}


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
 
//    self.tableview.delegate = table_controller;
//    self.tableview.dataSource = table_controller;
//    self.textfield.delegate = self;
    [super viewDidLoad];
    if (_messages == nil){
        _messages= [[NSMutableArray alloc]init];
        }
    [self setEditing:true];
    [self setEditing:true];    
    [self setEditing:true];
    
    
    
   
   
   
    
    
    //self.comment_display.text = [self.comment_display.text stringByAppendingString:@"this is appened string"];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
