//
//  MultiplayerSetupView.h
//  BattleBoats
//
//  Created by Dylan Jones on 19/11/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "BattleBoatsAppDelegate.h"

@interface MultiplayerSetupView : UIViewController {
	
	UIButton *buttonMenu;
	UIButton *buttonJoin;
	UILabel *labelUid;
	Game *localGameData;

}

@property (nonatomic,retain) UIButton *buttonMenu;
@property (nonatomic,retain) UIButton *buttonJoin;
@property (nonatomic,retain) UILabel *labelUid;
@property (nonatomic,retain) Game *localGameData;

- (void) gotoMenu;
- (void) checkOpponent;
- (void) joinGame:(id)sender;

@end
