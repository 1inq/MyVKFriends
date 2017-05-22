//
//  PostOnWall.h
//  APITest
//
//  Created by Александр Сорокин on 19.05.17.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASWallViewController.h"

@interface ASPostOnWall : NSObject


@property (strong, nonatomic) ASWallViewController *vc;
@property (assign, nonatomic) BOOL postTypeIsCopy;

@property (strong,nonatomic) NSString *text;
@property (strong,nonatomic) NSString *date;
@property (strong,nonatomic) NSURL *postImageURL;
@property (strong,nonatomic) NSURL *ownerPostPhotoURL;
@property (strong,nonatomic) NSString *ownerPostName;

@property (strong, nonatomic) NSURL *ownerCopyPhotoURL;
@property (strong, nonatomic) NSString *ownerCopyName;
@property (strong,nonatomic) NSString * postCopydate;

@property (strong,nonatomic) NSNumber *likesCount;
@property (strong,nonatomic) NSNumber *repostCount;

- (id) initWithServerResponse: (NSDictionary*) response;

@end
