//
//  MUMarkCell.h
//  mark-uet
//
//  Created by Ethan Nguyen on 5/2/13.
//  Copyright (c) 2013 UET. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMark;

@interface MUMarkCell : UITableViewCell {
    IBOutlet UILabel *_lblCode;
    IBOutlet UILabel *_lblTitle;
    IBOutlet UILabel *_lblUploaded;
}

@property (nonatomic, assign, readonly) CGFloat heightToFit;

- (void)updateCellWithData:(MMark*)markData;

@end
