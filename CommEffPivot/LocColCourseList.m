//
//  LocColCourseList.m
//  CommEffPivot
//
//  Created by Yitong Zhou on 10/9/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import "LocColCourseList.h"
#import "LocColAPIRequest.h"
#import "LocColCourse.h"
#import "AFHTTPRequestOperationManager.h"


@implementation LocColCourseList

+(void) loadCourses: (NSString *) userid
         datasource: (NSArray *) datasource
               view: (UITableViewController *) view
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",API_HOST, @"courses/", userid];
//    LocColAPIRequest *request = [[LocColAPIRequest alloc] init];
//    NSData *responseData = [request get:url data:nil method: @"GET"];
//    NSError *error;
//    NSArray *array = [NSJSONSerialization JSONObjectWithData: responseData options:NSJSONReadingMutableContainers error:&error];
//    NSMutableArray *list = [[NSMutableArray alloc] init];
//    for (NSDictionary *dict in array){
//        NSString *name = [dict valueForKey:@"name"];
//        NSString *cid = [dict valueForKey:@"_id"];
//        NSString *time = [dict valueForKey:@"ctime"];
//        LocColCourse *course = [[LocColCourse alloc] initWithAttributes:cid name:name time:time];
//        [list addObject: (id)course];
//    }
        
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *responseData = (NSData *)responseObject;
        NSError *error;
        NSArray *array = [NSJSONSerialization JSONObjectWithData: responseData options:NSJSONReadingMutableContainers error:&error];
        NSMutableArray *list = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in array){
            NSString *name = [dict valueForKey:@"name"];
            NSString *cid = [dict valueForKey:@"_id"];
            NSString *time = [dict valueForKey:@"ctime"];
            LocColCourse *course = [[LocColCourse alloc] initWithAttributes:cid name:name time:time];
            [list addObject: (id)course];
        }
        
        NSLog(@"JSON: %@", array);
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
