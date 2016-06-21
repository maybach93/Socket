//
//  PVStartViewController.m
//  FastenTestProject
//
//  Created by  Poponov Vitaly on 31.05.16.
//  Copyright © 2016 Виталий. All rights reserved.
//

#import "PVStartViewController.h"
#import "PVAuthService.h"

#pragma mark - Constants
static NSString *loginVCSegueIdentifier = @"loginVCSegueIdentifier";
static NSString *mainVCSegueIdentifier = @"mainVCSegueIdentifier";

@interface PVStartViewController ()

@end

@implementation PVStartViewController

#pragma mark - lifecycle

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self routeController];
}

#pragma mark - Action

- (void) routeController{
    if ([[PVAuthService sharedManager] isValidToken])
    {
        [self performSegueWithIdentifier:mainVCSegueIdentifier sender:nil];
    }
    else
    {
        [self performSegueWithIdentifier:loginVCSegueIdentifier sender:nil];
    }
}
@end
