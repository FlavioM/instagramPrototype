//
//  Requester.h
//  instagramPrototype
//
//  Created by Flávio Marques on 04/12/16.
//  Copyright © 2016 com.prototypes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Requester : NSObject

+(NSDictionary *) getUserData:(NSString *) token;
+(NSDictionary *) getRecentData:(NSString *) token;
+(NSDictionary *) GetRequest:(NSString *) url;

@end
