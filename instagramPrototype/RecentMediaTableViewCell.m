//
//  RecentMediaTableViewCell.m
//  instagramPrototype
//
//  Created by Flávio Marques on 05/12/16.
//  Copyright © 2016 com.prototypes. All rights reserved.
//

#import "RecentMediaTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


@implementation RecentMediaTableViewCell
@synthesize recentMedia;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    IGImage *img;
    for(IGImage *image in self.recentMedia.images)
    {
        if(image.type == TYPE_THUMBNAIL)
            img = image;
    }
    NSString *imgUrl = img.url;
    NSMutableString *tags = [[NSMutableString alloc] init];
    for(NSString *tag in self.recentMedia.tags)
        [tags appendString:[NSString stringWithFormat:@"#%@ ", tag, nil]];
    
    [self.mediaImage sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
    [self.labelTags setText:tags];
    [self.labelLikes setText:[NSString stringWithFormat:@"%u likes", self.recentMedia.likes, nil]];
    [self.labelCommentsCount setText:[NSString stringWithFormat:@"%u comments", self.recentMedia.comments, nil]];
    
    }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
