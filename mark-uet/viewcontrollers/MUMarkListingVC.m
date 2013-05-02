//
//  MUMarkListingVC.m
//  mark-uet
//
//  Created by Ethan Nguyen on 5/2/13.
//  Copyright (c) 2013 UET. All rights reserved.
//

#import "MUMarkListingVC.h"
#import "MUApi.h"
#import "MMark.h"
#import "MUMarkCell.h"

@interface MUMarkListingVC () {
    MUMarkCell *_tmpMarkCell;
}

@end

@implementation MUMarkListingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _marksData = [[MUApi sharedApi] marksData];
    
    _tmpMarkCell = [[MUMarkCell alloc] init];
}

#pragma UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_marksData count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MUMarkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MarkCell"];
    
    if (!cell)
        cell = [[MUMarkCell alloc] init];
    
    [cell updateCellWithData:_marksData[indexPath.row]];
    
    return cell;
}

#pragma UITableViewDelegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tmpMarkCell updateCellWithData:_marksData[indexPath.row]];
    
    return _tmpMarkCell.heightToFit;
}

@end
