//
//  LocColRequestQueue.h
//  CommEffPivot
//
//  Created by Alex Liu on 10/9/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocColRequestQueue : NSObject

@property NSOperationQueue *requestQueue;

+ (id) sharedRequestQueue;

@end
