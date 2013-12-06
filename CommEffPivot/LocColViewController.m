//
//  LocColViewController.m
//  CommEffPivot
//
//  Created by Yitong Zhou on 9/27/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import "LocColViewController.h"
#import "UIFont+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "UIBarButtonItem+FlatUI.h"

@interface LocColViewController ()

@end

@implementation LocColViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor turquoiseColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"FontNAme" size:16], NSFontAttributeName, nil]];
    
    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor whiteColor]
                                  highlightedColor:[UIColor whiteColor]
                                      cornerRadius:3
                                   whenContainedIn:[UINavigationBar class], nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
