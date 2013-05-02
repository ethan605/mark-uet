//
//  MURearVC.h
//  mark-uet
//
//  Created by Ethan Nguyen on 5/2/13.
//  Copyright (c) 2013 UET. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MURearVC : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITableView *_tblMenus;
    NSArray *_menusData;
}

@end
