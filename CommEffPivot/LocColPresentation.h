//
//  LocColPresentation.h
//  CommEffPivot
//
//  Created by Cassandra Shi on 10/9/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocColPresentation : NSObject

@property (nonatomic,weak) NSString * ID;
@property (nonatomic,weak) NSString * title;
@property (nonatomic,weak) NSString * content;

-(id) initWithAttributes: (NSString *) pid
            title:(NSString *) title
            content:(NSString *) content;

@end