//
//  OpponentView.h
//  BattleBoats
//
//  Created by Dylan Jones on 19/10/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>;
#import "Game.h"
#import "BattleBoatsAppDelegate.h"

@interface OpponentViewController : UIViewController {
	
	UIButton *buttonMenu;
	UILabel *labelTeamScore;
	UILabel *labelOpponentScore;
	UILabel *labelWaiting;
	UILabel *explosion;
	UILabel *splash;
	AVAudioPlayer *sfxExplosionPlayer;
	AVAudioPlayer *sfxSplashPlayer;
	Game *localGameData;
}

@property (nonatomic,retain) UIButton *buttonMenu;
@property (nonatomic,retain) UILabel *labelTeamScore;
@property (nonatomic,retain) UILabel *labelOpponentScore;
@property (nonatomic,retain) UILabel *labelWaiting;
@property (nonatomic,retain) UILabel *explosion;
@property (nonatomic,retain) UILabel *splash;
@property (nonatomic,retain) AVAudioPlayer *sfxExplosionPlayer;
@property (nonatomic,retain) AVAudioPlayer *sfxSplashPlayer;
@property (nonatomic,retain) Game *localGameData;

- (void) goBack;
- (void) opponentReady;

@end
