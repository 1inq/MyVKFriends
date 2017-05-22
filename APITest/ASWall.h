//
//  ASWall.h
//  APITest
//
//  Created by Александр Сорокин on 19.05.17.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ASWallViewController.h"

@interface ASWall : NSObject
- (id) initWithServerResponse: (NSDictionary*) response;

@property (strong, nonatomic) ASWallViewController* vc;
@property (strong, nonatomic) NSString* text;
@property (strong, nonatomic) NSString* date;
@property (strong, nonatomic) NSURL* imageURL;
@property (strong, nonatomic) UIImage* image;

@end
