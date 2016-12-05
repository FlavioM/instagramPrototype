//
//  IGImage.h
//  instagramPrototype
//
//  Created by Flávio Marques on 04/12/16.
//  Copyright © 2016 com.prototypes. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    TYPE_ORIGINAL = 0,
    TYPE_THUMBNAIL,
    TYPE_LOWRESOLUTION
} image_type;

@interface IGImage : NSObject

@property (strong, nonatomic) NSString *url;
@property int width;
@property int height;
@property image_type type;

@end
