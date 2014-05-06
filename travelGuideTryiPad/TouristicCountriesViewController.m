//
//  TouristicCountriesViewController.m
//  travelGuideTryiPad
//
//  Created by Felipe Arturo Pérez Camargo on 06/03/14.
//  Copyright (c) 2014 Felipe Arturo Pérez Camargo. All rights reserved.
//

#import "TouristicCountriesViewController.h"

@interface TouristicCountriesViewController ()

@end

@implementation TouristicCountriesViewController
@synthesize dataBase,workData,myQuery,delegate;
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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    myQuery = @"SELECT * FROM countries";
    return [[dataBase exQuery:myQuery columToReturn:1 typeOfData:0]count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    myQuery = @"SELECT * FROM countries";
    workData = [dataBase exQuery:myQuery columToReturn:1 typeOfData:0];
    
    static NSString *CellIdentifier = @"tableCell";
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.countryImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",workData[indexPath.row]]];
    cell.countryLabel.text = workData[indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Touristic Countries";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    bestPlacesByCountryView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"BestPlacesByCountryView"];
    bestPlacesByCountryView.idCountry = workData[indexPath.row];
    [self presentViewController:bestPlacesByCountryView animated:YES completion:nil];
}

@end
