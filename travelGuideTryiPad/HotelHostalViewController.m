//
//  HotelHostalViewController.m
//  travelGuideTryiPad
//
//  Created by Felipe Arturo Pérez Camargo on 05/03/14.
//  Copyright (c) 2014 Felipe Arturo Pérez Camargo. All rights reserved.
//

#import "HotelHostalViewController.h"

@interface HotelHostalViewController ()

@end

@implementation HotelHostalViewController
@synthesize idCountry,data,myQuery,workData;
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
    data = [[DataController alloc]init];
    [data initDataBase];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    myQuery = [NSString stringWithFormat:@"SELECT * FROM hotels WHERE \"idCountry\" = \"%@\"",idCountry];
    workData = [data exQuery:myQuery columToReturn:1 typeOfData:0];
    return [workData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    myQuery = [NSString stringWithFormat:@"SELECT * FROM hotels WHERE \"idCountry\" = \"%@\"",idCountry];
    workData = [data exQuery:myQuery columToReturn:1 typeOfData:0];
    TheCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
    if ([workData[indexPath.row]  isEqualToString: @"Hosteling International"]) {
        cell.theImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",workData[indexPath.row]]];
    }else{
        cell.theImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",workData[indexPath.row]]];
    }
    NSLog(@"NAME IMAGE: %@",workData[indexPath.row]);
    cell.theLabel.text = workData[indexPath.row];
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    myQuery = [NSString stringWithFormat:@"SELECT * FROM countries WHERE \"id\" = \"%@\"",idCountry];
    workData = [data exQuery:myQuery columToReturn:1 typeOfData:0];
    TheHeader * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header2" forIndexPath:indexPath];
    header.theLabel.text = [NSString stringWithFormat:@"Hotles and Hostels in %@", workData[0]];
    return header;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPat{
    webView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"WebView"];
    myQuery = [NSString stringWithFormat:@"SELECT * FROM hotels WHERE \"idCountry\" = \"%@\"",idCountry];
    workData = [data exQuery:myQuery columToReturn:3 typeOfData:0];
    webView.theURL = workData[indexPat.row];
    
    workData = [data exQuery:myQuery columToReturn:1 typeOfData:0];
    webView.theTempPic = [NSString stringWithFormat:@"%@demo.png",workData[indexPat.row]];
    
    [self presentViewController:webView animated:YES completion:nil];
}

@end
