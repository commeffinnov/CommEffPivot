//
//  LocColCourse.h
//  CommEffPivot
//
//  Created by Cassandra Shi on 10/9/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocColCourse : NSObject

@property (nonatomic,strong) NSString * courseID;
@property (nonatomic,strong) NSString * courseName;
@property (nonatomic,strong) NSString * createdTime;
@property (atomic,strong) NSMutableArray *presentations;


-(id) initWithAttributes:(NSString *) courseid
                        name: (NSString *) name
                        time: (NSString *) time;
@end