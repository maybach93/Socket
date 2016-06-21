//
//  PVAPIService.h
//  FastenTestProject
//
//  Created by Виталий on 30.05.16.
//  Copyright © 2016 Виталий. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PVUser.h"
#import "PVToken.h"
#import "PVWSManager.h"

@interface PVAPIService : NSObject

#pragma mark - Requests
- (void) loginWithUserCredentials:(NSDictionary *)user withCompletion:(void (^)(PVToken *token))requestSuccess error:(void (^)(NSError *error))requestError;
@end
