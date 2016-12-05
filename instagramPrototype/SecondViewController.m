//
//  SecondViewController.m
//  instagramPrototype
//
//  Created by Flávio Marques on 05/12/16.
//  Copyright © 2016 com.prototypes. All rights reserved.
//

#import "SecondViewController.h"

#define KW_REUSE_CELL @"UserTableViewCell"

@interface SecondViewController ()

@end

@implementation SecondViewController


#pragma mark - ViewController's methods


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"< Logout" style:UIBarButtonItemStylePlain target:self action:@selector(goBack:)];
    self.navigationItem.leftBarButtonItem=newBackButton;

    
    self.user = [Utils getUser];
    self.recentMedia = [Utils getRecentMedia];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - this VC's custom methods

/*!
 @brief Method used to logout and close this ViewController
 
 @discussion This method tries to delete the token associated with the current user, and then goes back to the First Screen.
 
 @param  sender     The UIOutlet that called this method.
 
 
 */
-(void)goBack:(UIBarButtonItem *)sender {
    if([Utils deleteToken])
    {
        NSLog(@"Token deleted.");
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        
    }else{
        NSLog(@"Couldn't delete the token!\nCall someone!");
    }
}

/*!
 @brief Method used to create a customized UITableViewCell (RecentMediaTableViewCell) for a RecentMedia object.
 
 @discussion This method creates and returns a RecentMediaTableViewCell, sets it's RecentMedia object, and updates the cell's UI.
 
 @param  position   The position of the RecentMedia object in the ViewController's array of RecentMedia objects.
 
 @return RecentMediaTableViewCell returns a cell with the RecentMedia object associated and it's UI customized for the RecentMedia object.
 */
-(RecentMediaTableViewCell *) getRecentCell:(int) position
{
    RecentMediaTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"RecentMediaTableViewCell" owner:self options:nil] objectAtIndex:0];
    
    [cell setRecentMedia:[self.recentMedia objectAtIndex:position]];
    [cell awakeFromNib];
    
    return cell;
}


/*!
 @brief Method used to create a customized UITableViewCell (UserTableViewCell) for a UserObj object.
 
 @discussion This method creates and returns a UserTableViewCell, sets it's UserObj object, and updates the cell's UI.
 

 @return UserTableViewCell returns a cell with the UserObj object associated and it's UI customized for the UserObj object.
 */
-(UserTableViewCell *) getUserCell
{
    UserTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"UserTableViewCell" owner:self options:nil] objectAtIndex:0];
    [cell setUser:[Utils getUser]];
    [cell awakeFromNib];
    return cell;
}


#pragma mark - Table view data source / delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.recentMedia count]+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;// = [tableView dequeueReusableCellWithIdentifier:KW_REUSE_CELL forIndexPath:indexPath];

    
    //first cell is for the user profile cell
    if(indexPath.row == 0){
        cell = [self getUserCell];
    }else{
        //other rows are for RecentMedia cells!
        cell = [self getRecentCell:indexPath.row-1];
    }
    
    return cell;
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        return 350;
    }else{
        RecentMedia *rm = [self.recentMedia objectAtIndex:indexPath.row-1];
        
        
        
        
        return 250;
    }
}


@end
