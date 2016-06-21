//
//  PVUserRepository.m
//  FastenTestProject
//
//  Created by Виталий on 21.06.16.
//  Copyright © 2016 Виталий. All rights reserved.
//

#import "PVUserRepository.h"

const NSString *emailKey = @"email";
const NSString *passwordKey = @"password";

@interface PVUserRepository()
@property (strong, nonatomic) PVAPIService *apiService;
@property (strong, nonatomic) PVUser *user;
@end

@implementation PVUserRepository

- (void) loginUser:(PVUser *)user withCompletion:(void (^)(PVToken *token))requestSuccess error:(void (^)(NSError *error))requestError{
    self.user = user;
    
    NSError *validationError = [self validateUser];
    if (validationError)
    {
        requestError(validationError);
    }
    else
    {
        self.apiService = [PVAPIService new];
        [self.apiService loginWithUserCredentials:[self dictionaryFromUser] withCompletion:^(PVToken *token) {
            requestSuccess(token);
        } error:^(NSError *error) {
            requestError(error);
        }];
    }
}

#pragma mark - Validation

- (NSError *) validateUser{
    NSError *error = nil;
    NSString *errorMessage = nil;
    if (![self.user.email validateEmail])
    {
        errorMessage = @"Invalid email";
    }
    
    if ([self.user.password length] < 6)
    {
        errorMessage = @"Password must be at least 6 characters";
    }
    
    if (errorMessage)
    {
        error = [[NSError alloc] initWithDomain:errorMessage code:406 userInfo:nil];
    }
    return error;
}

#pragma mark - Logic

- (NSDictionary *) dictionaryFromUser{
    return @{emailKey : self.user.email, passwordKey : self.user.password};
}

@end
