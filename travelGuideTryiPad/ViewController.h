//
//  ViewController.h
//  travelGuideTryiPad
//
//  Created by Felipe Arturo Pérez Camargo on 03/03/14.
//  Copyright (c) 2014 Felipe Arturo Pérez Camargo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "MapLocationPlaceViewController.h"
#import "HotelHostalViewController.h"
#import "DataController.h"
#import <Social/Social.h>

@interface ViewController : UIViewController<iCarouselDataSource,iCarouselDelegate,UIActionSheetDelegate,NSXMLParserDelegate>{
    MapLocationPlaceViewController *mapLocationPlaceView;
    HotelHostalViewController *hotelHostalView;
    
    NSMutableData *webData;
    NSMutableString *soapResults;
    NSURLConnection *conn;
    NSXMLParser *xmlParser;
	NSMutableString *xmlString;
	NSString *tag;
	BOOL tagFound;
}
@property(nonatomic,strong)DataController *dataBase;
@property(nonatomic,strong)NSString *myQuery;
@property(nonatomic,strong)NSMutableArray *workData;

@property(nonatomic,strong)NSMutableArray *weatherId;

@property(nonatomic,strong)IBOutlet iCarousel *myCarousel;
@property(nonatomic,strong)NSMutableArray *myItems;

@property(nonatomic,strong)IBOutlet UILabel *titleLabel;
@property(nonatomic,strong)IBOutlet UIImageView *placeImage;
@property(nonatomic,strong)IBOutlet UILabel *countryLabel;
@property(nonatomic,strong)IBOutlet UILabel *cityLabel;
@property(nonatomic,strong)IBOutlet UITextView *descriptionText;
@property(nonatomic,strong)IBOutlet UILabel *tempLabel;

@property(nonatomic)double pinLatitude;
@property(nonatomic)double pinLongitude;


-(IBAction)switchCarouselType;
-(IBAction)seeMap;
-(IBAction)seeHotel;

-(IBAction)facebook;
-(IBAction)twitter;

-(void)initView:(long)index;

@end
