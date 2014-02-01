//
//  QRSampleViewController.h
//  QROAuth
//
//  Created by Taro Kobayashi on 25/01/2014.
//  Copyright (c) 2014 Taro Kobayashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QROAuth.h"

@interface QRSampleViewController : UIViewController <QROAuthDelegate>
@property (retain, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)onLoginClicked:(id)sender;
@end
