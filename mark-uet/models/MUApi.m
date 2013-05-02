//
//  MUApi.m
//  mark-uet
//
//  Created by Ethan Nguyen on 5/2/13.
//  Copyright (c) 2013 UET. All rights reserved.
//

#import "MUApi.h"
#import "JSONKit.h"
#import "AFHTTPRequestOperation.h"
#import "MMark.h"

@implementation MUApi

+ (id)sharedApi {
    static MUApi *_sharedApi = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedApi = [[MUApi alloc] initWithBaseURL:[NSURL URLWithString:kApiUrl]];
    });
    return _sharedApi;
}

- (void)getAllMarks:(void (^)())successHandler error:(ErrorHandlerBlock)errorHandler {
    [self
     getPath:@"marks.json"
     parameters:nil
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSDictionary *responseDict = [responseObject objectFromJSONData];
         
         if (!responseDict) {
             NSError *error = [NSError errorWithDomain:@"Non-JSON data" code:1 userInfo:nil];
             errorHandler(error);
             return;
         }
         
         NSMutableArray *marksArr = [NSMutableArray array];
         for (NSDictionary *dict in responseDict[@"marks"]) {
             MMark *mark = [[MMark alloc] initWithDict:dict];
             [marksArr addObject:mark];
         }
         
         _marksData = [NSArray arrayWithArray:marksArr];
         
         successHandler();
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         errorHandler(error);
     }];
}

#pragma Error handlers
- (void)showErrorAlert:(NSError *)error {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:[NSString stringWithFormat:@"Error code %d - %@", error.code, error.domain]
                              message:[NSString stringWithFormat:@"%@", error.userInfo]
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    
    [alertView show];
}

@end
