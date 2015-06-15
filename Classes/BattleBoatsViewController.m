//
//  BattleBoatsViewController.m
//  BattleBoats
//
//  Created by Dylan Jones on 19/10/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BattleBoatsViewController.h"
#import "YourView.h"
#import "WebView.h"
#import "MultiplayerSetupView.h"
#import "BattleBoatsAppDelegate.h"
#import "Game.h"

@implementation BattleBoatsViewController

@synthesize buttonNewGame;
@synthesize buttonHighScores;
@synthesize buttonMultiplayer;
@synthesize sliderDifficulty;
@synthesize labelDifficulty;
@synthesize segTeamColor;
@synthesize localGameData;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	//INITIALISE GAME DATA AND STORE AS LOCAL
	BattleBoatsAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	localGameData = [appDelegate gameData];
		
	//INITIALISE BACKGROUND IMAGE
	UIColor *backgroundImage = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"menu.png"]];
	self.view.backgroundColor = backgroundImage;
	[backgroundImage release];
	
	//INITIALISE NEW GAME BUTTON
	buttonNewGame = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	buttonNewGame.frame = CGRectMake(0, 0, 90, 35);
	buttonNewGame.center = CGPointMake(320/2, 190);	
	[buttonNewGame setTitle:@"New Game" forState:UIControlStateNormal];
	[buttonNewGame addTarget:self action:@selector(newGame) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:buttonNewGame];
	
	//INITIALISE MULTIPLAYER BUTTON
	buttonMultiplayer = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	buttonMultiplayer.frame = CGRectMake(0, 0, 90, 35);
	buttonMultiplayer.center = CGPointMake(320/2, 235);	
	[buttonMultiplayer setTitle:@"Multiplayer" forState:UIControlStateNormal];
	[buttonMultiplayer addTarget:self action:@selector(multiplayer) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:buttonMultiplayer];
	
	//INITIALISE HIGH SCORES
	buttonHighScores = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	buttonHighScores.frame = CGRectMake(0, 0, 100, 35);
	buttonHighScores.center = CGPointMake(320/2, 280);	
	[buttonHighScores setTitle:@"High Scores" forState:UIControlStateNormal];
	[buttonHighScores addTarget:self action:@selector(highScores) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:buttonHighScores];
		
	//INITIALISE DIFFICULTY LEVEL SLIDER
	sliderDifficulty = [[UISlider alloc] initWithFrame:CGRectMake(70, 340, 190, 15)];
	[sliderDifficulty addTarget:self action:@selector(difficultySliderChanged) forControlEvents:UIControlEventValueChanged];
	[sliderDifficulty setMaximumValue:5];
	[sliderDifficulty setMinimumValue:2];
	sliderDifficulty.value = 4;
	[self.view addSubview:sliderDifficulty];
	
	//INITIALISE DIFFICULTY LEVEL INDICATOR
	labelDifficulty = [[UILabel alloc] initWithFrame:CGRectMake(50,305,210,30)];
	labelDifficulty.text = @"Easy";
	labelDifficulty.font = [UIFont fontWithName:@"Helvetica" size:20.0];
	[labelDifficulty setTextAlignment:UITextAlignmentCenter];
	labelDifficulty.textColor = [UIColor blackColor];
	labelDifficulty.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
	[self.view addSubview:labelDifficulty];	
	
	//INITIALISE TEAM COLOUR SEGMENTS
	NSArray *segItems = [NSArray arrayWithObjects:@"Blue",@"Red",nil];
	segTeamColor = [[UISegmentedControl alloc] initWithItems:segItems];
	[segTeamColor setFrame:CGRectMake(80,380,170,40)];
	segTeamColor.selectedSegmentIndex = 0;
	[self.view addSubview:segTeamColor];
	
}

- (void) newGame {
	NSLog(@"A new game should be initialised");	
	
	//RESET GAME DATA	
	localGameData.teamColor = segTeamColor.selectedSegmentIndex;
	localGameData.difficulty = (int) sliderDifficulty.value;
	
	localGameData.turnNumber = 0;
	localGameData.teamScore = 0;
	localGameData.opponentScore = 0;
	localGameData.teamNumberOfBoatsSunk = 0;
	localGameData.opponentNumberOfBoatsSunk = 0;
	
	localGameData.teamMoves = [[NSMutableArray alloc] init];
	for (int i=1; i<= 91; i++)
		[localGameData.teamMoves addObject:[NSNumber numberWithInt:0]];

	localGameData.opponentMoves = [[NSMutableArray alloc] init];
	for (int i=1; i<= 91; i++)
		[localGameData.opponentMoves addObject:[NSNumber numberWithInt:0]];
	
	localGameData.MP_flag = 0;
	
	localGameData.team_boat1_x = 0;
	localGameData.team_boat1_y = 0;
	
	localGameData.team_boat2_x = 0;
	localGameData.team_boat2_y = 0;
	
	localGameData.team_boat3_x = 0;
	localGameData.team_boat3_y = 0;
	
	localGameData.team_boat4_x = 0;
	localGameData.team_boat4_y = 0;
	
	localGameData.team_boat5_x = 0;
	localGameData.team_boat5_y = 0;
	
	localGameData.opponent_boat1_x = 0;
	localGameData.opponent_boat1_y = 0;
	
	localGameData.opponent_boat2_x = 0;
	localGameData.opponent_boat2_y = 0;
	
	localGameData.opponent_boat3_x = 0;
	localGameData.opponent_boat3_y = 0;
	
	localGameData.opponent_boat4_x = 0;
	localGameData.opponent_boat4_y = 0;
	
	localGameData.opponent_boat5_x = 0;
	localGameData.opponent_boat5_y = 0;
	
	YourViewController *yourView = [[YourViewController alloc] init];
	yourView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	[self presentModalViewController:yourView animated:YES];
	[yourView release];
}

- (void) multiplayer {
	NSLog(@"The multiplayer flag is raised and goto setup");
	
	//SET GAME DATA
	localGameData.teamColor = segTeamColor.selectedSegmentIndex;
	localGameData.difficulty = 4;
	
	localGameData.turnNumber = 0;
	localGameData.teamScore = 0;
	localGameData.opponentScore = 0;
	localGameData.teamNumberOfBoatsSunk = 0;
	localGameData.opponentNumberOfBoatsSunk = 0;
	
	localGameData.teamMoves = [[NSMutableArray alloc] init];
	for (int i=1; i<= 91; i++)
		[localGameData.teamMoves addObject:[NSNumber numberWithInt:0]];
	
	localGameData.opponentMoves = [[NSMutableArray alloc] init];
	for (int i=1; i<= 91; i++)
		[localGameData.opponentMoves addObject:[NSNumber numberWithInt:0]];
	
	localGameData.MP_flag = 1;
	localGameData.MP_uid = 0;
	localGameData.MP_gid = 0;

	localGameData.team_boat1_x = 0;
	localGameData.team_boat1_y = 0;
	
	localGameData.team_boat2_x = 0;
	localGameData.team_boat2_y = 0;
	
	localGameData.team_boat3_x = 0;
	localGameData.team_boat3_y = 0;
	
	localGameData.team_boat4_x = 0;
	localGameData.team_boat4_y = 0;
	
	localGameData.team_boat5_x = 0;
	localGameData.team_boat5_y = 0;
	
	localGameData.opponent_boat1_x = 0;
	localGameData.opponent_boat1_y = 0;
	
	localGameData.opponent_boat2_x = 0;
	localGameData.opponent_boat2_y = 0;
	
	localGameData.opponent_boat3_x = 0;
	localGameData.opponent_boat3_y = 0;
	
	localGameData.opponent_boat4_x = 0;
	localGameData.opponent_boat4_y = 0;
	
	localGameData.opponent_boat5_x = 0;
	localGameData.opponent_boat5_y = 0;
	
	MultiplayerSetupView *multiplayerView = [[MultiplayerSetupView alloc] init];
	multiplayerView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	[self presentModalViewController:multiplayerView animated:YES];
	[multiplayerView release];
	
}

- (void) highScores {
	NSLog(@"A tab bar delegate view with the high scores should initialise");
	WebViewController *webView = [[WebViewController alloc] init];
	webView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	[self presentModalViewController:webView animated:YES];
	[webView release];
}


- (void) difficultySliderChanged {
	NSLog(@"Difficulty level now: %f",sliderDifficulty.value);
	if(sliderDifficulty.value==2)
		labelDifficulty.text = @"Very Hard";
	else if(sliderDifficulty.value<3)
		labelDifficulty.text = @"Hard";
	else if(sliderDifficulty.value<4)
		labelDifficulty.text = @"Easy";
	else if(sliderDifficulty.value==5)
		labelDifficulty.text = @"Very Easy";

}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	
	sliderDifficulty = nil;
	labelDifficulty = nil;
	
}


- (void)dealloc {
    [super dealloc];
	
	[sliderDifficulty release];
	[labelDifficulty release];

}

@end
