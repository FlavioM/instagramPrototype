//
//  UserTableViewCell.h
//  instagramPrototype
//
//  Created by Flávio Marques on 05/12/16.
//  Copyright © 2016 com.prototypes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserObj.h"

@interface UserTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *labelUsername;
@property (weak, nonatomic) IBOutlet UILabel *labelFullName;
@property (weak, nonatomic) IBOutlet UILabel *labelBio;
@property (weak, nonatomic) IBOutlet UILabel *labelFollowing;
@property (weak, nonatomic) IBOutlet UILabel *labelFollowed;
@property (weak, nonatomic) IBOutlet UILabel *labelMediaCount;

@property (strong, nonatomic) UserObj *user;

@end
