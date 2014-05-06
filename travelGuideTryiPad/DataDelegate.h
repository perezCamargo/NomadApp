//
//  DataDelegate.h
//  travelGuideTryiPad
//
//  Created by Felipe Arturo Pérez Camargo on 09/03/14.
//  Copyright (c) 2014 Felipe Arturo Pérez Camargo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataDelegate <NSObject>
@optional
-(void)sendCountryData:(NSString *)nameCountry;
@end
