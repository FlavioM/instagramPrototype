//
//  Parser.h
//  instagramPrototype
//
//  Created by Flávio Marques on 04/12/16.
//  Copyright © 2016 com.prototypes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserObj.h"
#import "RecentMedia.h"
#import "IGImage.h"


@interface Parser : NSObject

+(UserObj *) parseUserObj:(NSDictionary *) dictionary;
+(NSArray *) parseRecent:(NSDictionary *) dictionary;

+(NSArray *) parseUsersInPhoto:(NSArray *) users;
+(IGImage *) parseIGImage:(NSDictionary *) dictionary;
+(RecentMedia *) parseRecentMedia:(NSDictionary *) dictionary;
+(NSArray *) parseImages:(NSArray *) dictionary;

@end
