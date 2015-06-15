//
//  Map.m
//  BattleBoats
//
//  Created by Dylan Jones on 15/11/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapView.h"
#import "Annotation.h"

@implementation MapViewController

@synthesize map;
@synthesize buttonBack;
@synthesize responseData;

- (void)viewDidLoad {
    [super viewDidLoad];

	//Initiate map view
	map = [[MKMapView alloc] initWithFrame:CGRectMake(0,0,320,480)];
	map.delegate = self;
	map.showsUserLocation = YES;
	[map setDelegate:self];
	[map setMapType:MKMapTypeStandard];
	[map setZoomEnabled:YES];
	[map setScrollEnabled:YES];
	[self.view addSubview:map];
	
	NSError *error;
	NSString *urlString = @"http://api.dylanjones.info/battleboats/map";
    NSString *responseString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:&error];
	if(responseString) {
		NSArray *highscores = [responseString componentsSeparatedByString:@";"];
		for( int a=0; a<[highscores count]; a++) {
			NSArray *thisGuy = [[highscores objectAtIndex:a] componentsSeparatedByString:@","];
			if([thisGuy count]==6) {
				double latitude;
				double longitude;
				
				latitude = [[thisGuy objectAtIndex:2] doubleValue];
				longitude = [[thisGuy objectAtIndex:3] doubleValue];
				
				CLLocationCoordinate2D location;
				location.latitude = latitude;
				location.longitude = longitude;
				
				Annotation *ann = [[Annotation alloc] init]; 
				ann.title = [thisGuy objectAtIndex:0];
				ann.subtitle = [@"scored " stringByAppendingString:[thisGuy objectAtIndex:1]];
				ann.coordinate = location; 
				[map addAnnotation:ann];
			}
		}
	}
	else {
		NSLog(@"Error: %&",error);
	}
		
	buttonBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	buttonBack.frame = CGRectMake(0,0,60,40);
	buttonBack.center = CGPointMake(280,430);
	[buttonBack setTitle:@"Back" forState:UIControlStateNormal];
	[buttonBack addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:buttonBack];
		
}


- (void) goBack {
	NSLog(@"Go back a view");
	[self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	map = nil;
	buttonBack = nil;
}


- (void)dealloc {
    [super dealloc];

	[map release];
	[buttonBack release];
}


@end
