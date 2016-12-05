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

/*!
 @brief Save the user's retrieved token.
 
 @discussion Method used to save a user's <i>access_token</i> in NSUserDefaults.
 
 
 @param token   The access_token
 
 @return BOOL returns the success of the operation.
 
 */
+(BOOL) saveToken:(NSString *) token
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:token forKey:TOKEN];
    return [defaults synchronize];
}

/*!
 @brief Delete the user's saved token.
 
 @discussion Method used to delete a user's <i>access_token</i> from NSUserDefaults.
 
 @return BOOL returns the success of the operation.
 
 */
+(BOOL) deleteToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:TOKEN];
    return [defaults synchronize];
}

/*!
 @brief Retrieve a UserObj representation of the User's profile.
 
 @discussion Method used to make a remote request to retrieve the User's profile and parse it into an UserObj object.
 
 
 @return UserObj The UserObj of the currently logged in User.
 
 
 */
+(UserObj *) getUser
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *token = [defaults objectForKey:TOKEN];
    if(!token)
        return nil;
    UserObj *userObj = [Parser parseUserObj:[Requester getUserData:token]];
    return userObj;
}

/*!
 @brief Retrieve the Recent Media posts associated with this user.
 
 @discussion Method used to get the currently logged in user's Recent posts.
 
 @return NSArray returns the user's latest Media publications.
 
 */
+(NSArray *) getRecentMedia
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *token = [defaults objectForKey:TOKEN];
    NSArray *arr = [Parser parseRecent:[Requester getRecentData:token]];
    return arr;
}


/*!
 @brief Check if the user is logged in.
 
 @discussion Method used to check if a user has a valid token saved in the device's NSUserDefaults.
 
 @return BOOL returns TRUE when the user has a locally saved token, FALSE when he doesn't.
 
 */
+(BOOL) isLoggedIn
{
    UserObj *user = [Utils getUser];
    if(user)
        return TRUE;
    return FALSE;
    
}


@end
