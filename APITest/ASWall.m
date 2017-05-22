//
//  ASWall.m
//  APITest
//
//  Created by Александр Сорокин on 19.05.17.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

#import "ASWall.h"

@implementation ASWall

- (id) initWithServerResponse:(NSDictionary *)response {
    
    self = [super init];
    if (self) {
        
        self.text = [response objectForKey:@"text"];
        self.text = [self.text stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
        
        float timeInterval = [(NSNumber*)[response objectForKey:@"date"] floatValue];
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yyyy HH:mm"];
        self.date = [NSString stringWithFormat:@"%@", [formatter stringFromDate:date]];
        
        NSOperationQueue* operationQueue = [[NSOperationQueue alloc] init];
        [operationQueue addOperationWithBlock:^{
            NSString* imageStringURL = [[[response objectForKey:@"attachment"] objectForKey:@"photo"] objectForKey:@"src_big"];
            self.imageURL = [NSURL URLWithString:imageStringURL];
            
            NSURL* imageURL = [NSURL URLWithString:imageStringURL];
            NSData *data = [[NSData alloc] initWithContentsOfURL:imageURL];
            self.image = [UIImage imageWithData:data];
            
            [self.vc.tableView reloadData];
        }];
        
    }
    return self;
}

@end
