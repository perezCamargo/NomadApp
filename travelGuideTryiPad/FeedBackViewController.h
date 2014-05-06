//
//  FeedBackViewController.h
//  travelGuideTryiPad
//
//  Created by Felipe Arturo Pérez Camargo on 10/03/14.
//  Copyright (c) 2014 Felipe Arturo Pérez Camargo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "iCarousel.h"
#import "DataController.h"

@interface FeedBackViewController : UIViewController<MFMailComposeViewControllerDelegate,iCarouselDataSource,iCarouselDelegate,UIActionSheetDelegate>{
}

@property(nonatomic,strong)IBOutlet iCarousel *myCarousel;
@property(nonatomic,strong)NSMutableArray *myItems;

@property(nonatomic,strong)MFMailComposeViewController *myMail;

@property(nonatomic,strong)DataController *dataBase;
@property(nonatomic,strong)NSString *myQuery;
@property(nonatomic,strong)NSMutableArray *workData;

-(IBAction)feedBack;
- (IBAction)switchCarouselType;
@end