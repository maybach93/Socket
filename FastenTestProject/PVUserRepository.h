//
//  PVUserRepository.h
//  FastenTestProject
//
//  Created by Виталий on 21.06.16.
//  Copyright © 2016 Виталий. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Validation.h"
#import "PVToken.h"
#import "PVUser.h"
#import "PVAPIService.h"

@interface PVUserRepository : NSObject
- (void) loginUser:(PVUser *)user withCompletion:(void (^)(PVToken *token))requestSuccess error:(void (^)(NSError *error))requestError;
@end
