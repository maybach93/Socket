//
//  PVWSMessage.h
//  FastenTestProject
//
//  Created by Виталий on 30.05.16.
//  Copyright © 2016 Виталий. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PVUtility.h"

extern NSString *loginCustomerType;
extern NSString *customerApiTokenType;
extern NSString *customerErrorType;

@interface PVWSMessage : NSObject
@property (strong, nonatomic, readonly) NSString *type;
@property (strong, nonatomic, readonly) NSString *sequenceId;
@property (strong, nonatomic, readonly) NSDictionary *data;

#pragma mark - Methods

- (id) initWithType:(NSString *)type andData:(NSDictionary *)data;
- (id) initWithJSONString:(NSString *)jsonString;

- (NSString *) convertToJSON;
@end
