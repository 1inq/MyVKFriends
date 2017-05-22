//
//  ASSubscrition.m
//  APITest
//
//  Created by Александр Сорокин on 19.05.17.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

#import "ASSubscrition.h"

@implementation ASSubscrition

- (id) initWithServerResponse:(NSDictionary *)response {
    
    self = [super init];
    if (self) {
        
        NSString* groupName = [response objectForKey:@"name"];
        NSString* userName = [NSString stringWithFormat:@"%@ %@", [response objectForKey:@"first_name"], [response objectForKey:@"last_name"]];
        
        if (groupName) {
            self.name = groupName;
            
        } else if (userName) {
            self.name = userName;
        }
        
        self.userId = [response objectForKey:@"user_id"];
        NSString* urlStringForSmallPhoto = [response objectForKey:@"photo_50"];
        
        if (urlStringForSmallPhoto) {
            self.imageURL = [NSURL URLWithString:urlStringForSmallPhoto];
        }
    }
    return self;
}

@end

