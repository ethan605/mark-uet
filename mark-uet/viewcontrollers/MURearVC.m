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

@interface MURearVC ()

@end

@implementation MURearVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _menusData = @[@{@"title" : @"Home", @"cat" : @""},
                   @{@"title" : @"Filter by INT", @"cat" : @"INT"},
                   @{@"title" : @"Filter by MAT", @"cat" : @"MAT"},
                   @{@"title" : @"Filter by PHY", @"cat" : @"PHY"},];
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
    UINavigationController *navigation = (UINavigationController*)self.viewDeckController.centerController;
    MUMarkListingVC *markListingVC = (MUMarkListingVC*)navigation.viewControllers[0];
    [markListingVC filterMarksByCategory:_menusData[indexPath.row][@"cat"]];
    markListingVC.title = _menusData[indexPath.row][@"title"];
}

@end
