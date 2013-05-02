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
#import "MURearVC.h"
#import "MUMarkListingVC.h"

@interface MUSplashScreenVC ()

- (void)gotoMarkListing;
- (void)getAllMarks;

@end

@implementation MUSplashScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getAllMarks];
}

- (void)gotoMarkListing {
    MURearVC *rearVC = [[MURearVC alloc] init];
    MUMarkListingVC *markListingVC = [[MUMarkListingVC alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:markListingVC];
    
    _viewDeck = [[IIViewDeckController alloc] initWithCenterViewController:navigation leftViewController:rearVC];
    [_viewDeck setLeftSize:100];
    [self presentViewController:_viewDeck animated:YES completion:NULL];
}

- (void)getAllMarks {
    [_vLoadingIndicator startAnimating];
    
    [[MUApi sharedApi] getAllMarks:^() {
        [_vLoadingIndicator stopAnimating];
        [self gotoMarkListing];
    } error:^(NSError *error) {
        [_vLoadingIndicator stopAnimating];
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:[NSString stringWithFormat:@"Error code %d - %@", error.code, error.domain]
                                  message:[NSString stringWithFormat:@"%@", error.userInfo]
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:@"Retry", nil];
        
        [alertView show];
    }];
}

#pragma UIAlertViewDelegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != 1)
        return;
    
    [self getAllMarks];
}

@end
