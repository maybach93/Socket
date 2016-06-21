//
//  PVAPIService.m
//  FastenTestProject
//
//  Created by Виталий on 30.05.16.
//  Copyright © 2016 Виталий. All rights reserved.
//

#import "PVAPIService.h"

@interface PVAPIService()
@property (strong, nonatomic) PVWSManager *wsManager;
@end

@implementation PVAPIService

#pragma mark - Requests

- (void) loginWithUserCredentials:(NSDictionary *)user withCompletion:(void (^)(PVToken *token))requestSuccess error:(void (^)(NSError *error))requestError{
    self.wsManager = [PVWSManager new];
    
    PVWSMessage *message = [[PVWSMessage alloc] initWithType:loginCustomerType andData:user];
    
    [self.wsManager sendMessage:message withCompletion:^(PVWSMessage *response) {
        if ([response.type isEqualToString:customerApiTokenType])
        {
            PVToken *token = [[PVToken alloc] initWithDictionary:response.data];
            requestSuccess(token);
        }
        else if ([response.type isEqualToString:customerErrorType])
        {
            NSError *error = [NSError errorWithDomain:response.data[@"error_description"] code:406 userInfo:response.data[@"in_event"]];
            requestError(error);
        }
    } error:^(NSError *error) {
        requestError(error);
    }];
}

@end
