//
//  AppDelegate.h
//  instagramPrototype
//
//  Created by Flávio Marques on 03/12/16.
//  Copyright © 2016 com.prototypes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

