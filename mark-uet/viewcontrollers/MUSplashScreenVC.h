//
//  MUSplashScreenVC.h
//  mark-uet
//
//  Created by Ethan Nguyen on 5/2/13.
//  Copyright (c) 2013 UET. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MUMarkListingVC;

@interface MUSplashScreenVC : UIViewController {
    IBOutlet UIActivityIndicatorView *_vLoadingIndicator;
    
    MUMarkListingVC *_markListingVC;
}

@end