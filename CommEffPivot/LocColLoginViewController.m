//
//  LocColLoginViewController.m
//  CommEffPivot
//
//  Created by Yitong Zhou on 10/9/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import "LocColLoginViewController.h"
#import "LocColCourse.h"
#import "LocColAPIRequest.h"
#import "LocColCourseList.h"
#import "FUIButton.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"
#import "UIBarButtonItem+FlatUI.h"
#import "UINavigationBar+FlatUI.h"

@interface LocColLoginViewController()
{
}

@property (weak, nonatomic) IBOutlet FUIButton *signInButton;
@property (weak, nonatomic) IBOutlet UILabel *appName;

@end
@implementation LocColLoginViewController




- (void) viewDidLoad
{
    [super viewDidLoad];
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.view.backgroundColor = [UIColor cloudsColor];
    
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor midnightBlueColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"FontNAme" size:16], NSFontAttributeName, nil]];
    
//    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor peterRiverColor]
//                                  highlightedColor:[UIColor belizeHoleColor]
//                                      cornerRadius:3
//                                   whenContainedIn:[UINavigationBar class], nil];
    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor clearColor]
                                  highlightedColor:[UIColor clearColor]
                                      cornerRadius:3
                                   whenContainedIn:[UINavigationBar class], nil];
    
    [self.signInButton setButtonColor:[UIColor turquoiseColor]];

    self.signInButton.cornerRadius = 6.0f;
    self.signInButton.titleLabel.font = [UIFont boldFlatFontOfSize:14];
    [self.signInButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.signInButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    [self.appName setFont:[UIFont boldFlatFontOfSize:18]];
    [self.appName setTextColor:[UIColor turquoiseColor]];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [self.display resignFirstResponder];
        [self.password resignFirstResponder];
    }
}


- (IBAction)loginPressed:(UIButton *) sender {
    NSLog(@"hello");

    NSString *username = [self.display text];
    NSString *pass = [self.display text];
    
    NSString * login_url = [NSString stringWithFormat: @"%@%@", API_HOST, @"login"];
        
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:(id) username, (id)@"username", (id)pass, (id)@"password", nil ];
    
    NSData *data = [LocColAPIRequest get: login_url data: dict method: @"POST"];
    
    NSString *results = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    // check password
    NSLog(@"!!%@", results);
    if ([results isEqualToString:@"0"]){
        [self performSegueWithIdentifier:@"loginSegue" sender: self];
       
    }else{
        [self.notification setText:@"invalid username or password"];
    }
        
}

@end
