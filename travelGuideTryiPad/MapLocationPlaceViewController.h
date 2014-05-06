//
//  MapLocationPlaceViewController.h
//  travelGuideTryiPad
//
//  Created by Felipe Arturo Pérez Camargo on 04/03/14.
//  Copyright (c) 2014 Felipe Arturo Pérez Camargo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "TheMapPin.h"

@interface MapLocationPlaceViewController : UIViewController<MKMapViewDelegate>{
    int mapState;
}
@property (nonatomic, strong)IBOutlet MKMapView *myMapView;
@property (strong, nonatomic)IBOutlet UISegmentedControl *mySegmentControl;
@property (nonatomic, strong)NSString *pinTitle;
@property (nonatomic, strong)NSString *pinSubTitle;
@property (nonatomic)double pinLongitude;
@property (nonatomic)double pinLatitude;

-(void)zoomIn:(double)latitude longitude:(double)longitude;
-(void)zoomOut:(double)latitude longitude:(double)longitude;
-(void)changeType;
-(void)zoomToCurrentLocation;
-(void)setPin:(double)latitude longitude:(double)longitude title:(NSString *)theTitle subTitle:(NSString *)theSubTitle;
-(IBAction)segmentMethod:(UISegmentedControl *)sender;
-(IBAction)goBack;

@end
