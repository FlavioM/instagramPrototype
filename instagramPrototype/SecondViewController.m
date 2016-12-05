//
//  SecondViewController.m
//  instagramPrototype
//
//  Created by Flávio Marques on 05/12/16.
//  Copyright © 2016 com.prototypes. All rights reserved.
//

#import "SecondViewController.h"
#import "UserTableViewCell.h"

#define KW_REUSE_CELL @"UserTableViewCell"

@interface SecondViewController ()

@end

@implementation SecondViewController



-(void)goBack:(UIBarButtonItem *)sender {
    if([Utils deleteToken])
    {
        NSLog(@"Token deleted.");
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        
    }else{
        NSLog(@"Couldn't delete the token!\nCall someone!");
    }
}

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.recentMedia count]+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;// = [tableView dequeueReusableCellWithIdentifier:KW_REUSE_CELL forIndexPath:indexPath];

    if(indexPath.row == 0){
        cell = [self getUserCell];
    }else{
       // cell = [self getRecentCell:indexPath.row-1];
    }
    
    // Configure the cell...
    
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


-(UserTableViewCell *) getUserCell
{
    UserTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"UserTableViewCell" owner:self options:nil] objectAtIndex:0];
    [cell setUser:[Utils getUser]];
    [cell awakeFromNib];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
