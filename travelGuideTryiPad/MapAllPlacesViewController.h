//
//  MapAllPlacesViewController.h
//  travelGuideTryiPad
//
//  Created by Felipe Arturo Pérez Camargo on 06/03/14.
//  Copyright (c) 2014 Felipe Arturo Pérez Camargo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "TheMapPin.h"
#import "DataController.h"

@interface MapAllPlacesViewController : UIViewController<MKMapViewDelegate>{
    int mapState;
}
@property(nonatomic,strong) DataController *dataBase;
@property(nonatomic,strong) NSString *myQuery;
@property(nonatomic,strong) NSMutableArray *workData;
@property (nonatomic, strong)IBOutlet MKMapView *myMapView;
@property (strong, nonatomic)IBOutlet UISegmentedControl *mySegmentControl;

-(void)changeType;
-(void)zoomToCurrentLocation;
-(void)setPin:(double)latitude longitude:(double)longitude title:(NSString *)theTitle subTitle:(NSString *)theSubTitle;
-(IBAction)segmentMethod:(UISegmentedControl *)sender;
@end
