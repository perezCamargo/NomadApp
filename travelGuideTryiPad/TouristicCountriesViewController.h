//
//  TouristicCountriesViewController.h
//  travelGuideTryiPad
//
//  Created by Felipe Arturo Pérez Camargo on 06/03/14.
//  Copyright (c) 2014 Felipe Arturo Pérez Camargo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableCell.h"
#import "DataController.h"
#import "DataDelegate.h"
#import "BestPlacesByCountryViewController.h"
#import "HotelHostalViewController.h"

@interface TouristicCountriesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    BestPlacesByCountryViewController *bestPlacesByCountryView;
    HotelHostalViewController *hotelHostalView;
}
@property(nonatomic,strong)DataController *dataBase;
@property(nonatomic,strong)NSString *myQuery;
@property(nonatomic,strong)NSMutableArray *workData;
@property(retain)id delegate;

@end
