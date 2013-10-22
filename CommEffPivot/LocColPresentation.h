//
//  LocColPresentation.h
//  CommEffPivot
//
//  Created by Cassandra Shi on 10/9/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocColPresentation : NSObject

@property (nonatomic, strong) NSString * ID;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * type;

-(id) initWithAttributes: (NSString *) pid
            title:(NSString *) title
            content:(NSString *) content
            type: (NSString *) ptype;

@end