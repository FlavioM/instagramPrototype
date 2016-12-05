//
//  Utils.h
//  instagramPrototype
//
//  Created by Flávio Marques on 04/12/16.
//  Copyright © 2016 com.prototypes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Requester.h"
#import "Parser.h"
#import "UserObj.h"
#import "RecentMedia.h"

@interface Utils : NSObject


+(UserObj *) getUser;
+(NSArray *) getRecentMedia;
+(BOOL) saveToken:(NSString *) token;
+(BOOL) deleteToken;
+(BOOL) isLoggedIn;


@end
