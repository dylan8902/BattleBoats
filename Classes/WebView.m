    //
//  WebView.m
//  BattleBoats
//
//  Created by Dylan Jones on 26/10/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WebView.h"
#import "MapView.h"


@implementation WebViewController

@synthesize webView;
@synthesize buttonBack;
@synthesize buttonMap;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,320,480)];
	[self.view addSubview:webView];
	NSString *urlString = @"http://dylanjones.info/battleboats/highscores";
	NSURL *url = [NSURL URLWithString:urlString];
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
	webView.scalesPageToFit = TRUE;
	[webView loadRequest:urlRequest];
	
	buttonBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	buttonBack.frame = CGRectMake(0,0,60,40);
	buttonBack.center = CGPointMake(280,430);
	[buttonBack setTitle:@"Back" forState:UIControlStateNormal];
	[buttonBack addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:buttonBack];
	
	buttonMap = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	buttonMap.frame = CGRectMake(0,0,60,40);
	buttonMap.center = CGPointMake(210,430);
	[buttonMap setTitle:@"Map" forState:UIControlStateNormal];
	[buttonMap addTarget:self action:@selector(gotoMap) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:buttonMap];
	
}

- (void) goBack {
	[self dismissModalViewControllerAnimated:YES];
}

- (void) gotoMap {	
	MapViewController *mapView = [[MapViewController alloc] init];
	mapView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:mapView animated:YES];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
	webView = nil;
	buttonBack = nil;
}


- (void)dealloc {
    [super dealloc];
	[webView release];
	[buttonBack release];

}

@end
