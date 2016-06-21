//
//  PVAuthService.h
//  FastenTestProject
//
//  Created by  Poponov Vitaly on 31.05.16.
//  Copyright © 2016 Виталий. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PVToken.h"

@interface PVAuthService : NSObject
+ (PVAuthService *) sharedManager;

- (void) setToken:(PVToken *)token;
- (void) resetToken;

- (BOOL) isValidToken;
- (NSDate *)tokenExpirationDate;


@end
