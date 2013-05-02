//
//  MMark.m
//  mark-uet
//
//  Created by Ethan Nguyen on 5/2/13.
//  Copyright (c) 2013 UET. All rights reserved.
//

#import "MMark.h"

@implementation MMark

- (id)initWithDict:(NSDictionary *)dict {
    if (self = [super initWithDict:dict]) {
        self.Id = dict[@"id"];
        NSArray *titleArr = [_title componentsSeparatedByCharactersInSet:
                             [NSCharacterSet characterSetWithCharactersInString:@"()"]];
        
        if ([titleArr count] >= 2) {
            _title = titleArr[0];
            _uploaded_at = titleArr[1];
        }
    }
    return self;
}

- (NSString*)description {
    return [NSString stringWithFormat:@"MMark <Id: %@ - Title: %@ - Uploaded: %@>", self.Id, _title, _uploaded_at];
}

@end
