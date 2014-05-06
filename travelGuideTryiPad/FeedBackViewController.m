//
//  FeedBackViewController.m
//  travelGuideTryiPad
//
//  Created by Felipe Arturo Pérez Camargo on 10/03/14.
//  Copyright (c) 2014 Felipe Arturo Pérez Camargo. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()

@end

@implementation FeedBackViewController
@synthesize myMail,myCarousel,myItems,dataBase,myQuery,workData;
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
    dataBase = [[DataController alloc]init];
    [dataBase initDataBase];
    myCarousel.type =iCarouselTypeCylinder;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)feedBack{
    if ([MFMailComposeViewController canSendMail] == YES) {
        myMail = [[MFMailComposeViewController alloc]init];
        myMail.mailComposeDelegate = self;
        
        [myMail setSubject:@"Nomad feedback"];
        
        NSArray *recipients = [[NSArray alloc]initWithObjects:@"feedback@nomad.com", nil];
        [myMail setToRecipients:recipients];
        
        [myMail setMessageBody:@"Write your comments and suggestions to us." isHTML:NO];
        
        [self presentViewController:myMail animated:YES completion:nil];
    }else{
        UIAlertView *theAlert = [[UIAlertView alloc]initWithTitle:@"Error to send mail" message:@"Your device can not send email." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [theAlert show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result) {
        case MFMailComposeResultCancelled:
            
            break;
        case MFMailComposeResultFailed:{
            UIAlertView *theAlert = [[UIAlertView alloc]initWithTitle:@"Failed" message:@"Your email failed to send. Check your network conecction." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [theAlert show];
        }
            break;
        case MFMailComposeResultSaved:
            
            break;
        case MFMailComposeResultSent:{
            UIAlertView *theAlert = [[UIAlertView alloc]initWithTitle:@"Thank you" message:@"Thank you for you feedback." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [theAlert show];
        }
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)awakeFromNib{
    
    myQuery = @"SELECT * FROM places WHERE \"wonder\" = \"1\"";
    myItems = [[NSMutableArray alloc]initWithObjects:@"Chichen Itza.jpg",@"Roman Colosseum.jpg",@"Christ the Redeemer.jpg",@"Great Wall of China.jpg",@"Machu Picchu.jpg",@"Petra.jpg",@"Taj Mahal.jpg", nil];
    //myItems = [[NSMutableArray alloc]initWithObjects:@"Chichen Itza2.jpg",@"Roman Colosseum2.jpg",@"Christ the Redeemer2.jpg",@"Great Wall of China2.jpg",@"Machu Picchu2.jpg",@"Petra2.jpg",@"Taj Mahal2.jpg", nil];
    //myItems = [[dataBase exQuery:myQuery columToReturn:1 typeOfData:0]copy];
    
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    
    //return the total number of items in the carousel
    NSLog(@"The number of items: %li",(unsigned long)[myItems count]);
    return [myItems count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view{
    
    //don't do anything specific to the index within
    //this `if (view == nil) {...}` statement because the view will be
    //recycled and used with other index values later
    view = [[UIImageView alloc] initWithFrame:CGRectMake(83, 10, 600.0f, 600.0f)];
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

@end
