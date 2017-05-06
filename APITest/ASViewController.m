//
//  ViewController.m
//  APITest
//
//  Created by Александр Сорокин on 06.05.17.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

#import "ASViewController.h"
#import "ASServerManager.h"

@interface ASViewController ()

@property (strong, nonatomic) NSMutableArray* friendsArray;

@end

@implementation ASViewController

static NSInteger friendsInRequest = 5;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.friendsArray = [NSMutableArray array];
    [self getFriendsFromServer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API 

- (void) getFriendsFromServer {
    
    NSString *userID = @"id2531409";
    
    [[ASServerManager sharedManager] getFriendsForUserID:userID
        offset:[self.friendsArray count]
        count:friendsInRequest
        onSuccess:^(NSArray *friends) {
        
        
        [self.friendsArray addObjectsFromArray:friends];
        //[self.tableView reloadData];
        
        NSMutableArray *newPaths = [NSMutableArray array];
        for ( int i = (int)[self.friendsArray count] - (int)[friends count]; i < [ self.friendsArray count]; i++) {
            [newPaths addObject:[NSIndexPath indexPathForRow: i inSection:0]];
        }
        
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationTop];
        [self.tableView endUpdates];
        
    } onFailure:^(NSError *error, NSInteger *statusCode) {
        NSLog(@"Error = %@ , code = %d", [error localizedDescription], (int)statusCode);
    }];
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.friendsArray count];
    
};



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
};


@end
