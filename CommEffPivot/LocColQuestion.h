//
//  LocColQuestion.h
//  CommEffPivot
//
//  Created by Yitong Zhou on 10/22/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocColQuestion : NSObject

@property  (strong, nonatomic) NSNumber *number;
@property  (strong, nonatomic) NSString *presentationID;
@property  (strong, nonatomic) NSString *title;
@property  (strong, nonatomic) NSString *ID;
@property  (strong, nonatomic) NSDate *ctime;
@property  (strong, nonatomic) NSArray *selections;

@end
