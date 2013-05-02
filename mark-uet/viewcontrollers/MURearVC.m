//
//  MURearVC.m
//  mark-uet
//
//  Created by Ethan Nguyen on 5/2/13.
//  Copyright (c) 2013 UET. All rights reserved.
//

#import "MURearVC.h"
#import "IIViewDeckController.h"
#import "MUMarkListingVC.h"

@interface MURearVC () {
    NSArray *_filterCats;
}

@end

@implementation MURearVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _menusData = @[@"Home", @"Filter by INT", @"Filter by MAT", @"Filter by PHY"];
    _filterCats = @[@"", @"INT", @"MAT", @"PHY"];
}

- (void)viewDidUnload {
    _tblMenus = nil;
    [super viewDidUnload];
}

#pragma UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_menusData count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
    
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MenuCell"];
    
    cell.textLabel.text = _menusData[indexPath.row];
    
    return cell;
}

#pragma UITableViewDelegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewDeckController toggleLeftViewAnimated:YES];
    switch (indexPath.row) {
        case 0:
            break;
            
        default: {
            UINavigationController *navigation = (UINavigationController*)self.viewDeckController.centerController;
            MUMarkListingVC *markListingVC = (MUMarkListingVC*)navigation.viewControllers[0];
            [markListingVC filterMarksByCategory:_filterCats[indexPath.row]];
        }
            break;
    }
}

@end
