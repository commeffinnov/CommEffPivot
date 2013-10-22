//
//  LocColTableViewController.m
//  CommEffPivot
//
//  Created by Yitong Zhou on 10/10/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import "LocColPresentation.h"
#import "LocColCourseList.h"
#import "LocColCourse.h"
#import "LocColTableViewController.h"
#import "LocColPresentationViewController.h"
#import "LocColPresentationListViewController.h"
#import "Constants.h"
#import "AFHTTPRequestOperation.h"

@interface LocColTableViewController ()



@end

@implementation LocColTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
/*
    LocColCourseList *list = [[LocColCourseList alloc] init];
    NSMutableArray *arr = [list getCourses:@"111"];
    
    
    NSArray *arr2 = [arr copy];
 */    
    return self;
}

- (void)viewDidLoad
{
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.dataSource = self;
    
    self.courseData = [[NSMutableArray alloc] init];
    
    [self fetchCourseList];
    
    [super viewDidLoad];
    

    
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
    return [self.courseData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"course_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    LocColCourse *c = (LocColCourse *)[self.courseData objectAtIndex: indexPath.row];
    cell.textLabel.text = c.courseName;

    return cell;
}

- (void) fetchCourseList
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",API_HOST, @"courses/",@"123"];
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *array = responseObject;
        
        for (NSDictionary *dict in array){
            NSString *name = [dict valueForKey:@"name"];
            NSString *cid = [dict valueForKey:@"_id"];
            NSString *time = [dict valueForKey:@"ctime"];
            LocColCourse *course = [[LocColCourse alloc] initWithAttributes:cid name:name time:time];
            [self.courseData addObject:(id) course];
        }
        [self.tableView reloadData];
        
        NSLog(@"JSON: %@", array);
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"GoToPresentationList"]) {
        
        // Get destination view
        LocColPresentationListViewController *vc = [segue destinationViewController];
        
        // Get button tag number (or do whatever you need to do here, based on your object
        // LocColCourse *course = (LocColCourse *)sender;
        
        // Pass the information to your destination view
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [vc setCourse:[self.courseData objectAtIndex:0]];
    }
    
}

- (void)tableView:(UITableView *)tableView
accessoryButtonTappedForRowWithIndexPath:(NSIndexPath*)indexPath {
    
    //Build a segue string based on the selected cell
//    NSString *segueString = [NSString stringWithFormat:@"%@Segue",
//                             [self.courseData objectAtIndex:indexPath.row]];
    
    //Since contentArray is an array of strings, we can use it to build a unique
    //identifier for each segue.
    
    NSLog(@"gdddd!!!");
    //Perform a segue.
    [self performSegueWithIdentifier:@"GoToPresentationList"
                              sender:[self.courseData objectAtIndex:indexPath.row]];
    
}

@end
