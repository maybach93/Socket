//
//  PVWSMessage.m
//  FastenTestProject
//
//  Created by Виталий on 30.05.16.
//  Copyright © 2016 Виталий. All rights reserved.
//

#import "PVWSMessage.h"

#pragma mark - Constants

const NSString *loginCustomerType = @"LOGIN_CUSTOMER";
const NSString *customerApiTokenType = @"CUSTOMER_API_TOKEN";
const NSString *customerErrorType = @"CUSTOMER_ERROR";

const NSString *requestKeyType = @"type";
const NSString *requestKeyData = @"data";
const NSString *requestKeySequenceId = @"sequence_id";

@implementation PVWSMessage

#pragma mark - Initializer

- (id) initWithType:(NSString *)type andData:(NSDictionary *)data{
    self = [super init];
    if (self)
    {
        _type = type;
        _data = data;
        _sequenceId = [PVUtility randomStringWithLength:14];
    }
    return self;
}

- (id) initWithJSONString:(NSString *)jsonString{
    NSError *error = nil;
    NSDictionary *requestDict = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    self = [super init];
    if (self)
    {
        _type = requestDict[requestKeyType];
        _data = requestDict[requestKeyData];
        _sequenceId = requestDict[requestKeySequenceId];
    }
    return self;
}

#pragma mark - Logic

- (NSString *) convertToJSON {
    NSDictionary *requestDict = @{requestKeyType : self.type, requestKeyData : self.data, requestKeySequenceId : self.sequenceId};
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:requestDict options:0 error:nil];
    return [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
}
@end
