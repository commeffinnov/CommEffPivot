//
//  LocColPresentaionViewController.m
//  CommEffPivot
//
//  Created by Yitong Zhou on 10/14/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import "PTPusher.h"
#import "PTPusherChannel.h"
#import "PTPusherEvent.h"

#import "LocColPresentationViewController.h"
#import "LocColPresentation.h"


@implementation LocColPresentationViewController

@synthesize presentation = _presentation;
@synthesize client = _client;
@synthesize titleLabel, contentText;

- (id)initWithCourseID:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    self.navigationItem.title = _presentation.title;
    self.contentText.text = _presentation.content;
    self.titleLabel.text = [NSString stringWithFormat:@"%@", _presentation.title];
    [self subscribeChannels];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.presentation = nil;
    
    self.titleLabel = nil;
    self.contentText = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// Channels
- (void) subscribeChannels
{
    NSLog(@"subscribe");
    _client = [PTPusher pusherWithKey:@"5d619a48dbd0465163f0" delegate: self encrypted:YES];
    PTPusherChannel *channel = [_client subscribeToChannelNamed:@"test-channel"];
    [channel bindToEventNamed:@"test-event" handleWithBlock:^(PTPusherEvent *channelEvent) {
        NSLog(@"channels");
        NSDictionary *dict = (NSDictionary *) channelEvent.data;
        self.titleLabel.text = [dict valueForKey:@"message"];
    }];
}
@end
