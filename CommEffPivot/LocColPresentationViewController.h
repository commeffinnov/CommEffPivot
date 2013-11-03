//
//  LocColPresentaionViewController.h
//  CommEffPivot
//
//  Created by Yitong Zhou on 10/14/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PTPusher.h"
#import "LocColPresentation.h"

@interface LocColPresentationViewController : UIViewController
@property (nonatomic, strong) LocColPresentation *presentation;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UITextView *contentText;
@property (strong) PTPusher *client;

@end
