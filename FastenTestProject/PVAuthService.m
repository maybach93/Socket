//
//  PVAuthService.m
//  FastenTestProject
//
//  Created by  Poponov Vitaly on 31.05.16.
//  Copyright © 2016 Виталий. All rights reserved.
//

#import "PVAuthService.h"
static NSString *tokenArchiveKey = @"token_archive";
@implementation PVAuthService

#pragma mark - Singleton 

+ (PVAuthService *) sharedManager {
    
    static PVAuthService *sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[PVAuthService alloc] init];
        
    });
    return sharedManager;
}

#pragma mark - setter

- (void) setToken:(PVToken *)token{
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:token] forKey:tokenArchiveKey];
}

- (void) resetToken{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey: tokenArchiveKey];
}

#pragma mark - getter

- (PVToken *) getToken{
    NSData *savedData = [[NSUserDefaults standardUserDefaults] objectForKey:tokenArchiveKey];
    if (savedData != nil)
    {
        return [NSKeyedUnarchiver unarchiveObjectWithData:savedData];
        
    }
    return nil;
}

- (BOOL) isValidToken{
    PVToken *token = [self getToken];
    
    if (token)
    {
        NSTimeInterval expirationTimestamp = [token.expirationDate timeIntervalSince1970];
        NSTimeInterval currentTimestamp = [[NSDate date] timeIntervalSince1970];
        if (currentTimestamp >= expirationTimestamp)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    return NO;
}

- (NSDate *)tokenExpirationDate{
    PVToken *token = [self getToken];
    
    if (token)
    {
        return token.expirationDate;
    }
    return nil;
}
@end
