//
//  ASUserViewController.m
//  APITest
//
//  Created by Александр Сорокин on 18.05.17.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

#import "ASUserViewController.h"
#import "ASUser.h"
#import "ASServerManager.h"
#import "UIImageView+AFNetworking.h"
#import "ASWallViewController.h"


@interface ASUserViewController ()


@property (nonatomic, strong) ASUser *user;

- (IBAction)showWall:(id)sender;

@end

@implementation ASUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self getUserInfoForID:self.userID];
    
    NSLog(@"User in VC: %@", self.user);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    
    //[self.view setNeedsDisplay];
    
    
    
}

- (void) viewDidAppear:(BOOL)animated {
    
    [self refreshControl];
}

#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self tableView:tableView didDeselectRowAtIndexPath:indexPath];
}


#pragma mark - Table view data source

- (void) getUserInfoForID: (NSInteger) id {
    
    [[ASServerManager sharedManager] getUserInfoForID:id onSuccess:^(NSArray *userArray) {
        
        NSDictionary *dictObj = userArray[0];
        
        ASUser *user = [[ASUser alloc] initWithServerResponse:dictObj];
        
        NSLog(@"UserInfo: %@", [user description] );
        
        self.user = user;
        
        self.navigationItem.title = user.firstName;
        
        self.userNameLabel.text = [NSString stringWithFormat:@"  %@ %@ ", self.user.firstName , self.user.lastName];
        self.userCityLabel.text = [NSString stringWithFormat:@"%d" , [self.user.city intValue]];
        
        self.userStatusLabel.text = self.user.status;
        self.userEducationLabel.text = self.user.education;
        
        
        [self.userPic setImageWithURL: self.user.image200URL];
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        
        NSLog(@"Error loading: %@, code: %d", error.localizedDescription, (int)statusCode);
        
    }];
}
    
- (IBAction)showWall:(id)sender {
    
    ASWallViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ASWallViewController"];
    vc.userId = [NSNumber numberWithInt:(int)self.userID];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
