//
//  LocColPresentationListViewController.m
//  CommEffPivot
//
//  Created by Yitong Zhou on 10/18/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import "AFHTTPRequestOperation.h"

#import "LocColQuizViewController.h"
#import "LocColPresentationViewController.h"
#import "LocColPresentationListViewController.h"
#import "LocColPresentation.h"

@interface LocColPresentationListViewController ()

@end

@implementation LocColPresentationListViewController

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
    self.tableView.dataSource = self;
    if (self.course.presentations == nil){
        [self.course setPresentations:[[NSMutableArray alloc]init]];
        [self fetchPresentationList];
    }
    [super viewDidLoad];
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
    // Return the number of rows in the section.
    return [self.course.presentations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"presentationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    LocColPresentation * presentation= (LocColPresentation *)[self.course.presentations objectAtIndex:indexPath.row];
    cell.textLabel.text = presentation.title;
    return cell;
}

-(void) fetchPresentationList
{
        NSString *url = [NSString stringWithFormat:@"%@%@%@",API_HOST, @"courses/presentations/",self.course.courseID];
        NSURL *URL = [NSURL URLWithString:url];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        op.responseSerializer = [AFJSONResponseSerializer serializer];
        [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *array = responseObject;
            
            for (NSDictionary *dict in array){
                NSString *content = [dict valueForKey:@"content"];
                NSString *title = [dict valueForKey:@"title"];
                NSString *pid = [dict valueForKey:@"_id"];
                NSString *ptype = [dict valueForKey:@"type"];
                LocColPresentation *presentation = [[LocColPresentation alloc] initWithAttributes:pid title:title content:content type:ptype];
                [self.course.presentations addObject:(id) presentation];

            }
            [self.tableView reloadData];
            
            NSLog(@"JSON: %@", responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"Error: %@", error);
        }];
        [[NSOperationQueue mainQueue] addOperation:op];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"sender: %@", [(LocColPresentation *)sender title]);
    if ([[segue identifier] isEqualToString:@"GoToPresentationDetails"]) {
        // Get destination view
        LocColPresentationViewController *vc = [segue destinationViewController];
        
        // Load Presentation Object
        [vc setPresentation: (LocColPresentation *)sender];
    }else if ([[segue identifier] isEqualToString:@"GoToQuizDetails"]) {
        LocColQuizViewController *vc = [segue destinationViewController];
        [vc setPresentation: (LocColPresentation *)sender];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Bind the details view with the cell selected event
    
    LocColPresentation *presentation = [self.course.presentations objectAtIndex:indexPath.row];
    NSLog(@"Presentation List Button Pressed, type: %@", presentation.type);

    if ([presentation.type isEqualToString:@"quiz"]){
        [self performSegueWithIdentifier:@"GoToQuizDetails"
                              sender:presentation];
    }else{
        NSLog(@"present:%@", presentation);
        [self performSegueWithIdentifier:@"GoToPresentationDetails"
                                  sender:(id)presentation];
    }
}

@end
