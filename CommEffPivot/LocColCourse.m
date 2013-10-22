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

@end