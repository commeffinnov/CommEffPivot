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
{
    self = [super init];
    [self setPresentationID:pid];
    [self setPresentationTitle:title];
    [self setPresentationContent:content];
    return self;
}

@end