//
//  MUMarkListingVC.h
//  mark-uet
//
//  Created by Ethan Nguyen on 5/2/13.
//  Copyright (c) 2013 UET. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MUMarkListingVC : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITableView *_tblMarkListing;
    
    NSArray *_marksData;
}

- (void)filterMarksByCategory:(NSString*)category;

@end
