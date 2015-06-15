//
//  Annotation.m
//  BattleBoats
//
//  Created by Dylan Jones on 16/11/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation
@synthesize coordinate,title,subtitle;
-(void)dealloc{
	[title release];
	[subtitle release];
	[super dealloc];
}
@end
