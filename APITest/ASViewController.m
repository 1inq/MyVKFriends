//
//  ViewController.m
//  APITest
//
//  Created by Александр Сорокин on 06.05.17.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

#import "ASViewController.h"
#import "ASServerManager.h"
#import "ASUser.h"
#import "UIImageView+AFNetworking.h"
#import "ASUserViewController.h"

@interface ASViewController ()

@property (strong, nonatomic) NSMutableArray* friendsArray;
@property (assign,nonatomic) NSInteger myID;

@end

@implementation ASViewController

static NSInteger friendsInRequest = 20;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.myID = 2531409;
    // Do any additional setup after loading the view, typically from a nib.
    self.friendsArray = [NSMutableArray array];
    [self getFriendsFromServer];
    
    UIRefreshControl* refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(refreshFriends) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - API 

- (void) getFriendsFromServer {
    
    [[ASServerManager sharedManager]
        getFriendsForUserID:self.myID
                     offset:[self.friendsArray count]
                      count:friendsInRequest
                  onSuccess:^(NSArray *friends) {
                                                   
                      [self.friendsArray addObjectsFromArray:friends];
                                                   
                      //adding to table with amination
                                                   
                      NSMutableArray *newPaths = [NSMutableArray array];
                      for ( int i = (int)[self.friendsArray count] - (int)[friends count];
                           i < [ self.friendsArray count]; i++) {
                          [newPaths addObject:[NSIndexPath indexPathForRow: i inSection:0]];
                      }
        
                      [self.tableView beginUpdates];
                      [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationTop];
                      [self.tableView endUpdates];
                                                    
                      //[self.tableView reloadData];
                  }
                onFailure:^(NSError *error, NSInteger statusCode) {
                    NSLog(@"Error = %@ , code = %d", [error localizedDescription], (int)statusCode);
                }];

}


- (void) refreshFriends {
    
    [[ASServerManager sharedManager]
       getFriendsForUserID:self.myID
                    offset:0
                    count:friendsInRequest
                onSuccess:^(NSArray *friends) {
                    
                    if (friends) {
                        
                        [self.friendsArray removeAllObjects];
                        [self.friendsArray addObjectsFromArray:friends];
                        [self.tableView reloadData];
                    }
                    [self.refreshControl endRefreshing];
                    
                } onFailure:^(NSError *error, NSInteger statusCode) {
                    
                    NSLog(@"Error = %@, code = %ld", error.localizedDescription, statusCode);
                    [self.refreshControl endRefreshing];
                    
                }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.friendsArray count] + 1;
    
};


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    if ((indexPath.row  == [self.friendsArray count] - 0) || ([self.friendsArray count] == 0 )) {
        
        [self getFriendsFromServer];
        
    } else {
        
        ASUser *friend = [self.friendsArray objectAtIndex:indexPath.row];
        NSString *friendName = [NSString stringWithFormat:@"%@ %@",
                            friend.firstName,
                            friend.lastName];
        NSLog(@"Friend for add to table %@",friendName);
        cell.textLabel.text = friendName;
        
        //online user's indicator
        
        if (friend.isOnline == YES) {
            
            cell.detailTextLabel.font = [UIFont fontWithName:@"Verdana" size:11];
            cell.detailTextLabel.textColor = [UIColor blueColor];
            cell.detailTextLabel.text = @"on";
                                         
        } else {
            
            cell.detailTextLabel.font = [UIFont fontWithName:@"Verdana" size:11];
            cell.detailTextLabel.textColor = [UIColor redColor];
            cell.detailTextLabel.text = @"off";
                                             
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:friend.image50URL];
        __weak UITableViewCell* weakCell = cell;
        cell.imageView.image = nil;
        
        [cell.imageView setImageWithURLRequest:urlRequest placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
            weakCell.imageView.image = image;
        } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
           
        }];
        
    }
    return cell;
};

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row  == [self.friendsArray count]) {
        
        [self getFriendsFromServer];
        
    } else {
        
        ASUser *friend = [self.friendsArray objectAtIndex:indexPath.row];
        ASUserViewController *vc  = [self.storyboard instantiateViewControllerWithIdentifier:@"userInfoViewController"];
        vc.userID = friend.id;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
};

@end
