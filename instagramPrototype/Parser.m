//
//  Parser.m
//  instagramPrototype
//
//  Created by Flávio Marques on 04/12/16.
//  Copyright © 2016 com.prototypes. All rights reserved.
//

#import "Parser.h"

//user KWs
#define KW_ID @"id"
#define KW_BIO @"bio"
#define KW_FOLLOWERS @"followed_by"
#define KW_FOLLOWING @"follows"
#define KW_MEDIA_COUNT @"media"
#define KW_COUNTS @"counts"
#define KW_FULLNAME @"full_name"
#define KW_USERNAME @"username"
#define KW_WEBSITE @"website"
#define KW_IMAGEURL @"profile_picture"
#define KW_DATA @"data"

//img KWs
#define KW_IMAGE_LOWRESOLUTION @"low_resolution"
#define KW_IMAGE_ORIGINALRESOLUTION @"standard_resolution"
#define KW_IMAGE_THUMBNAILRESOLUTION @"thumbnail"
#define KW_IMG_URL @"url"
#define KW_IMG_WIDTH @"width"
#define KW_IMG_HEIGHT @"height"

//recentMedia KWs
#define KW_RECENT_ATTRIBUTION @"attribution"
#define KW_RECENT_TAGS @"tags"
#define KW_RECENT_TYPE @"type"
#define KW_RECENT_LOCATION @"location"
#define KW_RECENT_COMMENTS @"comments"
#define KW_RECENT_COMMENTS_COUNT @"count"
#define KW_RECENT_FILTER @"filter"
#define KW_RECENT_CREATEDTIME @"created_time"
#define KW_RECENT_LINK @"link"
#define KW_RECENT_LIKES @"likes"
#define KW_RECENT_LIKES_COUNT @"count"
#define KW_RECENT_IMAGES @"images"
#define KW_RECENT_USERSINPHOTO @"users_in_photo"
#define KW_RECENT_CAPTION @"caption"
#define KW_RECENT_USERHASLIKED @"user_has_liked"
#define KW_RECENT_ID @"id"
#define KW_RECENT_USER @"user"


@implementation Parser

/*!
 @brief Quickly build a UserObj object from an NSDictionary.
 
 @discussion Method used to parse the NSDictionary representation of the User's Profile into it's UserObj object.
 
 @param dictionary   The NSDictionary retrieved from the <i>[Requester getUserData:token]</i>
 
 @return UserObj returns the UserObj object representation of the User's profile.
 */
+(UserObj *) parseUserObj:(NSDictionary *) dictionary
{
    if(!dictionary)
        return nil;
    
    if([dictionary objectForKey:KW_DATA] != nil)
        dictionary = [dictionary objectForKey:KW_DATA];
    UserObj *obj = [[UserObj alloc] init];
    obj._id = [dictionary objectForKey:KW_ID];
    obj.bio = [dictionary objectForKey:KW_BIO];
    NSDictionary *dictionary2 = [dictionary objectForKey:KW_COUNTS];
    obj.followers = [[dictionary2 objectForKey:KW_FOLLOWERS] intValue];
    obj.following = [[dictionary2 objectForKey:KW_FOLLOWING] intValue];
    obj.media = [[dictionary2 objectForKey:KW_MEDIA_COUNT] intValue];
    obj.fullName = [dictionary objectForKey:KW_FULLNAME];
    obj.username = [dictionary objectForKey:KW_USERNAME];
    obj.website = [dictionary objectForKey:KW_WEBSITE];
    obj.imageUrl = [dictionary objectForKey:KW_IMAGEURL];
    
    return obj;
}

/*!
 @brief Parse an array of RecentMedia objects from an NSDictionary.
 
 @discussion Method used to parse the RecentMedia objects in an NSDictionary.
 
 @param dictionary   The NSDictionary containing the required data. Can be easily retrieved from <i>[Requester getRecentData:token]</i>
 
 @return NSArray returns an array containing the RecentMedia objects represented in the NSDictionary.
 */
+(NSArray *) parseRecent:(NSDictionary *)dictionary
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    if(!dictionary)
        return nil;
    for(NSDictionary *dic in [dictionary objectForKey:@"data"]){
        [arr addObject:[Parser parseRecentMedia:dic]];
    }
    
    return arr;
}

/*!
 @brief Quickly build an IGImage object from an NSDictionary.
 
 @discussion Method used to parse the NSDictionary representation of the image into it's IGImage object.
 
 @param dictionary   The NSDictionary representing the Media post's image.
 
 @return IGImage returns an IGImage object representation of the Media post's image.
 
 */
+(IGImage *) parseIGImage:(NSDictionary *) dictionary
{
        IGImage *img = [[IGImage alloc] init];
        if([dictionary objectForKey:KW_IMAGE_LOWRESOLUTION]){
            img.type = TYPE_LOWRESOLUTION;
            dictionary = [dictionary objectForKey:KW_IMAGE_LOWRESOLUTION];
        }
        if([dictionary objectForKey:KW_IMAGE_ORIGINALRESOLUTION]){
            img.type = TYPE_LOWRESOLUTION;
            dictionary = [dictionary objectForKey:KW_IMAGE_ORIGINALRESOLUTION];
        }
        if([dictionary objectForKey:KW_IMAGE_THUMBNAILRESOLUTION]){
            img.type = TYPE_THUMBNAIL;
            dictionary = [dictionary objectForKey:KW_IMAGE_THUMBNAILRESOLUTION];
        }
        
        
        img.url = [dictionary objectForKey:KW_IMG_URL];
        img.width = [[dictionary objectForKey:KW_IMG_WIDTH] intValue];
        img.height = [[dictionary objectForKey:KW_IMG_HEIGHT] intValue];
        
        
    return img;
}

/*!
 @brief Quickly build a RecentMedia object from an NSDictionary.
 
 @discussion Method used to parse the NSDictionary representation of the object into it's RecentMedia object.
 
 @param dictionary   The NSDictionary containing the RecentMedia object's representation.
 
 @return UserObj returns the RecentMedia object representation of a Media post.
 */
+(RecentMedia *) parseRecentMedia:(NSDictionary *) dictionary
{
    

    RecentMedia *rm = [[RecentMedia alloc] init];
    rm.attribution = [dictionary objectForKey:KW_RECENT_ATTRIBUTION];
    rm.tags = [dictionary objectForKey:KW_RECENT_TAGS];
    rm.type = [dictionary objectForKey:KW_RECENT_TYPE];
    rm.location = [dictionary objectForKey:KW_RECENT_LOCATION];
    rm.comments = [[[dictionary objectForKey:KW_RECENT_COMMENTS] objectForKey:KW_RECENT_COMMENTS_COUNT] intValue];
    rm.filter = [dictionary objectForKey:KW_RECENT_FILTER];
    rm.createdTime = [dictionary objectForKey:KW_RECENT_CREATEDTIME];
    rm.link = [dictionary objectForKey:KW_RECENT_LINK];
    rm.likes = [[[dictionary objectForKey:KW_RECENT_LIKES] objectForKey:KW_RECENT_LIKES_COUNT] intValue];
    rm.images = [Parser parseImages:[dictionary objectForKey:KW_RECENT_IMAGES]];
    rm.usersInPhoto = [Parser parseUsersInPhoto:[dictionary objectForKey:KW_RECENT_USERSINPHOTO]];
    rm.caption = [dictionary objectForKey:KW_RECENT_CAPTION];
    rm.userHasLiked = [[dictionary objectForKey:KW_RECENT_USERHASLIKED] boolValue];
    rm.mediaId = [dictionary objectForKey:KW_RECENT_ID];
    rm.user = [Parser parseUserObj:[dictionary objectForKey:KW_RECENT_USER]];
    
            
            
    return rm;
}

/*!
 @brief Parse the users tagged in a Media Post.
 
 @discussion Method used to parse the NSDictionary representation of the users associated with a certain Media post.
 
 
 @param users   An array of NSDictionaries associated with Users who were tagged in the Media post.
 
 @return NSarray returns an array of UserObj objects of the users tagged in a Media post.
 */
+(NSArray *) parseUsersInPhoto:(NSArray *) users
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    if([users count] > 0)
        for(NSDictionary *user in users)
            [arr addObject:[Parser parseUserObj:user]];
    
    return arr;
}


/*!
 @brief Parse the images (Thumbnail, LowResolution and OriginalResolution) associated with RecentMedia objects.
 
 @discussion Method used to parse the NSDictionary representation of the image resolutions associated with a RecentMedia post.
 
 @param dictionary   The NSDictionary containing the IGImages array.
 
 @return NSArray Returns an array with the (so far) three possible image resolutions and their informations.
 
 */
+(NSArray *) parseImages:(NSDictionary *) dictionary
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    if([dictionary objectForKey:KW_IMAGE_LOWRESOLUTION])
    {
        IGImage *img = [Parser parseIGImage:[dictionary objectForKey:KW_IMAGE_LOWRESOLUTION]];
        img.type = TYPE_LOWRESOLUTION;
        [arr addObject:img];
    }
    if([dictionary objectForKey:KW_IMAGE_THUMBNAILRESOLUTION])
    {
        IGImage *img = [Parser parseIGImage:[dictionary objectForKey:KW_IMAGE_THUMBNAILRESOLUTION]];
        img.type = TYPE_THUMBNAIL;
        [arr addObject:img];
    }
    if([dictionary objectForKey:KW_IMAGE_ORIGINALRESOLUTION])
    {
        IGImage *img = [Parser parseIGImage:[dictionary objectForKey:KW_IMAGE_ORIGINALRESOLUTION]];
        img.type = TYPE_ORIGINAL;
        [arr addObject:img];
    }
    
    return arr;
}

@end
