//
//  LocColComment.m
//  CommEffPivot
//
//  Created by Cassandra Shi on 12/3/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import "LocColComment.h"


/*
 @property  (strong, nonatomic) NSString *user_id;
 @property  (strong, nonatomic) NSString *user_name;
 @property  (strong, nonatomic) NSString *text;
 @property  (strong, nonatomic) NSString *reply_to_id;
 @property  (strong, nonatomic) NSString *reply_to_name;
 @property  (strong, nonatomic) NSString *comment_id;
 @property  (strong, nonatomic) NSString *room_id;
 @property  (strong, nonatomic) NSDate *ctime;
 */
@implementation LocColComment

-(id) initWithAttributes: cid
                 user_id:(NSString *)user_id
               user_name:(NSString *)user_name
                    text:(NSString *)text
             reply_to_id: (NSString *) reply_to_id
reply_to_name: (NSString *) reply_to_name
                    room_id:(NSString *) room_id
                   ctime:(NSDate *) ctime
{
    [self setComment_id:cid];
    [self setUser_id:user_id];
    [self setUser_name:user_name];
    [self setText:text];
    [self setReply_to_id:reply_to_id];
    [self setReply_to_name:reply_to_name];
    [self setRoom_id:room_id];
    [self setCtime: [NSDate date]];
    return self;
}


@end