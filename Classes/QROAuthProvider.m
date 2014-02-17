//
//  QROAuthProvider.m
//  QROAuth
//
//  Created by Taro Kobayashi on 25/01/2014.
//  Copyright (c) 2014 Taro Kobayashi. All rights reserved.
//

#import <AFHTTPRequestOperationManager.h>
#import "NSDictionary+OARequestParameter.h"
#import "NSMutableURLRequest+Parameters.h"
#import "NSString+QRQueryParam.h"
#import "OAHMAC_SHA1SignatureProvider.h"
#import "OAMutableURLRequest.h"
#import "QROAuthProvider.h"

@implementation QROAuthProvider

- (id)initWithRequestTokenUrl: (NSString *)requestTokenUrl
               accessTokenUrl: (NSString *) accessTokenUrl
                 authorizeUrl: (NSString *) authorizeUrl
             oauthCallbackUrl: (NSString *) oauthCallbackUrl
{
    self = [super init];
    if (self)
    {
        self.requestTokenUrl = requestTokenUrl;
        self.accessTokenUrl = accessTokenUrl;
        self.authorizeUrl = authorizeUrl;
        self.oauthCallbackUrl = oauthCallbackUrl;
    }
    return self;
}

- (void)retrieveRequestToken: (OAConsumer *) oaConsumer
                    callback:(void (^)(NSString *, NSError *))callback
{
    NSURL *url = [NSURL URLWithString: self.requestTokenUrl];
    OAMutableURLRequest *request =
    [[OAMutableURLRequest alloc] initWithURL:url
                                    consumer:oaConsumer
                                       token:nil
                                       realm:nil
                           signatureProvider:nil];

    
    [request setHTTPMethod:@"POST"];
    [request setOAuthParameterName:@"oauth_callback" withValue:self.oauthCallbackUrl];
    [request prepare];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         callback(response, nil);
     }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"failure: %@, %@", operation, error);
         callback(nil, error);
    }];
    [operation start];
}

- (void)retrieveAccessToken: (OAConsumer *)oaConsumer
               requestToken: (NSString *)requestToken
                   verifier: (NSString *)verifier
                   callback:(void (^)(NSDictionary *res, NSError *error))callback
{
    NSURL *url = [NSURL URLWithString: self.accessTokenUrl];
    OAMutableURLRequest *request =
    [[OAMutableURLRequest alloc] initWithURL:url
                                    consumer:oaConsumer
                                       token:[[OAToken alloc] initWithKey:requestToken secret:nil]
                                       realm:nil
                           signatureProvider:nil];
    [request setHTTPMethod:@"POST"];
    [request setParameters:
     [@{@"oauth_verifier":verifier} castAsOAParameters]];
    [request prepare];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         NSLog(@"response: %@", response);
         callback([response parseAsQueryParam], nil);
     }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"failure: %@, %@", operation, error);
         callback(nil, error);
     }];
    [operation start];
}


@end
