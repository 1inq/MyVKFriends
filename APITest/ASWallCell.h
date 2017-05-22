//
//  ASWallCell.h
//  APITest
//
//  Created by Александр Сорокин on 19.05.17.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ASPostOnWall.h"

@interface ASWallCell : UITableViewCell

@property (strong, nonatomic) UIImageView *ownerImageView;
@property (strong, nonatomic) UILabel *ownerNameLabel;
@property (strong, nonatomic) UILabel *dateLabel;

@property (strong, nonatomic) UIImageView *ownerCopyImageView;
@property (strong, nonatomic) UILabel *ownerCopyNameLabel;
@property (strong, nonatomic) UILabel *ownerCopyDateLabel;

@property (strong, nonatomic) UIImageView *imageViewInPost;
@property (strong, nonatomic) UILabel *textInPostLabel;
@property (strong, nonatomic) UILabel *likesLabel;
@property (strong, nonatomic) UILabel *repostLabel;

- (void) configureCellWithPostOnWall:(ASPostOnWall*) postOnWall viewController: (UIViewController*) vc;

+ (CGFloat) heightForPostOnWall:(ASPostOnWall*) postOnWall viewController: (UIViewController*) vc;

@end
