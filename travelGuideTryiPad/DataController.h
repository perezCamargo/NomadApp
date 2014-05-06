//
//  DataController.h
//  travelGuideTryiPad
//
//  Created by Felipe Arturo Pérez Camargo on 03/03/14.
//  Copyright (c) 2014 Felipe Arturo Pérez Camargo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DataController : NSObject{
    sqlite3 *databaseHandle;
    NSArray *paths;
    NSString *documentsDirectory;
    NSString *databasePath;
}

-(void)initDataBase;
-(void)insert;
-(void)drop;
-(NSMutableArray *)exQuery:(NSString *)query columToReturn:(int)colum typeOfData:(int)type;
//-(NSMutableArray *)exQuery2:(NSString *)query;

@end
