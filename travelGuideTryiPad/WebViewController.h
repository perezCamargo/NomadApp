//
//  WebViewController.h
//  travelGuideTryiPad
//
//  Created by Felipe Arturo Pérez Camargo on 05/03/14.
//  Copyright (c) 2014 Felipe Arturo Pérez Camargo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"

@interface WebViewController : UIViewController<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *back;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *stop;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *refresh;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *forward;
@property (strong, nonatomic) IBOutlet UILabel *pageTitle;
@property (strong, nonatomic) IBOutlet UIToolbar *myToolBar;
@property (nonatomic, strong) NSString *theURL;
@property(nonatomic,strong)NSString *theTempPic;

@property(nonatomic)Reachability *reachability;
@property(nonatomic,strong)UIImageView *myImage;


- (void)loadRequestFromString:(NSString*)urlString;
- (void)updateButtons;
- (void)updateTitle:(UIWebView*)aWebView;
-(IBAction)close;
@end
