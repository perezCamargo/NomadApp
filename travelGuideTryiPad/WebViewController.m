//
//  WebViewController.m
//  travelGuideTryiPad
//
//  Created by Felipe Arturo Pérez Camargo on 05/03/14.
//  Copyright (c) 2014 Felipe Arturo Pérez Camargo. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
@synthesize myWebView,back,stop,refresh,forward,pageTitle,theURL,reachability,theTempPic,myImage;

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
    reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    if(remoteHostStatus == NotReachable) {
        NSLog(@"not reachable");
//        UIImage *theImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 43, 1024.0f, 681.0f)];
//        theImage.image = [UIImage imageNamed:theTempPic];
        
        UIImage *theImage = [UIImage imageNamed:theTempPic];
        //myImage = [[UIImageView alloc] initWithImage:theImage];
        myImage = [[[UIImageView alloc]initWithFrame:CGRectMake( 0, 75, 1024.0f, 650.0f)]initWithImage:theImage];
        
        [self.view addSubview:myImage];
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"No Network" message:@"Device has not internet conection, this is a demo image" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [myAlertView show];
    }else{
        NSLog(@"reachable");
        NSAssert([myWebView isKindOfClass:[UIWebView class]], @"You webView outlet is not correctly connected.");
        NSAssert(back, @"Your back button outlet is not correctly connected");
        NSAssert(stop, @"Your stop button outlet is not correctly connected");
        NSAssert(refresh, @"Your refresh button outlet is not correctly connected");
        NSAssert(forward, @"Your forward button outlet is not correctly connected");
        NSAssert((back.target == myWebView) && (back.action = @selector(goBack)), @"Your back button action is not connected to goBack.");
        NSAssert((stop.target == myWebView) && (stop.action = @selector(stopLoading)), @"Your stop button action is not connected to stopLoading.");
        NSAssert((refresh.target == myWebView) && (refresh.action = @selector(reload)), @"Your refresh button action is not connected to reload.");
        NSAssert((forward.target == myWebView) && (forward.action = @selector(goForward)), @"Your forward button action is not connected to goForward.");
        NSAssert(myWebView.scalesPageToFit, @"You forgot to check 'Scales Page to Fit' for your web view.");
        
        myWebView.delegate = self;
        [self loadRequestFromString:theURL];
    }
    
    
//    NSAssert([myWebView isKindOfClass:[UIWebView class]], @"You webView outlet is not correctly connected.");
//    NSAssert(back, @"Your back button outlet is not correctly connected");
//    NSAssert(stop, @"Your stop button outlet is not correctly connected");
//    NSAssert(refresh, @"Your refresh button outlet is not correctly connected");
//    NSAssert(forward, @"Your forward button outlet is not correctly connected");
//    NSAssert((back.target == myWebView) && (back.action = @selector(goBack)), @"Your back button action is not connected to goBack.");
//    NSAssert((stop.target == myWebView) && (stop.action = @selector(stopLoading)), @"Your stop button action is not connected to stopLoading.");
//    NSAssert((refresh.target == myWebView) && (refresh.action = @selector(reload)), @"Your refresh button action is not connected to reload.");
//    NSAssert((forward.target == myWebView) && (forward.action = @selector(goForward)), @"Your forward button action is not connected to goForward.");
//    NSAssert(myWebView.scalesPageToFit, @"You forgot to check 'Scales Page to Fit' for your web view.");
//    
//    myWebView.delegate = self;
//    [self loadRequestFromString:theURL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadRequestFromString:(NSString*)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [myWebView loadRequest:urlRequest];
}

- (void)updateButtons
{
    forward.enabled = myWebView.canGoForward;
    back.enabled = myWebView.canGoBack;
    stop.enabled = myWebView.loading;
}

- (void)updateTitle:(UIWebView*)aWebView
{
    NSString *pageTitleText = [aWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
    pageTitle.text = pageTitleText;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self updateButtons];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateButtons];
    [self updateTitle:webView];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateButtons];
}

@end
