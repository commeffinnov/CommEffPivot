//
//  LocColCommentRoomViewController.m
//  CommEffPivot
//
//  Created by Cassandra Shi on 11/30/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import "LocColCommentRoomViewController.h"
#import "LocColChatCell.h"
#import "LocColComment.h"
#import "FUIButton.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"
#import "UIBarButtonItem+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "LocColIndexPathButton.h"

@interface LocColCommentRoomViewController ()
{
    BOOL reloading;

}


//@property (strong, nonatomic) IBOutlet UITextView *comment_display;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UITextField *textfield;
@property (nonatomic, strong) NSMutableArray *messages;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *room_id;
@property (weak, nonatomic) IBOutlet UINavigationBar *navbar;




@end

@implementation LocColCommentRoomViewController


-(IBAction)likeButtonPressed:(LocColIndexPathButton*)sender{
    NSLog(@"Like button pressed...");
    NSLog(@"Currently the the cell index is %d", sender.cellIndex.row);
    NSLog(@"Current state is %d",sender.state);
    LocColChatCell *cell = [self.tableview cellForRowAtIndexPath:sender.cellIndex];
    if (sender.state == 0 ){
        sender.state=1;
        cell.numLikes.text = [NSString stringWithFormat:@"%d", 1];
        UIImage *likeButtonImage1=[UIImage imageNamed:@"icon-hearts-button-1.png"];
        [sender setImage:likeButtonImage1 forState:UIControlStateNormal];
        
    }else{
        cell.numLikes.text = [NSString stringWithFormat:@"%d", 0];
        UIImage *likeButtonImage0=[UIImage imageNamed:@"icon-hearts-button-0.png"];
        [sender setImage:likeButtonImage0 forState:UIControlStateNormal];
        sender.state=0;
    }
    
    
}

-(IBAction)replyButtonPressed:(LocColIndexPathButton*)sender{
    NSLog(@"Reply button pressed");
    LocColChatCell* cell =[self.tableview cellForRowAtIndexPath:sender.cellIndex];
    NSLog(cell.userName);
    self.textfield.text=[[@"@" stringByAppendingString:cell.userName] stringByAppendingString:@" :"];
    
}

//Call this method to append new comment on the exisiting chat table, this method will add a new LocColComment object to message list
-(void)appendNewMessage:(LocColComment*) new_comment

{
    [_messages addObject:new_comment];
    NSMutableArray *insertIndexPaths = [[NSMutableArray alloc] init];
    NSIndexPath *newPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [insertIndexPaths addObject:newPath];
    NSLog(@"numberOfRowsInSection: %d", [self tableView: self.tableview numberOfRowsInSection:0]);
    [_tableview beginUpdates];
    NSLog(@"numberOfRowsInSection: %d", [self tableView: self.tableview numberOfRowsInSection:0]);
    [_tableview insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationTop];
    [_tableview endUpdates];
    [_tableview reloadData];
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.view.backgroundColor = [UIColor cloudsColor];
    
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor midnightBlueColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"FontNAme" size:16], NSFontAttributeName, nil]];
    
    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor peterRiverColor]
                                  highlightedColor:[UIColor belizeHoleColor]
                                      cornerRadius:3
                                   whenContainedIn:[UINavigationBar class], nil];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"calllllled");
    //return _tableview.editing ? [_messages count]+1 : [_messages count];
    return [_messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LocColChatCell *cell = (LocColChatCell *)[tableView dequeueReusableCellWithIdentifier: @"Cell"];
    NSUInteger row = [_messages count]-[indexPath row]-1;
    NSLog(@"current row is %d, current message count is %d" , row, _messages.count );
    
    if (row < _messages.count){
        LocColComment* new_comment =  [_messages objectAtIndex:row];
        NSString *chatText = new_comment.text;
        NSString *userName = new_comment.user_name;
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        UIFont *font = [UIFont systemFontOfSize:14];
        CGSize size = [chatText sizeWithFont:font constrainedToSize:CGSizeMake(225.0f, 1000.0f) lineBreakMode:UILineBreakModeCharacterWrap];
        //cell.chatContent.frame = CGRectMake(75, 14, size.width +20, size.height + 20);
        cell.chatContent.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        cell.chatContent.text = [[userName stringByAppendingString:@": "] stringByAppendingString:chatText];
        cell.userName=userName;
       
        
        NSLog(@"the user name is %d", userName);
        
        CGRect frame = cell.chatContent.frame;
        frame.size.height = cell.chatContent.contentSize.height;
        cell.chatContent.frame = frame;
        
        
        NSLog(@"cell returned");
        [cell.chatContent sizeToFit];
        
        
        LocColIndexPathButton *likeButton = [LocColIndexPathButton buttonWithType:UIButtonTypeCustom];
        likeButton.cellIndex = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
        [likeButton addTarget:self action:@selector(likeButtonPressed:)
          forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:likeButton];
        UIImage *likeButtonImage1= [UIImage imageNamed:@"icon-hearts-button-0.png"];
        [likeButton setImage: likeButtonImage1 forState:UIControlStateNormal];
    
        [likeButton setFrame:CGRectMake(215,56,42,21)];
        likeButton.state=0;
        
        
         LocColIndexPathButton *replyButton = [LocColIndexPathButton buttonWithType:UIButtonTypeCustom];
         replyButton.cellIndex = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
        [replyButton addTarget:self action:@selector(replyButtonPressed:)
             forControlEvents:UIControlEventTouchUpInside];
         [cell.contentView addSubview:replyButton];
        UIImage *replyButtonImage= [UIImage imageNamed:@"icon-comments.png"];
       
        [replyButton setFrame:CGRectMake(265,56,42,21)];
         [replyButton setImage:replyButtonImage forState:UIControlStateNormal];
        
        
        
        
        
        //cell.chatUser.text = [[_messages objectAtIndex:row] objectForKey:@"userName"];
    }
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LocColComment* new_comment =  [_messages objectAtIndex:_messages.count-indexPath.row-1];
    NSString *cellText = new_comment.text;
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:14.0];
    CGSize constraintSize = CGSizeMake(220.0f, MAXFLOAT);
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    
    return labelSize.height +60;
}

- (void)reloadTableViewDataSource{
    
    //  should be calling your tableviews data source model to reload
    //  put here just for demo
    reloading = YES;
    [_tableview reloadData];
}

- (void)doneLoadingTableViewData{
    
    //  model should call this when its done loading
    reloading = NO;
    
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
    
    
    if (_textfield.text.length>0) {
        
        NSString* user_name = @"Cassandra";
        NSString* user_id = @"111";
        NSString* text = _textfield.text;
        NSString* reply_to_id = nil;
        NSString* reply_to_name = nil;
        NSString* comment_id = @"123";
        NSString* room_id = self.room_id;
        NSDate* ctime = nil;
        LocColComment* new_comment = [[LocColComment alloc]initWithAttributes:comment_id user_id:user_id user_name:@"cassandra" text:text reply_to_id:reply_to_id reply_to_name:reply_to_name room_id:room_id ctime:ctime];
        [self appendNewMessage:new_comment];
        NSLog(@"my name is");
        NSLog(new_comment.user_name);
        _textfield.text = @"";
    }
    
    
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
    const int movementDistance = -160; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}
- (IBAction)sendButtonPressed:(id)sender {
    
    
    if (_textfield.text.length>0) {
        // updating the table immediately
        NSArray *keys = [NSArray arrayWithObjects:@"text", nil];
        NSArray *objects = [NSArray arrayWithObjects:_textfield.text, nil];
        NSLog(@"text field's content is: %d", _textfield.text);
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        [_messages addObject:dictionary];
        
        NSMutableArray *insertIndexPaths = [[NSMutableArray alloc] init];
        NSIndexPath *newPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [insertIndexPaths addObject:newPath];
        NSLog(@"numberOfRowsInSection: %d", [self tableView: self.tableview numberOfRowsInSection:0]);
        [_tableview beginUpdates];
        NSLog(@"numberOfRowsInSection: %d", [self tableView: self.tableview numberOfRowsInSection:0]);
        [_tableview insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationTop];
        [_tableview endUpdates];
        [_tableview reloadData];
        
        
        
        //Send this new message to server
        
        _textfield.text = @"";
    }

}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewWillAppear:(BOOL)animated

{
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    
}

-(IBAction) textFieldDoneEditing : (id) sender
{
    NSLog(@"the text content%@",_textfield.text);
    [sender resignFirstResponder];
    [_textfield resignFirstResponder];
}

-(IBAction) backgroundTap:(id) sender
{
    [self.textfield resignFirstResponder];
}





- (void)viewDidLoad


{
 
//    self.tableview.delegate = table_controller;
//    self.tableview.dataSource = table_controller;
//    self.textfield.delegate = self;
    [super viewDidLoad];
    //_tableview.separatorColor = [UIColor clearColor];
    [self.tableview setDelegate:self];
    self.tableview.dataSource=self;
    [self.textfield setDelegate:self];
    if (_messages == nil){
        _messages= [[NSMutableArray alloc] init];
        
    }
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.view.backgroundColor = [UIColor cloudsColor];

    // XXX ONLY NEED TO DO THIS ONCE!! The navbar is SHARED in the app, so when you do this
    // you will be changing on every page.  If you change it for this page, you should
    // do it in the viewDidLoad and then in viewDidUnload, you should change it back!
    
//    [self.navbar configureFlatNavigationBarWithColor:[UIColor midnightBlueColor]];
//    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"FontNAme" size:16], NSFontAttributeName, nil]];
//    
//    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor peterRiverColor]
//                                  highlightedColor:[UIColor belizeHoleColor]
//                                      cornerRadius:3
//                                   whenContainedIn:[UINavigationBar class], nil];
    
    [self.tableview reloadData];
    _textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.navbar.topItem.title = @"Machine learning";
    
    //UIImage *btnImage = [UIImage imageNamed:@"image.png"];
    //[btnTwo setImage:btnImage forState:UIControlStateNormal];
   
    
    
   
    
  
    
    

    
    //self.comment_display.text = [self.comment_display.text stringByAppendingString:@"this is appened string"];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
