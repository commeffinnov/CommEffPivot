//
//  LocColPresentaionViewController.m
//  CommEffPivot
//
//  Created by Yitong Zhou on 10/14/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import "AFHTTPRequestOperation.h"
#import "PTPusher.h"
#import "PTPusherEvent.h"
#import "PTPusherChannel.h"

#import "LocColPresentationViewController.h"
#import "LocColPresentation.h"
#import "LocColPresentationSlide.h"
#import "UIFont+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "UIBarButtonItem+FlatUI.h"


@implementation LocColPresentationViewController
{
    NSUInteger currentPage;
    bool controlMode;
    PTPusher *_client;
    PTPusherChannel *_channel;
}


@synthesize presentation=_presentation;

@synthesize titleLabel, contentText;


- (IBAction)goToNext:(id)sender
{
    if(!controlMode){
        NSLog(@"contorl mode");
        [self goToSlide:currentPage+1];}
}


- (IBAction)goToPrev:(id)sender {
    if (!controlMode){
        NSLog(@"contorl mode");
        [self goToSlide:currentPage-1];}
}


-(void) goToSlide:(NSUInteger) index
{
    NSUInteger count = [self.slides count];
    if (index < count){
        LocColPresentationSlide *currentSlide = [self.slides objectAtIndex:index];
        self.titleLabel.text = currentSlide.title;
        self.contentText.text = currentSlide.content;
        currentPage = index;
    }
}

- (id)initWithCourseID:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.toolbarHidden = NO;
    [self loadSlides];
    currentPage = 0;
    
    [self goToSlide: currentPage];
    controlMode = YES;
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor emerlandColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"FontNAme" size:16], NSFontAttributeName, nil]];
    
    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor whiteColor]
                                  highlightedColor:[UIColor whiteColor]
                                      cornerRadius:3
                                   whenContainedIn:[LocColPresentationViewController class], nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.presentation = nil;
    
    self.titleLabel = nil;
    self.contentText = nil;
}

- (void)loadSlides
{
    NSString *url = [NSString stringWithFormat:@"%@presentations/%@/slides",API_HOST, self.presentation.ID];
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *array = responseObject;
        self.slides = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in array){
            NSString * ID = [dict valueForKey:@"_id"];
            NSString * presentationID = [dict valueForKey:@"presentationID"];
            NSString * index = [dict valueForKey:@"index"];
            NSString * type = [dict valueForKey:@"type"];
            NSString * title = [dict valueForKey:@"title"];
            NSString * content = [dict valueForKey:@"content"];
            LocColPresentationSlide *slide = [[LocColPresentationSlide alloc] initWithAttributes : ID
                    presentationID : presentationID
                             index : index
                              type : type
                             title : title
                           content : content];
            [self.slides addObject:(id) slide];
        }
        [self goToSlide:(0)];
        [self subscribeChannels];
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
}

- (void) subscribeChannels
{
    _client = [PTPusher pusherWithKey:PUSHER_APP_KEY delegate:self encrypted:YES];
    [self subscribePresentationChannel];
}

- (void) subscribePresentationChannel
{
    NSString *channelName = [NSString stringWithFormat:@"presentation_channel_%@", self.presentation.ID];
    _channel = [_client subscribeToChannelNamed:channelName];
    [_channel bindToEventNamed:@"slide_event" handleWithBlock:^(PTPusherEvent *channelEvent) {
        NSLog(@"%@ slide_event", channelEvent.data);
        NSDictionary *dict = channelEvent.data;
        NSString *index = [dict valueForKey:@"index"];
        int i = [index intValue];
        [self goToSlide:i];
        controlMode=YES;
    }];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)swipeRight:(id)sender {
}
@end
