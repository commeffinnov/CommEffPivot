//
//  LocColPresentation.m
//  CommEffPivot
//
//  Created by Cassandra Shi on 10/9/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import "LocColPresentation.h"

@implementation LocColPresentation

-(id) initWithAttributes:(NSString *)pid
                        title:(NSString *)title
                        content:(NSString *)content
                        type: (NSString *) ptype
                        status: (NSNumber *) status
{
    [self setID:pid];
    [self setTitle:title];
    [self setContent:content];
    [self setType:ptype];
    [self setStatus: status];
    return self;
}

@end