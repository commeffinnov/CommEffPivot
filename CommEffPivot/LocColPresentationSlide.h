//
//  LocColPresentationSlide.h
//  CommEffPivot
//
//  Created by Cassandra Shi on 11/4/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocColPresentationSlide : NSObject



@property (nonatomic, strong) NSString * ID;
@property (nonatomic, strong) NSString * presentationID;
@property (nonatomic, strong) NSString * index;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * content;
//@property (nonatomic, strong) NSDate * ctime;



-(id) initWithAttributes: (NSString *) sid
          presentationID:(NSString *) presentationID
                   index:(NSString *) index
                    type:(NSString *) type
                   title:(NSString *) title
                 content:(NSString *) content;
                   //ctime:(NSDate *) ctime;



@end
