//
//  RecentMediaTableViewCell.h
//  instagramPrototype
//
//  Created by Flávio Marques on 05/12/16.
//  Copyright © 2016 com.prototypes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecentMedia.h"

@interface RecentMediaTableViewCell : UITableViewCell

@property (strong, nonatomic) RecentMedia *recentMedia;

@property (weak, nonatomic) IBOutlet UIImageView *mediaImage;
@property (weak, nonatomic) IBOutlet UILabel *labelCommentsCount;
@property (weak, nonatomic) IBOutlet UILabel *labelLikes;
@property (weak, nonatomic) IBOutlet UILabel *labelTags;



@end
