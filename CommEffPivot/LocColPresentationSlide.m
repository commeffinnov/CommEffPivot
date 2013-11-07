//
//  LocColPresentationSlide.m
//  CommEffPivot
//
//  Created by Cassandra Shi on 11/4/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import "LocColPresentationSlide.h"

@implementation LocColPresentationSlide



-(id) initWithAttributes:(NSString *)pid
          presentationID:(NSString *)presentationID
                   index:(NSString *)index
                    type:(NSString *)t
                   title:(NSString *)title
                 content:(NSString *)content
                   //cTime:(NSDate *) cTime
{
    [self setID:pid];
    [self setPresentationID:presentationID];
    [self setIndex:index];
    [self setType:t];
    [self setTitle:title];
    [self setContent:content];
   // [self setCtime:cTime];
    
    return self;
}

@end
