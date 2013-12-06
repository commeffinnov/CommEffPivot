//
//  LocColCourseTableViewController.h
//  CommEffPivot
//
//  Created by Yitong Zhou on 10/10/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocColCourseTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic)NSMutableArray *courseData;

@end
