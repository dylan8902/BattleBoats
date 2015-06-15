//
//  Annotation.h
//  BattleBoats
//
//  Created by Dylan Jones on 16/11/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface Annotation : NSObject<MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	NSString *title;
	NSString *subtitle;
}

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *subtitle;

@end
