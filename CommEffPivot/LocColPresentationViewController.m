//
//  LocColPresentaionViewController.m
//  CommEffPivot
//
//  Created by Yitong Zhou on 10/14/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import "LocColPresentationViewController.h"

#import "LocColPresentation.h"
#import "LocColPresentationSlide.h"


@implementation LocColPresentationViewController

{
    NSArray *slidesList;
    NSUInteger currentPage;
    bool controlMode;
}


@synthesize presentation=_presentation;

@synthesize titleLabel, contentText;


- (IBAction)goToNext:(id)sender {
    if(!controlMode){
        [self goToSlide:currentPage+1];}
}


- (IBAction)goToPrev:(id)sender {
    if (!controlMode){
        [self goToSlide:currentPage-1];}
}


-(void) goToSlide:(NSUInteger) index
{
    NSUInteger count = [slidesList count];
    if (index < count){
        LocColPresentationSlide *currentSlide = [slidesList objectAtIndex:index];
        self.titleLabel.text = currentSlide.title;
        self.contentText.text = currentSlide.content;
        currentPage = index;
    }
}

- (void)createSlides

{

    
    LocColPresentationSlide *slide1 =[[LocColPresentationSlide alloc] initWithAttributes:@"1" presentationID:@"1" index:@"0" type:@"static" title:@"SVM" content: @"some content here........"];
    LocColPresentationSlide *slide2 =[[LocColPresentationSlide alloc] initWithAttributes:@"2" presentationID:@"1" index:@"1" type:@"static" title:@"NB" content: @"some content here........"];
    LocColPresentationSlide *slide3 =[[LocColPresentationSlide alloc] initWithAttributes:@"3" presentationID:@"1" index:@"2" type:@"static" title:@"KNN" content: @"some content here........"];
    LocColPresentationSlide *slide4 =[[LocColPresentationSlide alloc] initWithAttributes:@"4" presentationID:@"1" index:@"3" type:@"static" title:@"Regression" content: @"some content here........"];
    
    slidesList=[NSArray arrayWithObjects:slide1, slide2,slide3, slide4,nil];
    
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
    [self createSlides];
    currentPage = 0;
    [self goToSlide: currentPage];
    controlMode=NO;
   
    
   
    
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

- (IBAction)swipeRight:(id)sender {
}
@end
