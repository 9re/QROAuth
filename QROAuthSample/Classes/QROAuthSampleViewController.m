//
//  QRSampleViewController.m
//  QROAuth
//
//  Created by Taro Kobayashi on 25/01/2014.
//  Copyright (c) 2014 Taro Kobayashi. All rights reserved.
//

#import "QROAuthSampleViewController.h"
#import "Config.h"

@interface QRSampleViewController ()

@end

@implementation QRSampleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLoginClicked:(id)sender
{
    OAConsumer *oaConsumer = [[OAConsumer alloc] initWithKey: TWITTER_CONSUMER_KEY secret: TWITTER_CONSUMER_SECRET_KEY];
    QROAuthProvider *authProvider =
    [[QROAuthProvider alloc] initWithRequestTokenUrl:@"https://api.twitter.com/oauth/request_token"
                                      accessTokenUrl:@"https://api.twitter.com/oauth/access_token"
                                        authorizeUrl:@"https://api.twitter.com/oauth/authorize"
                                    oauthCallbackUrl:@"http://tw.uwvm.mn/twitter/oauth_callback"];
    QROAuthLoginViewController *login =
    [[QROAuthLoginViewController alloc] initWithOAuthProvider:authProvider
                                                   oaConsumer:oaConsumer];
    login.delegate = self;
    [self presentViewController:login animated:YES completion:nil];
}

- (void) onFetchedAccessToken:(NSString *) accessToken
            accessTokenSecret:(NSString *) accessTokenSecret
{
    NSLog(@"accessToken: %@ accessTokenSecret: %@", accessToken, accessTokenSecret);
}


@end
