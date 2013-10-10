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


@implementation LocColCourseList

-(NSMutableArray *) getCourses: (NSString *) userid
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",API_HOST, @"courses/", userid];
    LocColAPIRequest *request = [[LocColAPIRequest alloc] init];
    NSData *responseData = [request get:url data:nil method: @"GET"];
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
    return list;
}

@end
