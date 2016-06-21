//
//  PVLoginViewController.m
//  FastenTestProject
//
//  Created by Виталий on 30.05.16.
//  Copyright © 2016 Виталий. All rights reserved.
//

#import "PVLoginViewController.h"
#import "NSString+Validation.h"
#import "MBProgressHUD.h"
#import "PVUser.h"
#import "PVAuthService.h"

@interface PVLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *alertLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginFormBottomSpaceConstraint;

@property (assign, nonatomic) BOOL isKeyboardShown;

@property (strong, nonatomic) PVUser *user;
@end

#pragma mark - Constants
const NSUInteger maxInputItemLenght = 50;
const NSUInteger baseLoginFormBottomSpace = 150;
const NSUInteger bottomSpaceOffset = 5;
const NSUInteger loginFormAnimationDuration = .25;
@implementation PVLoginViewController

#pragma mark - Lifecycle 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
    self.isKeyboardShown = NO;
}

#pragma mark - Action

- (void) loginUser {
    self.user = [PVUserCredentials new];
    self.user.email = self.emailTextField.text;
    self.user.password = self.passwordTextField.text;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.user loginWithCompletion:^(PVToken *token) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        [[PVAuthService sharedManager] setToken:token];
        [self dismissViewControllerAnimated:YES completion:nil];
    } error:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        [self showAlertWithMessage:error.domain];
    }];
}

#pragma mark - IBAction

- (IBAction)loginAction:(id)sender {
    [self loginUser];
}

#pragma mark - UITextField delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    [self resetAlertLabel];
    
    NSString *resultString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([resultString length] > maxInputItemLenght)
    {
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField isEqual:self.emailTextField])
    {
        [self.passwordTextField becomeFirstResponder];
    }
    else if ([textField isEqual:self.passwordTextField])
    {
        [self.passwordTextField resignFirstResponder];
        [self loginUser];
    }
    return YES;
}

#pragma mark - keyboard layout

- (void) dismissKeyboard {
    [self.view endEditing:YES];
}

- (void)keyboardWillHide:(NSNotification *)n
{
    self.loginFormBottomSpaceConstraint.constant = baseLoginFormBottomSpace;
    [UIView animateWithDuration:loginFormAnimationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
    self.isKeyboardShown = NO;
}

- (void)keyboardWillShow:(NSNotification *)n
{
    if (self.isKeyboardShown)
    {
        return;
    }
    NSDictionary* userInfo = [n userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    self.loginFormBottomSpaceConstraint.constant = keyboardSize.height + bottomSpaceOffset;
    [UIView animateWithDuration:loginFormAnimationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
    self.isKeyboardShown = YES;
}

#pragma mark - Alert

- (void) showAlertWithMessage:(NSString *)message{
    self.alertLabel.text = message;
    self.alertLabel.hidden = NO;
}

- (void) resetAlertLabel{
    self.alertLabel.text = @"";
    self.alertLabel.hidden = YES;
}
@end
