//
//  LocColRequestQueue.m
//  CommEffPivot
//
//  Created by Alex Liu on 10/9/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import "LocColRequestQueue.h"

@implementation LocColRequestQueue
@synthesize requestQueue = _requestQueue;


/*
 You can access the request queue by using:
 [[LocColRequestQueue sharedRequestQueue] requestQueue];
 
 */

+ (id) sharedRequestQueue
{
    static LocColRequestQueue *sharedRequestQueue = nil;
    
    // singleton should only be allowed to be created once
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedRequestQueue = [[self alloc] init];
    });
    
    return sharedRequestQueue;
}

- (id) init
{
    self = [super init];
    if (self) {
        
        // XXX set max operation count
        _requestQueue = [[NSOperationQueue alloc] init];
        _requestQueue.maxConcurrentOperationCount = 3;
    }
    
    return self;
}

- (NSOperationQueue *) requestQueue
{
    if (!_requestQueue) {
        _requestQueue = [[NSOperationQueue alloc] init];
        [_requestQueue setMaxConcurrentOperationCount:3];

    }
    return _requestQueue;
}

- (void) setRequestQueue:(NSOperationQueue *)requestQueue
{
    if (requestQueue != _requestQueue) {
        _requestQueue = requestQueue;
    }
}

- (void)requestDidSucceed:(NSObject *) request
{
    // default requestDidSucceed operation
    
}

- (void)requestDidfail:(NSError *) error
{
    // TODO: show better error message

}

@end
