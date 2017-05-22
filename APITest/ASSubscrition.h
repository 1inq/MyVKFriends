//
//  ASSubscrition.h
//  APITest
//
//  Created by Александр Сорокин on 19.05.17.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASSubscrition : NSObject

@property (assign, nonatomic) NSNumber* userId;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSURL* imageURL;

- (id) initWithServerResponse: (NSDictionary*) response;

@end
