//
//  PVToken.m
//  FastenTestProject
//
//  Created by Виталий on 30.05.16.
//  Copyright © 2016 Виталий. All rights reserved.
//

#import "PVToken.h"

#pragma mark - Constants

const NSString *apiTokenKey = @"api_token";
const NSString *expirationDateKey = @"api_token_expiration_date";

@implementation PVToken

#pragma mark - NSCoder

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if( self )
    {
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.expirationDate = [aDecoder decodeObjectForKey:@"expirationDate"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.token forKey:@"token"];
    [encoder encodeObject:self.expirationDate forKey:@"expirationDate"];
}

#pragma mark - Initializer

- (id) initWithDictionary:(NSDictionary *) dictToken{

    self = [super init];
    if (self)
    {
        _token = dictToken[apiTokenKey];
        
        [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
        _expirationDate = [formatter dateFromString:dictToken[expirationDateKey]];
    }
    return self;
}
@end
