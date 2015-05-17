//
//  CityTableViewCell.m
//  rainbowapple
//
//  Created by Tom Macmichael on 17/05/2015.
//  Copyright (c) 2015 Spotify Unify. All rights reserved.
//

#import "CityTableViewCell.h"

@implementation CityTableViewCell
@synthesize cityLabel, countryLabel;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
