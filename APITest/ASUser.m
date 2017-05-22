//
//  ASUser.m
//  APITest
//
//  Created by Александр Сорокин on 10.05.17.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

#import "ASUser.h"

@implementation ASUser

- (instancetype) initWithServerResponse:(NSDictionary*) response
{
    self = [super init];
    if (self) {
        self.firstName = [response objectForKey:@"first_name"];
        self.lastName = [response objectForKey:@"last_name"];
        //NSLog(@"set ID to : %d for user %@ %@", [[response objectForKey:@"uid"] intValue], self.firstName, self.lastName);
        self.id = [[response objectForKey:@"uid"] intValue];
        self.city = [response objectForKey:@"city"];
        
        NSString *url50String = [response objectForKey:@"photo_50"];
        if (url50String) {
            self.image50URL = [NSURL URLWithString:url50String];
        }
        
        NSString *url200String = [response objectForKey:@"photo_200"];
        if (url200String) {
            self.image200URL = [NSURL URLWithString:url200String];
        }
        
        self.isOnline = [[response objectForKey:@"online"] boolValue];
        
        self.education = [response objectForKey:@"university_name"];
        self.status = [response objectForKey:@"status"];
    }
    return self;
}


@end
