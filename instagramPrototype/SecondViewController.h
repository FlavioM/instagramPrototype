//
//  SecondViewController.h
//  instagramPrototype
//
//  Created by Flávio Marques on 05/12/16.
//  Copyright © 2016 com.prototypes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserObj.h"
#import "RecentMedia.h"
#import "IGImage.h"
#import "UserTableViewCell.h"
#import "RecentMediaTableViewCell.h"

#import "Utils.h"

@interface SecondViewController : UIViewController

@property (strong, nonatomic) NSArray *recentMedia;
@property (strong, nonatomic) UserObj *user;
-(RecentMediaTableViewCell *) getRecentCell:(int) position;
-(UserTableViewCell *) getUserCell;


@end
