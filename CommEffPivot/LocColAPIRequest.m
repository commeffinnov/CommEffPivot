//
//  LocColAPIRequest.m
//  CommEffPivot
//
//  Created by Yitong Zhou on 10/9/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import "LocColAPIRequest.h"

@implementation LocColAPIRequest

- (NSData *) get:(NSString *) url_str
            data: (NSDictionary *) dict
          method: (NSString *) method
{
    // Form a bodyStr
    NSMutableString *bodyStr = [[NSMutableString alloc]init];
    BOOL isFirst = YES;
    for(id key in dict) {
        id value = [dict objectForKey:key];
        if (![key isKindOfClass:[NSString class]] || ![value isKindOfClass:[NSString class]]){
            return nil;
        }
        NSString *keyS = (NSString *)key;
        NSString *valueS = (NSString *)value;
        
        if (!isFirst){
            [bodyStr appendString:@"&"];
        }else{
            isFirst = NO;
        }
        [bodyStr appendString: [NSString stringWithFormat:@"%@=%@", keyS, valueS]];
    }
    // form body
    NSData *body = [bodyStr dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    // form bodyLength
    NSString *bodyLength = [NSString stringWithFormat:@"%d", [body length]];
    // Form URL
    NSURL *url = [NSURL URLWithString:url_str];
    // Form Request
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    // Set Method
    [request setHTTPMethod: method];
    [request setURL: url];
    [request setValue:bodyLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody: body];
    
    // Make the call
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    // Return response
    return response;
}
@end
