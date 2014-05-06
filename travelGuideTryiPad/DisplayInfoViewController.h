//
//  DisplayInfoViewController.h
//  travelGuideTryiPad
//
//  Created by Felipe Arturo Pérez Camargo on 04/03/14.
//  Copyright (c) 2014 Felipe Arturo Pérez Camargo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapLocationPlaceViewController.h"
#import "HotelHostalViewController.h"
#import "DataController.h"
#import <Social/Social.h>

@interface DisplayInfoViewController : UIViewController{
    MapLocationPlaceViewController *mapLocationPlaceView;
    HotelHostalViewController *hotelHostalView;
}

@property(nonatomic,strong)IBOutlet UILabel *titleLabel;
@property(nonatomic,strong)IBOutlet UIImageView *placeImage;
@property(nonatomic,strong)IBOutlet UILabel *countryLabel;
@property(nonatomic,strong)IBOutlet UILabel *cityLabel;
@property(nonatomic,strong)IBOutlet UITextView *descriptionText;
@property(nonatomic)double pinLatitude;
@property(nonatomic)double pinLongitude;

@property(nonatomic,strong)DataController *data;
@property(nonatomic,strong)NSString *myQuery;
@property(nonatomic,strong)NSMutableArray *workData;

-(IBAction)goBack;
-(IBAction)seeMap;
-(IBAction)seeHotel;

-(IBAction)facebook;
-(IBAction)twitter;

@end
