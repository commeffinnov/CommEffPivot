//
//  LocColCourse.h
//  CommEffPivot
//
//  Created by Cassandra Shi on 10/9/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocColCourse : NSObject

@property (nonatomic,weak) NSString * courseID;
@property (nonatomic,weak) NSString * courseName;

+(NSMutableArray *) getAllCourses:(NSString *)userID;
+(LocColCourse *) getCourseByID:(NSString *)courseID;
+(void) addCourse:(NSString *)courseID;

@end
