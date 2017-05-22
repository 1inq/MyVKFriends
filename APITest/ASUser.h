//
//  ASUser.h
//  APITest
//
//  Created by Александр Сорокин on 10.05.17.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASUser : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (assign, nonatomic) NSInteger id;
@property (strong, nonatomic) NSString *city;

@property (strong, nonatomic) NSURL *image50URL;
@property (strong, nonatomic) NSURL *image200URL;

@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *education;


@property (assign,nonatomic) BOOL isOnline;

- (id) initWithServerResponse:(NSDictionary*) response;

@end
