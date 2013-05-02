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
#import "TSMiniWebBrowser.h"
#import "SVPullToRefresh.h"
#import "IIViewDeckController.h"

@interface MUMarkListingVC () {
    MUMarkCell *_tmpMarkCell;
    NSString *_filterCat;
}

- (void)setupFilterButton;
- (void)toggleFilterMenu;
- (void)refreshMarksList;

@end

@implementation MUMarkListingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Home";
    
    _marksData = [[MUApi sharedApi] marksData];
    _tmpMarkCell = [[MUMarkCell alloc] init];
    _filterCat = @"";
    
    MUMarkListingVC *selfDelegate = self;
    
    [_tblMarkListing addPullToRefreshWithActionHandler:^{
        [selfDelegate refreshMarksList];
    }];
    
    [self setupFilterButton];
}

- (void)setupFilterButton {
    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter"
                                                                     style:UIBarButtonItemStyleDone
                                                                    target:self
                                                                    action:@selector(toggleFilterMenu)];
    self.navigationItem.leftBarButtonItem = filterButton;
}

- (void)toggleFilterMenu {
    [self.navigationController.viewDeckController toggleLeftViewAnimated:YES];
}

- (void)filterMarksByCategory:(NSString *)category {
    _filterCat = category;
    
    if ([_filterCat isEqualToString:@""])
        _marksData = [[MUApi sharedApi] marksData];
    else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.category == %@", category];
        _marksData = [[[MUApi sharedApi] marksData] filteredArrayUsingPredicate:predicate];
    }
    
    [_tblMarkListing reloadData];
    [_tblMarkListing scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                           atScrollPosition:UITableViewScrollPositionTop
                                   animated:YES];
}

- (void)refreshMarksList {
    [[MUApi sharedApi] getAllMarks:^() {
        [_tblMarkListing.pullToRefreshView stopAnimating];
        [self filterMarksByCategory:_filterCat];
    } error:NULL];
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
    MMark *mark = _marksData[indexPath.row];
    TSMiniWebBrowser *miniWebBrowser = [[TSMiniWebBrowser alloc] initWithUrl:[NSURL URLWithString:mark.link]];
    miniWebBrowser.mode = TSMiniWebBrowserModeNavigation;
    miniWebBrowser.title = mark.title;
    [self.navigationController pushViewController:miniWebBrowser animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tmpMarkCell updateCellWithData:_marksData[indexPath.row]];
    return _tmpMarkCell.heightToFit;
}

@end
