//
//  QROAuthLoginViewController.m
//  QROAuth
//
//  Created by Taro Kobayashi on 25/01/2014.
//  Copyright (c) 2014 Taro Kobayashi. All rights reserved.
//

#import "QROAuthLoginViewController.h"
#import "QRResourceUtil.h"
#import "NSString+QRQueryParam.h"

#define NIB_NAME @"QROAuthLoginViewController"

@interface QROAuthLoginViewController ()

@end

@implementation QROAuthLoginViewController

- (id)initWithOAuthProvider:(QROAuthProvider *)oauthProvider
                 oaConsumer: (OAConsumer *) oaConsumer
{
    self = [super
            initWithNibName:nil
            bundle:nil];
    if (self)
    {
        self.oauthProvider = oauthProvider;
        self.oaConsumer = oaConsumer;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getRequestToken];
}

- (void)getRequestToken
{
    [self.oauthProvider retrieveRequestToken:self.oaConsumer
                                    callback:^(NSString *data, NSError *error) {
                                        if (!error && data)
                                        {
                                            [self showLogin: data];
                                        }
                                    }];
}

- (void)showLogin: (NSString *)data
{
    NSDictionary *params = [data parseAsQueryParam];
    
    if ([@"true" isEqualToString:[params objectForKey:@"oauth_callback_confirmed"]])
    {
        NSString *oauth_token = [params objectForKey:@"oauth_token"];
        [self.webView loadRequest:
         [NSURLRequest requestWithURL:
          [NSURL URLWithString:
           [NSString stringWithFormat:
            @"%@?oauth_token=%@", self.oauthProvider.authorizeUrl, oauth_token]]]];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // do something
}

- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = [request.URL absoluteString];
    NSLog(@"url:%@", url);
    if ([url hasPrefix: self.oauthProvider.oauthCallbackUrl])
    {
        NSString *queryParams = [url substringFromIndex:[self.oauthProvider.oauthCallbackUrl length] + 1];
        NSDictionary *params = [queryParams parseAsQueryParam];
        [self.oauthProvider retrieveAccessToken:self.oaConsumer
                                   requestToken:[params valueForKey:@"oauth_token"]
                                       verifier:[params valueForKey:@"oauth_verifier"]
                                       callback:^(NSDictionary *res, NSError *error) {
                                           NSLog(@"res: %@ error: %@", res, error);
                                           if (!error && res && self.delegate)
                                           {
                                               [self.delegate onFetchedAccessToken:[res valueForKey:@"oauth_token"]
                                                                 accessTokenSecret:[res valueForKey:@"oauth_token_secret"]];
                                               [self dismissViewControllerAnimated:YES completion:nil];
                                           }
                                       }];
        return NO;
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onCancelClicked:(id)sender
{
    [self dismiss];
}

- (void)dismiss
{
    __weak id theDelegate = self.delegate;
    [self dismissViewControllerAnimated:YES completion:^{
        if (theDelegate)
        {
            [theDelegate onFailure];
        }
    }];
}

@end
