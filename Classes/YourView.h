//
//  Menu.h
//  BattleBoats
//
//  Created by Dylan Jones on 19/10/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Game.h"
#import "BattleBoatsAppDelegate.h"

@interface YourViewController : UIViewController <UIAlertViewDelegate, CLLocationManagerDelegate> {

	UIButton *buttonMenu;
	UILabel *labelTeamScore;
	UILabel *labelOpponentScore;
	UILabel *labelWaiting;
	UIAlertView *alertHighScore;
	UITextField *nicknameField;
	CLLocationManager *userLocationManager;
	CLLocation *userLocation;
	UILabel *team_boat1;
	UILabel *team_boat2;
	UILabel *team_boat3;
	UILabel *team_boat4;
	UILabel *team_boat5;
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
@property (nonatomic,retain) UIAlertView *alertHighScore;
@property (nonatomic,retain) UITextField *nicknameField;
@property (nonatomic,retain) CLLocationManager *userLocationManager;
@property (nonatomic,retain) CLLocation *userLocation;
@property (nonatomic,retain) UILabel *team_boat1;
@property (nonatomic,retain) UILabel *team_boat2;
@property (nonatomic,retain) UILabel *team_boat3;
@property (nonatomic,retain) UILabel *team_boat4;
@property (nonatomic,retain) UILabel *team_boat5;
@property (nonatomic,retain) UILabel *explosion;
@property (nonatomic,retain) UILabel *splash;
@property (nonatomic,retain) AVAudioPlayer *sfxExplosionPlayer;
@property (nonatomic,retain) AVAudioPlayer *sfxSplashPlayer;
@property (nonatomic,retain) Game *localGameData;

- (void) gotoMenu;
- (void) gotoOpponentView;
- (void) opponentReady;

@end
