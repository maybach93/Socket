//
//  PVWSManager.m
//  FastenTestProject
//
//  Created by Виталий on 30.05.16.
//  Copyright © 2016 Виталий. All rights reserved.
//

#import "PVWSManager.h"

typedef void (^ResuestSuccess)(PVWSMessage *response);
typedef void (^ResuestError)(NSError *error);

@interface PVWSManager()
@property (strong, nonatomic) SRWebSocket *webSocket;

@property (strong, nonatomic) PVWSMessage *requestMessage;

@property (nonatomic, copy) ResuestSuccess successBlock;
@property (nonatomic, copy) ResuestError errorBlock;
@end

@implementation PVWSManager

#pragma mark - Connection

- (void)connectWebSocket {
    self.webSocket.delegate = nil;
    self.webSocket = nil;
    
    NSString *urlString = @"ws://52.29.182.220:8080/customer-gateway/customer";
    self.webSocket  = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:urlString]];
    self.webSocket.delegate = self;
    [self.webSocket open];
    
}

- (void) sendMessage:(PVWSMessage *)message withCompletion:(void (^)(PVWSMessage *response))requestSuccess error:(void (^)(NSError *error))requestError{
    [self connectWebSocket];

    self.requestMessage = message;
    self.successBlock = requestSuccess;
    self.errorBlock = requestError;
}

#pragma mark - SRWebSocket delegate

- (void)webSocketDidOpen:(SRWebSocket *)newWebSocket {
    self.webSocket = newWebSocket;
    [self.webSocket send:[self.requestMessage convertToJSON]];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    [self connectWebSocket];
    self.errorBlock(error);
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    PVWSMessage *messageModel = [[PVWSMessage alloc] initWithJSONString:message];
    if ([messageModel.sequenceId isEqualToString: self.requestMessage.sequenceId])
    {
        self.successBlock(messageModel);
    }
    [self.webSocket close];
}

@end
