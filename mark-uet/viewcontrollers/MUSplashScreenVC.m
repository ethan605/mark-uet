//
//  MUSplashScreenVC.m
//  mark-uet
//
//  Created by Ethan Nguyen on 5/2/13.
//  Copyright (c) 2013 UET. All rights reserved.
//

#import "MUSplashScreenVC.h"
#import "MUApi.h"
#import "IIViewDeckController.h"
#import "MUMarkListingVC.h"

@interface MUSplashScreenVC ()

- (void)gotoMarkListing;

@end

@implementation MUSplashScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_vLoadingIndicator startAnimating];
    
    [[MUApi sharedApi] getAllMarks:^() {
        [_vLoadingIndicator stopAnimating];
        [self gotoMarkListing];
    } error:^(NSError *error) {
        [_vLoadingIndicator stopAnimating];
        [[MUApi sharedApi] showErrorAlert:error];
    }];
}

- (void)gotoMarkListing {
    _markListingVC = [[MUMarkListingVC alloc] init];
    [self presentViewController:_markListingVC animated:YES completion:NULL];
}

@end
