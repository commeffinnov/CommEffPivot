//
//  LocColAPIRequest.h
//  CommEffPivot
//
//  Created by Yitong Zhou on 10/9/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocColAPIRequest : NSObject

+ (NSData *) get:(NSString *) url_str
            data: (NSDictionary *) dict
          method: (NSString *) method;

+ (void) send:(NSString *) url_str
         data: (NSDictionary *) dict
       method: (NSString *) method;

@end
