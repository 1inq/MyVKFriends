//
//  ASGroup.m
//  APITest
//
//  Created by Александр Сорокин on 19.05.17.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

#import "ASGroup.h"

@implementation ASGroup


- (id) initWithServerResponse:(NSDictionary *)response {
    
    self = [super init];
    if (self) {
        
        self.name = [response objectForKey:@"name"];
        NSString* stringURL = [response objectForKey:@"photo"];
        self.imageURL = [NSURL URLWithString:stringURL];
        
    }
    return self;
}

@end
