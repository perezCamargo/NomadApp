//
//  HotelHostalViewController.h
//  travelGuideTryiPad
//
//  Created by Felipe Arturo Pérez Camargo on 05/03/14.
//  Copyright (c) 2014 Felipe Arturo Pérez Camargo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TheCell.h"
#import "TheHeader.h"
#import "WebViewController.h"
#import "DataController.h"

@interface HotelHostalViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
    WebViewController *webView;
}
@property(nonatomic,strong)NSString *idCountry;
@property(nonatomic,strong)DataController *data;
@property(nonatomic,strong)NSString *myQuery;
@property(nonatomic,strong)NSMutableArray *workData;

-(IBAction)goBack;
@end
