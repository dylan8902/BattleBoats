//
//  Map.h
//  BattleBoats
//
//  Created by Dylan Jones on 15/11/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Annotation.h"

@interface MapViewController : UIViewController <MKMapViewDelegate> {

	MKMapView *map;
	UIButton *buttonBack;
	NSMutableData *responseData;
	
}

@property (nonatomic,retain) MKMapView *map;
@property (nonatomic,retain) UIButton *buttonBack;
@property (nonatomic,retain) NSMutableData *responseData;

- (void) goBack;

@end
