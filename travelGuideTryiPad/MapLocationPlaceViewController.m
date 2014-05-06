//
//  MapLocationPlaceViewController.m
//  travelGuideTryiPad
//
//  Created by Felipe Arturo Pérez Camargo on 04/03/14.
//  Copyright (c) 2014 Felipe Arturo Pérez Camargo. All rights reserved.
//

#import "MapLocationPlaceViewController.h"

@interface MapLocationPlaceViewController ()

@end

@implementation MapLocationPlaceViewController
@synthesize myMapView,mySegmentControl,pinLatitude,pinLongitude,pinSubTitle,pinTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    pinLatitude = 40.67693;
//    pinLongitude = 117.23193;
    mapState = 0;
    myMapView.mapType = MKMapTypeStandard;
    myMapView.showsUserLocation = YES;
    myMapView.delegate = self;
    
    mySegmentControl.selectedSegmentIndex = -1;
    [self setPin:pinLatitude longitude:pinLongitude title:pinTitle subTitle:pinSubTitle];
    [self zoomIn:pinLatitude longitude:pinLongitude];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)zoomIn:(double)latitude longitude:(double)longitude{
    MKCoordinateRegion mapRegion;
    mapRegion.center.latitude = latitude;
    mapRegion.center.longitude = longitude;
    mapRegion.span.latitudeDelta = 2;
    mapRegion.span.longitudeDelta = 2;
    [myMapView setRegion:mapRegion animated: YES];
    
}

-(void)zoomOut:(double)latitude longitude:(double)longitude{
    MKCoordinateRegion region =
    MKCoordinateRegionMakeWithDistance (
                                        CLLocationCoordinate2DMake(latitude, longitude), 0.05, 0.05);
    [myMapView setRegion:region animated:YES];
}

-(void)changeType{
    if (mapState == 0) {
        mapState = 1;
        myMapView.mapType = MKMapTypeHybrid;
    }else if (mapState == 1){
        mapState = 2;
        myMapView.mapType = MKMapTypeSatellite;
    }else{
        mapState = 0;
        myMapView.mapType = MKMapTypeStandard;
    }
}

- (void)zoomToCurrentLocation{
    MKCoordinateRegion mapRegion;
    mapRegion.center.latitude = myMapView.userLocation.coordinate.latitude;
    mapRegion.center.longitude = myMapView.userLocation.coordinate.longitude;
    mapRegion.span.latitudeDelta = 2;
    mapRegion.span.longitudeDelta = 2;
    [myMapView setRegion:mapRegion animated: YES];
}

- (IBAction)segmentMethod:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self changeType];
            break;
        case 1:
            [self zoomToCurrentLocation];
            break;
       case 2:
            [self zoomIn:pinLatitude longitude:pinLongitude];
            break;
//        case 3:
//            [self zoomOut];
//            break;
        default:
            break;
    }
    mySegmentControl.selectedSegmentIndex = -1;
}

-(IBAction)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setPin:(double)latitude longitude:(double)longitude title:(NSString *)theTitle subTitle:(NSString *)theSubTitle{
    CLLocationCoordinate2D location =
    CLLocationCoordinate2DMake(latitude, longitude);
    TheMapPin *annotation =
    [[TheMapPin alloc] initWithCoordinates:location title:theTitle subTitle:theSubTitle];
    [myMapView addAnnotation:annotation];
    NSLog(@"The latitude: %f",latitude);
    NSLog(@"The longitude: %f",longitude);
}

@end
