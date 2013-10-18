//
//  LocColLoginViewController.m
//  CommEffPivot
//
//  Created by Yitong Zhou on 10/9/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import "LocColLoginViewController.h"
#import "LocColUtils.h"
#import "LocColCourse.h"
#import "LocColAPIRequest.h"
#import "LocColCourseList.h"

@interface LocColLoginViewController()

@end
@implementation LocColLoginViewController

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
    
    LocColAPIRequest *request = [[LocColAPIRequest alloc] init];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:(id) username, (id)@"username", (id)pass, (id)@"password", nil ];
    
    NSData *data = [request get: login_url data: dict method: @"POST"];
    
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
