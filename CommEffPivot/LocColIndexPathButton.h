//
//  LocColIndexPathButton.h
//  CommEffPivot
//
//  Created by Cassandra Shi on 12/5/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocColIndexPathButton : UIButton{
    NSInteger state;
    
}


@property (strong, nonatomic) NSIndexPath *cellIndex;
@property int state;





@end
