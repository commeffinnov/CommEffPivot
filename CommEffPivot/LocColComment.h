//
//  LocColComment.h
//  CommEffPivot
//
//  Created by Cassandra Shi on 12/3/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>


//room_id == presentation_id

@interface LocColComment : NSObject

@property  (strong, nonatomic) NSString *user_id;
@property  (strong, nonatomic) NSString *user_name;
@property  (strong, nonatomic) NSString *text;
@property  (strong, nonatomic) NSString *reply_to_id;
@property  (strong, nonatomic) NSString *reply_to_name;
@property  (strong, nonatomic) NSString *comment_id;
@property  (strong, nonatomic) NSString *room_id;
@property  (strong, nonatomic) NSDate *ctime;


-(id) initWithAttributes: cid
                 user_id:(NSString *)user_id
               user_name:(NSString *)user_name
                    text:(NSString *)text
             reply_to_id: (NSString *) reply_to_id
           reply_to_name: (NSString *) reply_to_name
                 room_id:(NSString *) room_id
                   ctime:(NSDate *) ctime;

@end
