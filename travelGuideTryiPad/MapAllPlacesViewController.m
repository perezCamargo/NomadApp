//
//  MapAllPlacesViewController.m
//  travelGuideTryiPad
//
//  Created by Felipe Arturo Pérez Camargo on 06/03/14.
//  Copyright (c) 2014 Felipe Arturo Pérez Camargo. All rights reserved.
//

#import "MapAllPlacesViewController.h"

@interface MapAllPlacesViewController ()

@end

@implementation MapAllPlacesViewController
@synthesize myMapView,mySegmentControl,dataBase,myQuery,workData;
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
    
    mapState = 0;
    myMapView.mapType = MKMapTypeStandard;
    myMapView.showsUserLocation = YES;
    myMapView.delegate = self;
    
    mySegmentControl.selectedSegmentIndex = -1;
    dataBase = [[DataController alloc]init];
    [dataBase initDataBase];
    myQuery = @"SELECT * FROM places";
    workData = [dataBase exQuery:myQuery columToReturn:0 typeOfData:0];
    long mount = [workData count];
    for (int i = 0; i< mount ; i++) {
        //LONGITUD,LATITUD,TITULO,CIUDAD
        workData = [dataBase exQuery:myQuery columToReturn:1 typeOfData:0];
        NSString *title = workData[i];
        
        workData = [dataBase exQuery:myQuery columToReturn:5 typeOfData:0];
        double longitude = [workData[i] doubleValue];
        
        workData = [dataBase exQuery:myQuery columToReturn:6 typeOfData:0];
        double latitude = [workData[i] doubleValue];
        
        workData = [dataBase exQuery:myQuery columToReturn:2 typeOfData:1];//idCity
        NSString *idCity = workData[i];
        myQuery = [NSString stringWithFormat:@"SELECT * FROM city WHERE \"id\" = \"%@\"",idCity ];
        workData = [dataBase exQuery:myQuery columToReturn:1 typeOfData:0];
        NSString *subTitle = workData[0];
        
        [self setPin:latitude longitude:longitude title:title subTitle:subTitle];
        myQuery = @"SELECT * FROM places";
    }    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
//        case 2:
//            [self zoomIn:50.82191692907181 longitude:-0.13811767101287842];
//            break;
//            //        case 3:
            //            [self zoomOut];
            //            break;
        default:
            break;
    }
    mySegmentControl.selectedSegmentIndex = -1;
}

-(void)setPin:(double)latitude longitude:(double)longitude title:(NSString *)theTitle subTitle:(NSString *)theSubTitle{
    CLLocationCoordinate2D location =
    CLLocationCoordinate2DMake(latitude, longitude);
    TheMapPin *annotation =
    [[TheMapPin alloc] initWithCoordinates:location title:theTitle subTitle:theSubTitle];
    [myMapView addAnnotation:annotation];
}

@end
