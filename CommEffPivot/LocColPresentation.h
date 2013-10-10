//
//  LocColPresentation.h
//  CommEffPivot
//
//  Created by Cassandra Shi on 10/9/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocColPresentation : NSObject

@property (nonatomic,weak) NSString * presentationID;
@property (nonatomic,weak) NSString * presentationTitle;
@property (nonatomic,weak) NSString * presentationContent;

-(id) initWithAttributes: (NSString *) pid
            title:(NSString *) title
            content:(NSString *) content;

@end