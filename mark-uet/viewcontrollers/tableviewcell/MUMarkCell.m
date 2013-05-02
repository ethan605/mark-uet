//
//  MUMarkCell.m
//  mark-uet
//
//  Created by Ethan Nguyen on 5/2/13.
//  Copyright (c) 2013 UET. All rights reserved.
//

#import "MUMarkCell.h"
#import "MMark.h"

@implementation MUMarkCell

- (id)init {
    if (self = [super init]) {
        self = LoadNibNameFromSameClass();
    }
    
    return self;
}

- (void)updateCellWithData:(MMark *)markData {
    _lblCode.text = markData.code;
    _lblTitle.text = markData.title;
    _lblUploaded.text = markData.uploaded_at;
    
    CGSize size = [_lblTitle sizeThatFits:CGSizeMake(_lblTitle.frame.size.width, MAXFLOAT)];
    _heightToFit = _lblTitle.frame.origin.y + size.height + 36;
}

@end
