//
//  QROAuthLoginViewController.h
//  QROAuth
//
//  Created by Taro Kobayashi on 25/01/2014.
//  Copyright (c) 2014 Taro Kobayashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OAConsumer.h"
#import "QROAuthDelegate.h"
#import "QROAuthProvider.h"


@interface QROAuthLoginViewController : UIViewController<UIWebViewDelegate>
@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property (retain, nonatomic) IBOutlet UIButton *cancelButton;
@property (retain) QROAuthProvider *oauthProvider;
@property (retain) OAConsumer *oaConsumer;
@property (retain) id <QROAuthDelegate> delegate;
- (id)initWithOAuthProvider: (QROAuthProvider *)oauthProvider
                 oaConsumer: (OAConsumer *) oaConsumer;
- (IBAction)onCancelClicked:(id)sender;
@end
