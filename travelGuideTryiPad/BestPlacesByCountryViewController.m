//
//  BestPlacesByCountryViewController.m
//  travelGuideTryiPad
//
//  Created by Felipe Arturo Pérez Camargo on 06/03/14.
//  Copyright (c) 2014 Felipe Arturo Pérez Camargo. All rights reserved.
//

#import "BestPlacesByCountryViewController.h"

@interface BestPlacesByCountryViewController ()

@end

@implementation BestPlacesByCountryViewController
@synthesize idCountry,dataBase,myQuery,workData,workFinalData;
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
    [self fillWorkFinalData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [workFinalData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TheCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell3" forIndexPath:indexPath];
    cell.theImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",workFinalData[indexPath.row]]];
    cell.theLabel.text = workFinalData[indexPath.row];
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    TheHeader * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header3" forIndexPath:indexPath];
    header.theLabel.text = [NSString stringWithFormat:@"Best Tourist Places from %@", idCountry]
    ;
    return header;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPat{
    displayInfoView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"DisplayInfoView"];
    [self presentViewController:displayInfoView animated:YES completion:nil];
    //TITLE,IMAGE,DESCRIPTION,LONGITUDE,LATITUDE;
    myQuery = [NSString stringWithFormat:@"SELECT * FROM places WHERE \"name\" = \"%@\"",workFinalData[indexPat.row]];
    
    workData = [[dataBase exQuery:myQuery columToReturn:1 typeOfData:0]copy];
    displayInfoView.titleLabel.text = workData[0];
    displayInfoView.placeImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",workData[0]]];
    
    workData = [[dataBase exQuery:myQuery columToReturn:3 typeOfData:0]copy];
    displayInfoView.descriptionText.text = workData[0];
    
    workData = [dataBase exQuery:myQuery columToReturn:5 typeOfData:2];
    displayInfoView.pinLongitude = [workData[0] doubleValue];
    //NSLog(@"The longitude: %f",[workData[0] doubleValue]);
    workData = [dataBase exQuery:myQuery columToReturn:6 typeOfData:2];
    displayInfoView.pinLatitude = [workData[0] doubleValue];
    //NSLog(@"The latitude: %f",[workData[0] doubleValue]);
    
    
    //CITY
    workData = [[dataBase exQuery:myQuery columToReturn:2 typeOfData:1]copy];
    myQuery = [NSString stringWithFormat:@"SELECT * FROM city WHERE \"id\" = \"%@\"",workData[0]];
    workData = [[dataBase exQuery:myQuery columToReturn:1 typeOfData:0]copy];
    displayInfoView.cityLabel.text = workData[0];
    
    
    //COUNTRY
    workData = [[dataBase exQuery:myQuery columToReturn:2 typeOfData:1]copy];
    myQuery = [NSString stringWithFormat:@"SELECT * FROM countries WHERE \"id\" = \"%@\"",workData[0]];
    workData = [[dataBase exQuery:myQuery columToReturn:1 typeOfData:0]copy];
    displayInfoView.countryLabel.text = workData[0];
}

- (IBAction)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)fillWorkFinalData{
    workFinalData = [[NSMutableArray alloc]init];
    myQuery = [NSString stringWithFormat:@"SELECT * FROM countries WHERE \"name\" = \"%@\"",idCountry];
    workData = [dataBase exQuery:myQuery columToReturn:0 typeOfData:0];
    myQuery = [NSString stringWithFormat:@"SELECT * FROM city WHERE \"idCountry\" = \"%@\"",workData[0]];
    workData = [dataBase exQuery:myQuery columToReturn:0 typeOfData:0];
    long size = [workData count];
    NSLog(@"The First size: %li",size);
    for (int i = 0; i < size; i++) {
        myQuery = [NSString stringWithFormat:@"SELECT * FROM places WHERE \"idCity\" = \"%@\"",workData[i]];
        NSMutableArray *workData2 =[dataBase exQuery:myQuery columToReturn:1 typeOfData:0];
        long subSize = [workData2 count];
        NSLog(@"The subsize: %li", subSize);
        for (int j = 0; j < subSize ; j++){
            [workFinalData addObject:[NSString stringWithFormat:@"%@",workData2[j]]];
            NSLog(@"The data2: %@",workData2[j]);
        }
    }
    NSLog(@"The size: %li",(unsigned long)[workFinalData count]);
}
@end
