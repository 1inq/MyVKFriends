//
//  ASUserViewController.h
//  APITest
//
//  Created by Александр Сорокин on 18.05.17.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASUserViewController : UITableViewController

@property (nonatomic, assign) NSInteger userID;

@property (weak, nonatomic) IBOutlet UIImageView *userPic;


@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userCityLabel;

@property (weak, nonatomic) IBOutlet UILabel *userStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *userEducationLabel;

- (void) getUserInfoForID: (NSInteger) id;

@end
