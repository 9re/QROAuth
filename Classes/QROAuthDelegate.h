//
//  QROAuthDelegate.h
//  QROAuth
//
//  Created by Taro Kobayashi on 27/01/2014.
//  Copyright (c) 2014 Taro Kobayashi. All rights reserved.
//

#ifndef QROAuth_QROAuthDelegate_h
#define QROAuth_QROAuthDelegate_h

@protocol QROAuthDelegate <NSObject>
@required
- (void) onFetchedAccessToken:(NSString *) accessToken
            accessTokenSecret:(NSString *) accessTokenSecret;
- (void) onFailure;
@end

#endif
