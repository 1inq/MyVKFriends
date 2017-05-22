//
//  user.h
//  APITest
//
//  Created by Александр Сорокин on 19.05.17.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FriendViewController.h"

@interface User : NSObject

@property (assign, nonatomic) NSNumber* userId;
@property (assign, nonatomic) BOOL isOnline;
@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSString* bdate;
@property (strong, nonatomic) NSString* city;
@property (strong, nonatomic) NSString* country;
@property (strong, nonatomic) NSString* university;
@property (strong, nonatomic) NSString* lastSeen;
@property (strong, nonatomic) NSURL* imageURL;

@property (strong, nonatomic) FriendViewController* vc;

- (id) initWithServerResponse: (NSDictionary*) response;

@end
