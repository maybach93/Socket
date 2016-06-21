//
//  PVToken.h
//  FastenTestProject
//
//  Created by Виталий on 30.05.16.
//  Copyright © 2016 Виталий. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PVToken : NSObject
@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSDate *expirationDate;

#pragma mark - Methods
- (id) initWithDictionary:(NSDictionary *) dictToken;
@end
