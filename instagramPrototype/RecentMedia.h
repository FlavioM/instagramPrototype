//
//  RecentMedia.h
//  instagramPrototype
//
//  Created by Flávio Marques on 04/12/16.
//  Copyright © 2016 com.prototypes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGImage.h"
#import "UserObj.h"

@interface RecentMedia : NSObject

@property (strong, nonatomic) NSString *attribution;
@property (strong, nonatomic) NSArray *tags;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSArray *comments;
@property (strong, nonatomic) NSString *filter;
@property (strong, nonatomic) NSString *createdTime;
@property (strong, nonatomic) NSString *link;
@property int likes;
@property (strong, nonatomic) NSArray *images;
@property (strong, nonatomic) NSArray *usersInPhoto;
@property (strong, nonatomic) NSString *caption;
@property BOOL userHasLiked;
@property (strong, nonatomic) NSString *mediaId;
@property (strong, nonatomic) UserObj *user;




@end
