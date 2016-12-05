//
//  UserObj.h
//  instagramPrototype
//
//  Created by Flávio Marques on 04/12/16.
//  Copyright © 2016 com.prototypes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserObj : NSObject


@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *bio;
@property (strong, nonatomic) NSString *website;
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSString *fullName;
@property (strong, nonatomic) NSString *_id;

@property int media;
@property int followers;
@property int following;



@end


