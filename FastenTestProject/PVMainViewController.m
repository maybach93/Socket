//
//  PVMainViewController.m
//  FastenTestProject
//
//  Created by  Poponov Vitaly on 31.05.16.
//  Copyright © 2016 Виталий. All rights reserved.
//

#import "PVMainViewController.h"
#import "PVToken.h"
#import "PVAuthService.h"

@interface PVMainViewController ()
@property (weak, nonatomic) IBOutlet UILabel *expirationCountDownLabel;
@property (strong, nonatomic) NSDate *expirationDate;
@end

@implementation PVMainViewController

#pragma mark - lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[PVAuthService sharedManager] isValidToken])
    {
        self.expirationDate = [[PVAuthService sharedManager] tokenExpirationDate];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(setTimeStamp) userInfo:nil repeats:YES];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - Layout view

- (void) setTimeStamp {
    if (![[PVAuthService sharedManager] isValidToken])
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    NSDictionary *countDownAttributes = @{@"termsTag" : @(YES), NSForegroundColorAttributeName : [UIColor blackColor],  NSFontAttributeName : [UIFont systemFontOfSize:17]};
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond
                                                                   fromDate:[NSDate dateWithTimeIntervalSinceNow:0]
                                                                     toDate:self.expirationDate
                                                                    options:NSCalendarWrapComponents];
    
    NSMutableAttributedString* timeAttributedString = [[NSMutableAttributedString alloc] initWithString:@"{0} d. {1} h. {2} min. {3} s." attributes:@{ NSForegroundColorAttributeName : [UIColor greenColor], NSFontAttributeName : [UIFont systemFontOfSize:13]}];
    
    NSAttributedString* days = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld", components.day] attributes:countDownAttributes];
    [timeAttributedString replaceCharactersInRange:[[timeAttributedString string] rangeOfString:@"{0}"] withAttributedString:days];
    NSAttributedString* hours = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld", components.hour] attributes:countDownAttributes];
    [timeAttributedString replaceCharactersInRange:[[timeAttributedString string] rangeOfString:@"{1}"] withAttributedString:hours];
    NSAttributedString* minutes = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld", components.minute] attributes:countDownAttributes];
    [timeAttributedString replaceCharactersInRange:[[timeAttributedString string] rangeOfString:@"{2}"] withAttributedString:minutes];
    NSAttributedString* seconds = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld", components.second] attributes:countDownAttributes];
    [timeAttributedString replaceCharactersInRange:[[timeAttributedString string] rangeOfString:@"{3}"] withAttributedString:seconds];
    self.expirationCountDownLabel.attributedText = timeAttributedString;
    
}
@end
