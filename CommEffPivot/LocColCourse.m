//
//  LocColCourse.m
//  CommEffPivot
//
//  Created by Cassandra Shi on 10/9/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import "LocColCourse.h"
#import "LocColAPIRequest.h"
#import "LocColPresentation.h"

@implementation LocColCourse

NSMutableArray * _list;

-(id)initWithAttributes:(NSString *)courseid
                   name:(NSString *)name
                   time:(NSString *)time
{
    self = [super init];
    [self setCourseID:courseid];
    [self setCourseName:name];
    [self setCreatedTime:time];
    return self;
}

- (void) setPresentations:(NSMutableArray *)presentations
{
    _list = presentations;
}

- (NSMutableArray *) presentations
{
    if (!_list){
        NSString *url = [NSString stringWithFormat:@"%@%@%@",API_HOST, @"courses/presentations/", self.courseID];
        LocColAPIRequest *request = [[LocColAPIRequest alloc] init];
        NSData *responseData = [request get:url data:nil method: @"GET"];
        NSError *error;
        NSArray *array = [NSJSONSerialization JSONObjectWithData: responseData options:NSJSONReadingMutableContainers error:&error];
        _list = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in array){
            NSString *content = [dict valueForKey:@"content"];
            NSString *title = [dict valueForKey:@"title"];
            NSString *pid = [dict valueForKey:@"_id"];
            LocColPresentation *presentation = [[LocColPresentation alloc] initWithAttributes:pid title:title content:content];
            [_list addObject: (id)presentation];
        }
    }
    NSLog(@"%@",_list);
    return _list;
}

@end