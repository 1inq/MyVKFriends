//
//  ASWallCell.m
//  APITest
//
//  Created by Александр Сорокин on 19.05.17.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//


#import "ASWallCell.h"

@implementation ASWallCell : UITableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (CGFloat) heightForText: (NSString*) text viewController: (UIViewController*) vc {
    
    CGFloat widthView = CGRectGetWidth(vc.view.bounds);
    
    CGFloat offset = 10.f;
    
    UIFont* font = [UIFont systemFontOfSize:14.f];
    NSShadow* shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(0, -1);
    shadow.shadowBlurRadius = 0.f;
    
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    
    
    NSDictionary* attributes =
    [NSDictionary dictionaryWithObjectsAndKeys:
     font,               NSFontAttributeName,
     shadow,             NSShadowAttributeName,
     paragraphStyle,     NSParagraphStyleAttributeName, nil];
    
    CGRect textRect = [text boundingRectWithSize:CGSizeMake(widthView - 2*offset, CGFLOAT_MAX)
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attributes
                                         context:nil];
    
    return CGRectGetHeight(textRect);
    
}

+ (CGFloat) heightForPostOnWall:(ASPostOnWall*) postOnWall viewController: (UIViewController*) vc {
    
    CGFloat widthView = CGRectGetWidth(vc.view.bounds);
    
    CGFloat ownerPhotoHeigth = widthView/8;
    CGFloat likesLabelHeight = 21;
    CGFloat separatorHeight = 5;
    
    
    CGFloat height = separatorHeight + ownerPhotoHeigth + 15 + likesLabelHeight + 10;
    
    if (postOnWall.postTypeIsCopy) {
        
        CGFloat ownerCopyPhotoHeigth = widthView / 10;
        height += ownerCopyPhotoHeigth + 5;
    }
    
    if (postOnWall.postImageURL) {
        
        CGFloat postImageHeigth = widthView - 20;
        height += postImageHeigth + 5;
    }
    
    if (postOnWall.text) {
        CGFloat heightForText = [ASWallCell heightForText:postOnWall.text viewController:vc];
        height += heightForText + 5;
    }
    return height;
}


- (void) configureCellWithPostOnWall:(ASPostOnWall*) postOnWall viewController: (UIViewController*) vc {
    
    for (UIView* view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    // Separator
    CGRect frameForSeparator = CGRectMake(0, 0, self.frame.size.width, 5);
    UIView* separator = [[UIView alloc] initWithFrame:frameForSeparator];
    separator.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:separator];
    
    CGFloat originY = CGRectGetHeight(frameForSeparator);
    
    // Owner Image View
    CGRect frameForOwnerPhoto = CGRectMake(5, originY + 10,
                                           CGRectGetWidth(self.bounds)/8, CGRectGetWidth(self.bounds)/8);
    
    self.ownerImageView = [[UIImageView alloc] initWithFrame:frameForOwnerPhoto];
    [self.contentView addSubview:self.ownerImageView];
    
    
    // Owner Name Label
    CGRect frameForOwnerName = CGRectMake(CGRectGetWidth(frameForOwnerPhoto)+15, originY + 10, CGRectGetWidth(self.bounds)/2, 21.f);
    self.ownerNameLabel = [[UILabel alloc] initWithFrame:frameForOwnerName];
    [self.contentView addSubview:self.ownerNameLabel];
    
    
    // Owner Date Label
    CGRect frameForDateLabel = CGRectMake(CGRectGetWidth(frameForOwnerPhoto)+15, originY + 10 + CGRectGetHeight(frameForOwnerName),
                                          CGRectGetWidth(self.bounds)/2, 21.f);
    
    self.dateLabel = [[UILabel alloc] initWithFrame:frameForDateLabel];
    [self.contentView addSubview:self.dateLabel];
    
    originY += CGRectGetHeight(self.ownerImageView.bounds)+10;
    
    if (postOnWall.postTypeIsCopy) {
        
        // Owner Copy Post Image View
        CGRect frameForOwnerCopyPhoto = CGRectMake(5, originY + 5,
                                                   CGRectGetWidth(self.bounds)/10, CGRectGetWidth(self.bounds)/10);
        
        self.ownerCopyImageView = [[UIImageView alloc] initWithFrame:frameForOwnerCopyPhoto];
        [self.contentView addSubview:self.ownerCopyImageView];
        
        
        // Owner Copy Post Name Label
        CGRect frameForOwnerCopyName = CGRectMake(CGRectGetWidth(frameForOwnerCopyPhoto)+15, originY + 5, CGRectGetWidth(self.bounds)/2, 21.f);
        self.ownerCopyNameLabel = [[UILabel alloc] initWithFrame:frameForOwnerCopyName];
        [self.contentView addSubview:self.ownerCopyNameLabel];
        
        
        // Owner Copy Post Date Label
        CGRect frameForOwnerCopyDate = CGRectMake(CGRectGetWidth(frameForOwnerCopyPhoto)+15,  originY + 5 + CGRectGetHeight(frameForOwnerCopyName),
                                                  CGRectGetWidth(self.bounds)/2, 21.f);
        
        self.ownerCopyDateLabel = [[UILabel alloc] initWithFrame:frameForOwnerCopyDate];
        [self.contentView addSubview:self.ownerCopyDateLabel];
        
        originY += CGRectGetHeight(self.ownerCopyImageView.bounds)+5;
    }
    
    if (postOnWall.text) {
        
        CGFloat heightForText = [ASWallCell heightForText:postOnWall.text viewController:vc];
        CGRect frameForTextLabel = CGRectMake(5, originY+10, CGRectGetWidth(self.bounds)-20, heightForText);
        self.textInPostLabel = [[UILabel alloc] initWithFrame:frameForTextLabel];
        self.textInPostLabel.numberOfLines = 0;
        self.textInPostLabel.font = [self.textInPostLabel.font fontWithSize:14];
        
        [self.contentView addSubview:self.textInPostLabel];
        originY += CGRectGetHeight(self.textInPostLabel.bounds)+10;
    }
    
    if (postOnWall.postImageURL) {
        
        CGRect frameForImageView = CGRectMake(5, originY+5,
                                              CGRectGetWidth(self.bounds)-20, CGRectGetWidth(self.bounds)-20);
        
        self.imageViewInPost = [[UIImageView alloc] initWithFrame:frameForImageView];
        [self.contentView addSubview:self.imageViewInPost];
        
        originY += CGRectGetHeight(self.imageViewInPost.bounds)+5;
    }
    
    
    CGRect frameForLikesLabel = CGRectMake(5, originY+10, CGRectGetWidth(self.bounds)/2-20, 21.f);
    CGRect frameForRepostLabel = CGRectMake(CGRectGetWidth(self.bounds)/2+5, originY+10, CGRectGetWidth(self.bounds)/2-20, 21.f);
    
    self.likesLabel = [[UILabel alloc] initWithFrame:frameForLikesLabel];
    [self.contentView addSubview:self.likesLabel];
    
    self.repostLabel = [[UILabel alloc] initWithFrame:frameForRepostLabel];
    [self.contentView addSubview:self.repostLabel];
    
}

@end
