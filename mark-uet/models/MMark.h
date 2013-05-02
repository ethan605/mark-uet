//
//  MMark.h
//  mark-uet
//
//  Created by Ethan Nguyen on 5/2/13.
//  Copyright (c) 2013 UET. All rights reserved.
//

#import "MBase.h"

@interface MMark : MBase

@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *uploaded_at;

@end
