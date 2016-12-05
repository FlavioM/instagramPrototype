//
//  UserTableViewCell.m
//  instagramPrototype
//
//  Created by Flávio Marques on 05/12/16.
//  Copyright © 2016 com.prototypes. All rights reserved.
//

#import "UserTableViewCell.h"
#import "Utils.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation UserTableViewCell
@synthesize user;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.profileImage sd_setImageWithURL:[NSURL URLWithString:self.user.imageUrl]];
    [self.labelBio setText:self.user.bio];
    [self.labelFollowed setText:[NSString stringWithFormat:@"Followed by %u", self.user.followers, nil]];
    [self.labelFollowing setText:[NSString stringWithFormat:@"Following %u", self.user.following, nil]];
    [self.labelFullName setText:self.user.fullName];
    [self.labelUsername setText:self.user.username];
    [self.labelMediaCount setText:[NSString stringWithFormat:@"%u Posts", self.user.media, nil]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}





@end
