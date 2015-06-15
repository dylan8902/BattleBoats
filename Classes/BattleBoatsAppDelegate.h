//
//  BattleBoatsAppDelegate.h
//  BattleBoats
//
//  Created by Dylan Jones on 19/10/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

@class BattleBoatsViewController;

@interface BattleBoatsAppDelegate : NSObject <UIApplicationDelegate> {
	
    UIWindow *window;
    BattleBoatsViewController *viewController;
	Game *gameData;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet BattleBoatsViewController *viewController;
@property (nonatomic, retain) Game * gameData;

@end

