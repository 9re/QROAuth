//
//  QROAuthProvider.h
//  QROAuth
//
//  Created by Taro Kobayashi on 25/01/2014.
//  Copyright (c) 2014 Taro Kobayashi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OAConsumer.h"

@interface QROAuthProvider : NSObject
@property (retain) NSString *requestTokenUrl;
@property (retain) NSString *accessTokenUrl;
@property (retain) NSString *authorizeUrl;
@property (retain) NSString *oauthCallbackUrl;
- (id)initWithRequestTokenUrl: (NSString *)requestTokenUrl
               accessTokenUrl: (NSString *)accessTokenUrl
                 authorizeUrl: (NSString *)authorizeUrl
             oauthCallbackUrl: (NSString *)oauthCallbackUrl;
- (void)retrieveRequestToken: (OAConsumer *)oaConsumer
                    callback:(void (^)(NSString *callbakUrl, NSError *error))callback;
- (void)retrieveAccessToken: (OAConsumer *)oaConsumer
               requestToken: (NSString *)requestToken
                   verifier: (NSString *)verifier
                    callback:(void (^)(NSDictionary *res, NSError *error))callback;

@end
