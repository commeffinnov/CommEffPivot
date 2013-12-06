//
//  LocColPresentaionViewController.h
//  CommEffPivot
//
//  Created by Yitong Zhou on 10/14/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LocColPresentation.h"
#import "LocColViewController.h"

@interface LocColPresentationViewController : LocColViewController

@property (nonatomic, strong) LocColPresentation *presentation;
@property (nonatomic, strong) NSMutableArray *slides;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeRight;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeLeft;


@property (weak, nonatomic) IBOutlet UITextView *contentText;

-(void) loadSlides;

@end
