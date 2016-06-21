//
//  PVWSManager.h
//  FastenTestProject
//
//  Created by Виталий on 30.05.16.
//  Copyright © 2016 Виталий. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SocketRocket/SRWebSocket.h>
#import "PVWSMessage.h"

@interface PVWSManager : NSObject <SRWebSocketDelegate>
- (void) sendMessage:(PVWSMessage *)message withCompletion:(void (^)(PVWSMessage *response))requestSuccess error:(void (^)(NSError *error))requestError;
@end
