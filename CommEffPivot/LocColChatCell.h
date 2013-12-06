//
//  LocColChatCell.h
//  CommEffPivot
//
//  Created by Cassandra Shi on 12/2/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocColChatCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UITextView *chatContent;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UILabel *numLikes;
@property (weak, nonatomic) NSString *userName;

@end
