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

- (IBAction)loginPressed:(UIButton *) sender {
    NSLog(@"hello");

    NSString * login_url = [NSString stringWithFormat: @"%@%@", API_HOST, @"login"];
    
    LocColAPIRequest *request = [[LocColAPIRequest alloc] init];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:(id) @"111", (id)@"username", (id)@"112", (id)@"password", nil ];
    
    NSData *data = [request get: login_url data: dict method: @"POST"];
    
    NSString *results = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(results);
    
    self.display.text = @"hhahahah";
    
    LocColCourseList *courseList = [[LocColCourseList alloc] init];
    NSMutableArray *list = [courseList getCourses:@"111"];
    LocColCourse *c = [list objectAtIndex:1];
    [c getAllPresentations:@"111"];
    
}

@end
