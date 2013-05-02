//
//  MUApi.h
//  mark-uet
//
//  Created by Ethan Nguyen on 5/2/13.
//  Copyright (c) 2013 UET. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

typedef void(^ErrorHandlerBlock)(NSError *error);

@interface MUApi : AFHTTPClient

@property (nonatomic, strong, readonly) NSArray *marksData;

+ (id)sharedApi;
- (void)getAllMarks:(void(^)())successHandler error:(ErrorHandlerBlock)errorHandler;

#pragma Error handlers

- (void)showErrorAlert:(NSError*)error;

@end
