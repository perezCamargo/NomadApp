//
//  BestPlacesByCountryViewController.h
//  travelGuideTryiPad
//
//  Created by Felipe Arturo Pérez Camargo on 06/03/14.
//  Copyright (c) 2014 Felipe Arturo Pérez Camargo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisplayInfoViewController.h"
#import "TheCell.h"
#import "TheHeader.h"
#import "DataController.h"

@interface BestPlacesByCountryViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>{
    DisplayInfoViewController *displayInfoView;
    
}
@property(nonatomic,strong)DataController *dataBase;
@property(nonatomic,strong)NSString *myQuery;
@property(nonatomic,strong)NSMutableArray *workData;
@property(nonatomic,strong)NSString *idCountry;
@property(nonatomic,strong)NSMutableArray *workFinalData;

- (IBAction)close;
-(void)fillWorkFinalData;

@end
