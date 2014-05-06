//
//  DisplayInfoViewController.m
//  travelGuideTryiPad
//
//  Created by Felipe Arturo Pérez Camargo on 04/03/14.
//  Copyright (c) 2014 Felipe Arturo Pérez Camargo. All rights reserved.
//

#import "DisplayInfoViewController.h"

@interface DisplayInfoViewController ()

@end

@implementation DisplayInfoViewController
@synthesize titleLabel,placeImage,countryLabel,cityLabel,descriptionText,pinLatitude,pinLongitude,data,myQuery,workData;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)seeMap{
    mapLocationPlaceView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"MapLocationPlaceView"];
    mapLocationPlaceView.pinTitle = titleLabel.text;
    mapLocationPlaceView.pinSubTitle = cityLabel.text;
    mapLocationPlaceView.pinLatitude = pinLatitude;
    mapLocationPlaceView.pinLongitude = pinLongitude;    
    NSLog(@"The latitude: %f",pinLatitude);
    NSLog(@"The longitude: %f",pinLongitude);
    [self presentViewController:mapLocationPlaceView animated:YES completion:nil];
    
}

-(IBAction)seeHotel{
    data = [[DataController alloc]init];
    [data initDataBase];
    myQuery = [NSString stringWithFormat:@"SELECT * FROM countries WHERE \"name\" = \"%@\"", countryLabel.text];
    workData = [data exQuery:myQuery columToReturn:0 typeOfData:1];
    hotelHostalView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"HotelHostalView"];
    hotelHostalView.idCountry = workData[0];
    //NSLog(@"the ID: %@", workData[0]);
    [self presentViewController:hotelHostalView animated:YES completion:nil];
}

-(IBAction)facebook{
//    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:@"I'm using Nomad App and its very usefull for me, just try it!"];
        [controller addImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",titleLabel.text]]];
        [controller addURL:nil];
       
        controller.completionHandler = ^(SLComposeViewControllerResult result){
            NSLog(@"Completed");
        };
        
        [self presentViewController:controller animated:YES completion:nil];
        
//    } else {
//        NSLog(@"The facebook service is not available");
//    }
}

-(IBAction)twitter{
//    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [controller setInitialText:@"Nomad App its amazing! #nomadApp"];
        [controller addImage:[UIImage imageNamed:@".jpg"]];
        [controller addURL:nil];
        
        controller.completionHandler = ^(SLComposeViewControllerResult result){
            NSLog(@"Completed");
        };
        
        [self presentViewController:controller animated:YES completion:nil];
        
//    } else {
//        NSLog(@"The twitter service is not available");
//    }
}

@end
