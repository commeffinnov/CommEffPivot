//
//  LocColPresentaionViewController.h
//  CommEffPivot
//
//  Created by Yitong Zhou on 10/14/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LocColPresentation;
@interface LocColPresentationViewController : UIViewController
@property (nonatomic, retain) LocColPresentation *presentation;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
