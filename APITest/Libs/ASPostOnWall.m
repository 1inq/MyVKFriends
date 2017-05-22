//
//  PostOnWall.m
//  APITest
//
//  Created by Александр Сорокин on 19.05.17.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

#import "ASPostOnWall.h"
#import "ASServerManager.h"
#import "ASGroup.h"


@implementation ASPostOnWall

- (id) initWithServerResponse:(NSDictionary *)response {
    
    self = [super init];
    if (self) {
        
        // set post date
        NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
        [dateFormater setDateFormat:@"d MMMM yyyy"];
        NSInteger timeInterval = [[response objectForKey:@"date"] floatValue];
        
        if (timeInterval != 0) {
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
            NSString *stringValueOfDate = [dateFormater stringFromDate:date];
            self.date = stringValueOfDate;
            
        } else {
            self.date = @"";
        }
        
        // set owner post name and photo
        NSNumber* ownerPostId = [response objectForKey:@"from_id"];
        
        // define owner post is group or user
        if ([ownerPostId integerValue] < 0) {
            
            NSInteger positiveNumber = -[ownerPostId integerValue];
            ownerPostId = [NSNumber numberWithInteger:positiveNumber];
            
            [[ASServerManager sharedManager]
             getGroupWithId:ownerPostId
             onSuccess:^(ASGroup *group) {
                 
                 self.ownerPostName = group.name;
                 self.ownerPostPhotoURL = group.imageURL;
                 [self.vc.tableView reloadData];
                 
             }
             onFailure:^(NSError *error, NSInteger statusCode) {
                 
             }];
            
        } else {
            
            [[ASServerManager sharedManager]
             getUserInfoForID:[ownerPostId intValue]
             onSuccess:^(NSArray *userArray) {
                 
                 //NSLog(@"UserArray: %@", [userArray debugDescription]);
                 NSDictionary *dictObj = userArray[0];
                 ASUser *user = [[ASUser alloc] initWithServerResponse:dictObj];
                 
                 //NSLog(@"userfromArray: %@", [user debugDescription]);
                 
                 self.ownerPostName = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
                 self.ownerPostPhotoURL = user.image200URL;
                 [self.vc.tableView reloadData];
             }
             onFailure:^(NSError *error, NSInteger statusCode) {
                 
             }];
        }
        
        NSString* postType = [response objectForKey:@"post_type"];
        if ([postType isEqualToString:@"copy"]) {
            
            self.postTypeIsCopy = YES;
            
            // set owner copy post date
            NSInteger postCopyTimeInterval = [[response objectForKey:@"copy_post_date"] floatValue];
            
            if (postCopyTimeInterval != 0) {
                NSDate *postCopydateTime = [NSDate dateWithTimeIntervalSince1970:postCopyTimeInterval];
                NSString *postCopydate = [dateFormater stringFromDate:postCopydateTime];
                self.postCopydate = postCopydate;
                
            } else {
                self.postCopydate = @"";
            }
            
            // set owner copy post name and photo
            NSNumber* copyOwnerId = [response objectForKey:@"copy_owner_id"];
            
            // define owner copy post is group or user
            if ([copyOwnerId integerValue] < 0) {
                
                NSInteger positiveNumber = -[copyOwnerId integerValue];
                copyOwnerId = [NSNumber numberWithInteger:positiveNumber];
                
                [[ASServerManager sharedManager]
                 getGroupWithId:copyOwnerId
                 onSuccess:^(ASGroup *group) {
                     
                     self.ownerCopyName = group.name;
                     self.ownerCopyPhotoURL = group.imageURL;
                     [self.vc.tableView reloadData];
                     
                 }
                 onFailure:^(NSError *error, NSInteger statusCode) {
                     
                 }];
                
            } else {
                
                [[ASServerManager sharedManager]
                 getUserInfoForID:[copyOwnerId intValue]
                 onSuccess:^(NSArray *userArray) {
                     
                     NSDictionary *dictObj = userArray[0];
                     ASUser *user = [[ASUser alloc] initWithServerResponse:dictObj];
                     
                     self.ownerCopyName = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
                     self.ownerCopyPhotoURL = user.image50URL;
                     [self.vc.tableView reloadData];
                 }
                 onFailure:^(NSError *error, NSInteger statusCode) {
                     
                 }];
            }
        }
        
        // define attachment type and set text in post and image url
        NSDictionary *attachment = [response objectForKey:@"attachment"];
        NSString* attachmentType = [attachment objectForKey:@"type"];
        
        if ([attachmentType isEqualToString:@"photo"] || attachment == nil) {
            
            self.text = [response objectForKey:@"text"];
            self.text = [self.text stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
            
            NSDictionary *dictPhoto = [attachment objectForKey:@"photo"];
            NSString* urlString = [dictPhoto objectForKey:@"src_big"];
            self.postImageURL = [NSURL URLWithString:urlString];
            
        } else if ([attachmentType isEqualToString:@"link"]) {
            
            NSDictionary *dictLink = [attachment objectForKey:@"link"];
            
            self.text = [dictLink objectForKey:@"description"];
            self.text = [self.text stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
            
            NSString* urlString = [dictLink objectForKey:@"image_big"];
            self.postImageURL = [NSURL URLWithString:urlString];
            
        } else if ([attachmentType isEqualToString:@"video"]) {
            
            NSDictionary *dictVideo = [attachment objectForKey:@"video"];
            
            self.text = [dictVideo objectForKey:@"description"];
            self.text = [self.text stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
            
            NSString* urlString = [dictVideo objectForKey:@"image_big"];
            self.postImageURL = [NSURL URLWithString:urlString];
        }
        
        // set count likes and reposts
        self.likesCount = [[response objectForKey:@"likes"] objectForKey:@"count"];
        self.repostCount = [[response objectForKey:@"reposts"] objectForKey:@"count"];
    }
    return self;
}

@end
