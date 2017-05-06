//
//  ViewController.m
//  APITest
//
//  Created by Александр Сорокин on 06.05.17.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

#import "ASViewController.h"
#import "AFNetworking.h"

@interface ASViewController ()

@property (strong, nonatomic) NSArray* friendsArray;

@end

@implementation ASViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API 

- (void) getFriendsFromServer {
    
    
    
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
