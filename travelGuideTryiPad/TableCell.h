//
//  TableCell.h
//  travelGuideTryiPad
//
//  Created by Felipe Arturo Pérez Camargo on 06/03/14.
//  Copyright (c) 2014 Felipe Arturo Pérez Camargo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCell : UITableViewCell{
}
@property(nonatomic, strong) IBOutlet UIImageView *countryImage;
@property(nonatomic,strong) IBOutlet UILabel *countryLabel;

@end
