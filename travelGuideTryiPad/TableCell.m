//
//  TableCell.m
//  travelGuideTryiPad
//
//  Created by Felipe Arturo Pérez Camargo on 06/03/14.
//  Copyright (c) 2014 Felipe Arturo Pérez Camargo. All rights reserved.
//

#import "TableCell.h"

@implementation TableCell
@synthesize countryImage,countryLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
