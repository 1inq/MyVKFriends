//
//  user.m
//  APITest
//
//  Created by Александр Сорокин on 19.05.17.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

#import "User.h"
#import "ASServerManager.h"

@interface User ()

@property (strong, nonatomic) NSDictionary* responce;

@end

@implementation User

- (id) initWithServerResponse:(NSDictionary *)response {
    
    self = [super init];
    if (self) {
        
        self.responce = response;
        self.firstName = [response objectForKey:@"first_name"];
        self.lastName = [response objectForKey:@"last_name"];
        self.userId = [response objectForKey:@"user_id"];
        self.university = [response objectForKey:@"university_name"];
        
        // set user city
        [[ServerManager sharedManager] getCityWithId:[response objectForKey:@"city"]
                                           onSuccess:^(NSString *cityName) {
                                               self.city = cityName;
                                               self.vc.cityLabel.text = cityName;
                                               
                                           }
                                           onFailure:^(NSError *error, NSInteger statusCode) {
                                               
                                           }];
        
        // set user country
        [[ServerManager sharedManager] getCountryWithId:[response objectForKey:@"country"]
                                              onSuccess:^(NSString *countryName) {
                                                  self.country = countryName;
                                                  self.vc.countryLabel.text = countryName;
                                                  
                                              }
                                              onFailure:^(NSError *error, NSInteger statusCode) {
                                                  
                                              }];
        
        // set user bdate
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        NSString* bdateString = [response objectForKey:@"bdate"];
        
        if (bdateString) {
            
            NSArray* dateComponents = [bdateString componentsSeparatedByString:@"."];
            
            if (dateComponents.count < 3) {
                [dateFormatter setDateFormat:@"dd.MM"];
            } else {
                [dateFormatter setDateFormat:@"dd.MM.yyyy"];
            }
            NSDate* date = [dateFormatter dateFromString:bdateString];
            
            if (dateComponents.count < 3) {
                [dateFormatter setDateFormat:@"d MMMM"];
            } else {
                [dateFormatter setDateFormat:@"d MMMM yyyy"];
            }
            
            bdateString = [dateFormatter stringFromDate:date];
            self.bdate = [NSString stringWithFormat:@"Date of birth: %@", bdateString];
        }
        
        // set user last_seen
        NSInteger timeInterval = [(NSNumber*)[[response objectForKey:@"last_seen"] objectForKey:@"time"] integerValue];
        
        if (timeInterval != 0) {
            
            NSDate* lastSeenDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
            [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
            self.lastSeen = [NSString stringWithFormat:@"Last seen %@", [dateFormatter stringFromDate:lastSeenDate]];
            
        } else {
            self.lastSeen = @"";
        }
        
        // set user photo
        NSString* urlStringForSmallPhoto = [response objectForKey:@"photo_50"];
        NSString* urlStringForBigPhoto = [response objectForKey:@"photo_max_orig"];
        
        if (urlStringForSmallPhoto) {
            self.imageURL = [NSURL URLWithString:urlStringForSmallPhoto];
            
        } else if (urlStringForBigPhoto) {
            self.imageURL = [NSURL URLWithString:urlStringForBigPhoto];
        }
    }
    return self;
}

- (BOOL) isOnline {
    
    BOOL isOnline = [(NSNumber*)[self.responce objectForKey:@"online"] boolValue];
    
    if (isOnline) {
        return YES;
    } else {
        return NO;
    }
}

@end
