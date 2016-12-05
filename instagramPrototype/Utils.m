//
//  Utils.m
//  instagramPrototype
//
//  Created by Flávio Marques on 04/12/16.
//  Copyright © 2016 com.prototypes. All rights reserved.
//

#import "Utils.h"

#define TOKEN @"INSTAGRAM_TOKEN"


@implementation Utils


+(BOOL) saveToken:(NSString *) token
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:token forKey:TOKEN];
    return [defaults synchronize];
}

+(BOOL) deleteToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:TOKEN];
    return [defaults synchronize];
}

+(UserObj *) getUser
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *token = [defaults objectForKey:TOKEN];
    if(!token)
        return nil;
    UserObj *userObj = [Parser parseUserObj:[Requester getUserData:token]];
    return userObj;
}

+(NSArray *) getRecentMedia
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *token = [defaults objectForKey:TOKEN];
    NSArray *arr = [Parser parseRecent:[Requester getRecentData:token]];
    return arr;
}

+(BOOL) isLoggedIn
{
    UserObj *user = [Utils getUser];
    if(user)
        return true;
    return false;
    
}


@end
