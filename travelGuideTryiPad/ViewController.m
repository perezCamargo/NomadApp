//
//  ViewController.m
//  travelGuideTryiPad
//
//  Created by Felipe Arturo Pérez Camargo on 03/03/14.
//  Copyright (c) 2014 Felipe Arturo Pérez Camargo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize dataBase,myQuery,workData,myCarousel,myItems,titleLabel,placeImage,countryLabel,cityLabel,descriptionText,pinLatitude,pinLongitude,weatherId,tempLabel;
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	tag=@"yweather";
	// Do any additional setup after loading the view, typically from a nib.
    dataBase = [[DataController alloc]init];
    [dataBase initDataBase];
    
    myCarousel.type =iCarouselTypeWheel;
    
    UITabBarController *tabBarController = self.tabBarController;
    tabBarController.view.frame = CGRectMake(0, 0, 1024.0, 768.0);
    
    weatherId = [[NSMutableArray alloc]initWithObjects:@"115872",@"721943",@"455825",@"2151330",@"420371",@"1968716",@"2295399", nil];
    [self initView:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma marck carousel
- (void)awakeFromNib{
    
    myQuery = @"SELECT * FROM places WHERE \"wonder\" = \"1\"";
    myItems = [[NSMutableArray alloc]initWithObjects:@"Chichen Itza1.jpg",@"Roman Colosseum1.jpg",@"Christ the Redeemer1.jpg",@"Great Wall of China1.jpg",@"Machu Picchu1.jpg",@"Petra1.jpg",@"Taj Mahal1.jpg", nil];
    //myItems = [[dataBase exQuery:myQuery columToReturn:1 typeOfData:0]copy];
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    NSLog(@"The number of items: %li",(unsigned long)[myItems count]);
    return [myItems count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view{
    
    view = [[UIImageView alloc] initWithFrame:CGRectMake(138, 20, 175.0f, 175.0f)];
    ((UIImageView *)view).image = [UIImage imageNamed:myItems[index]];
    view.contentMode = UIViewContentModeCenter;
    return view;
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex >= 0)
    {
        //map button index to carousel type
        iCarouselType type = buttonIndex;
        
        //carousel can smoothly animate between types
        [UIView beginAnimations:nil context:nil];
        myCarousel.type = type;
        [UIView commitAnimations];
    }
}

-(IBAction)switchCarouselType{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Select Carousel Type"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"Linear", @"Rotary", @"Inverted Rotary", @"Cylinder", @"Inverted Cylinder", @"Wheel", @"Inverted Wheel", @"CoverFlow", @"Time Machine", @"Inverted Time Machine", nil];
    [sheet showInView:self.view];
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    int indexT = (int)index;
    
    [self initView:indexT];
    NSLog(@"This is the index: %i",indexT);
}

#pragma marck social
-(IBAction)facebook{
    SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    [controller setInitialText:@"I'm using Nomad App and its very usefull for me, just try it!"];
    [controller addImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",titleLabel.text]]];
    [controller addURL:nil];
    
    controller.completionHandler = ^(SLComposeViewControllerResult result){
        NSLog(@"Completed");
    };
    
    [self presentViewController:controller animated:YES completion:nil];
}

-(IBAction)twitter{
    SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    [controller setInitialText:@"Nomad App its amazing! #nomadApp"];
    [controller addImage:[UIImage imageNamed:@".jpg"]];
    [controller addURL:nil];
    
    controller.completionHandler = ^(SLComposeViewControllerResult result){
        NSLog(@"Completed");
    };
    
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma marck displayViews

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
    myQuery = [NSString stringWithFormat:@"SELECT * FROM countries WHERE \"name\" = \"%@\"", countryLabel.text];
    workData = [dataBase exQuery:myQuery columToReturn:0 typeOfData:1];
    hotelHostalView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"HotelHostalView"];
    hotelHostalView.idCountry = workData[0];
    [self presentViewController:hotelHostalView animated:YES completion:nil];
}

-(void)initView:(long)index{
        myQuery = @"SELECT * FROM places WHERE \"wonder\" = \"1\"";
        //TITLE,IMAGE,DESCRIPTION,LONGITUDE,LATITUDE;
        workData = [[dataBase exQuery:myQuery columToReturn:1 typeOfData:0]copy];

        titleLabel.text = workData[index];
        placeImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",workData[index]]];
        
        workData = [[dataBase exQuery:myQuery columToReturn:3 typeOfData:0]copy];
        descriptionText.text = workData[index];
        
        workData = [dataBase exQuery:myQuery columToReturn:5 typeOfData:2];
        pinLongitude = [workData[index] doubleValue];
        //NSLog(@"The longitude: %f",[workData[0] doubleValue]);
        workData = [dataBase exQuery:myQuery columToReturn:6 typeOfData:2];
        pinLatitude = [workData[index] doubleValue];
        //NSLog(@"The latitude: %f",[workData[0] doubleValue]);
        
        //CITY
        workData = [[dataBase exQuery:myQuery columToReturn:2 typeOfData:1]copy];
        myQuery = [NSString stringWithFormat:@"SELECT * FROM city WHERE \"id\" = \"%@\"",workData[index]];
        workData = [[dataBase exQuery:myQuery columToReturn:1 typeOfData:0]copy];
        cityLabel.text = workData[0];
        
        
        //COUNTRY
        workData = [[dataBase exQuery:myQuery columToReturn:2 typeOfData:1]copy];
        myQuery = [NSString stringWithFormat:@"SELECT * FROM countries WHERE \"id\" = \"%@\"",workData[0]];
        workData = [[dataBase exQuery:myQuery columToReturn:1 typeOfData:0]copy];
        countryLabel.text = workData[0];
    
    NSLog(@"thevalue: %@   & The index: %li",weatherId[index],index);
    [self getInfo:weatherId[index]];
    tempLabel.text = @"...";
}



#pragma mark weather

-  (void)parserDidStartDocument:(NSXMLParser *)parser
{
	xmlString=[[NSMutableString alloc]init];
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    //	if([tag isEqualToString:elementName])
    //	{
    //		tagFound=YES;
    //	}
    if ([elementName isEqualToString:@"yweather:condition"]){
        NSLog(@"weather %@",[attributeDict objectForKey:@"temp"]);
        tempLabel.text = [NSString stringWithFormat:@"%@ºC",[attributeDict objectForKey:@"temp"]];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	
}


- (void)parserDidEndDocument:(NSXMLParser *)parser
{
//    NSLog(@"parsed string ::::: %@",xmlString);
    
}

-(void)getInfo:(NSString *)place{
    
    NSString *urlAsString = [NSString stringWithFormat:@"http://weather.yahooapis.com/forecastrss?w=%@&u=c",place];
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        
        if ([data length] >0 && error == nil){
            
            NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"HTML = %@", html);
            xmlParser = [[NSXMLParser alloc] initWithData:data];
            [xmlParser setDelegate:self];
            [xmlParser parse];
            //            dispatch_sync(dispatch_get_main_queue(), ^{
            //
            //            theText.text=[NSString stringWithFormat:@"%@", html ];
            //                 });
            
        }else if ([data length] == 0 && error == nil){
            NSLog(@"Nothing was downloaded.");
        }else if (error != nil){
            NSLog(@"Error happened = %@", error);
        }
        
    }];
}

@end
