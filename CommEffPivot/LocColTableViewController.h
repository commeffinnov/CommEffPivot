//
//  LocColTableViewController.h
//  CommEffPivot
//
//  Created by Yitong Zhou on 10/10/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocColTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic)NSArray *courseData;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)sender;
- (NSInteger)tableView:(UITableView *)sender numberOfRowsInSection:(NSInteger)section;

@end
