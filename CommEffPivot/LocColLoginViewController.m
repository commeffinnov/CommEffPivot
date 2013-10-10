//
//  LocColLoginViewController.m
//  CommEffPivot
//
//  Created by Yitong Zhou on 10/9/13.
//  Copyright (c) 2013 Yitong Zhou. All rights reserved.
//

#import "LocColLoginViewController.h"
#import "LocColUtils.h"

@interface LocColLoginViewController()

@end
@implementation LocColLoginViewController

- (IBAction)testBtn:(UIButton *)sender {
    self.display.text = @"shit";
    NSLog(@"hahahahahha");
}

- (IBAction)loginPressed:(UIButton *) sender {
    NSLog(@"hello");
    
    NSString *bodyStr = [NSString stringWithFormat:@"%@%@", @"username=111", @"&password=111"];
    NSData *body = [bodyStr dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [body length]];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_HOST, @"login"]];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod: @"POST"];
    [request setURL: url];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody: body];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    NSString *results = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    NSLog(results);
    
    self.display.text = @"hhahahah";
}

@end
