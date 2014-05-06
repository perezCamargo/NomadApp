//
//  TheMapPin.m
//  travelGuideTryiPad
//
//  Created by Felipe Arturo Pérez Camargo on 05/03/14.
//  Copyright (c) 2014 Felipe Arturo Pérez Camargo. All rights reserved.
//

#import "TheMapPin.h"

@implementation TheMapPin
@synthesize title,subtitle,coordinate;

- (instancetype) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString *)paramTitle subTitle:(NSString *)paramSubTitle{
    
    self = [super init];
    if (self != nil){
        coordinate = paramCoordinates;
        title = paramTitle;
        subtitle = paramSubTitle;
    }
    return self;
}

@end
