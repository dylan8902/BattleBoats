//
//  BattleBoatsViewController.h
//  BattleBoats
//
//  Created by Dylan Jones on 19/10/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "BattleBoatsAppDelegate.h"

@interface BattleBoatsViewController : UIViewController {
	
	UIButton *buttonNewGame;
	UIButton *buttonMultiplayer;
	UIButton *buttonHighScores;
	UISlider *sliderDifficulty;
	UILabel *labelDifficulty;
	UISegmentedControl *segTeamColor;
	Game *localGameData;
	
}

@property (nonatomic,retain) UIButton *buttonNewGame;
@property (nonatomic,retain) UIButton *buttonMultiplayer;
@property (nonatomic,retain) UIButton *buttonHighScores;
@property (nonatomic,retain) UISlider *sliderDifficulty;
@property (nonatomic,retain) UILabel *labelDifficulty;
@property (nonatomic,retain) UISegmentedControl *segTeamColor;
@property (nonatomic,retain) Game *localGameData;

- (void) newGame;
- (void) multiplayer;
- (void) highScores;
- (void) difficultySliderChanged;

@end

