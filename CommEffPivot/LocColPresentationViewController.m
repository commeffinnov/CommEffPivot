//
//  LocColPresentaionViewController.m
//  CommEffPivot
//
//  Created by Yitong Zhou on 10/14/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import "LocColPresentationViewController.h"

#import "LocColPresentation.h"

@implementation LocColPresentationViewController

@synthesize presentation=_presentation;

@synthesize titleLabel, contentLabel;

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
    self.navigationItem.title = _presentation.title;
    self.contentLabel.text = _presentation.content;
    self.titleLabel.text = [NSString stringWithFormat:@"%@", _presentation.title];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.presentation = nil;
    
    self.titleLabel = nil;
    self.contentLabel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
