//
//  Menu.m
//  BattleBoats
//
//  Created by Dylan Jones on 19/10/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "YourView.h"
#import "MultiplayerSetupView.h"
#import "OpponentView.h"
#import "Game.h"

@implementation YourViewController

@synthesize buttonMenu;
@synthesize labelTeamScore;
@synthesize labelOpponentScore;
@synthesize labelWaiting;
@synthesize alertHighScore;
@synthesize	nicknameField;
@synthesize userLocationManager;
@synthesize userLocation;
@synthesize team_boat1;
@synthesize team_boat2;
@synthesize team_boat3;
@synthesize team_boat4;
@synthesize team_boat5;
@synthesize explosion;
@synthesize splash;
@synthesize sfxExplosionPlayer;
@synthesize sfxSplashPlayer;
@synthesize localGameData;


- (void)viewDidLoad {
	[super viewDidLoad];
	
	//INITALISE GLOBAL DATA AND STORE AS LOCAL
	BattleBoatsAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	localGameData = [appDelegate gameData];
	
	//INITIALISE BACKGROUND IMAGE
	NSString *background = @"blue.png";
	if(localGameData.teamColor==1) {
		background = @"red.png";
	}
	UIColor *backgroundImage = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:background]];
	self.view.backgroundColor = backgroundImage;
	[background release];
	[backgroundImage release];
	
	//INITIALISE MENU BUTTON
	buttonMenu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	buttonMenu.frame = CGRectMake(0, 0, 60, 30);
	buttonMenu.center = CGPointMake(285, 440);
	[buttonMenu setTitle:@"Menu" forState:UIControlStateNormal];
	[buttonMenu addTarget:self action:@selector(gotoMenu) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:buttonMenu];
	
	//INITIALISE TEAM SCORE CARD
	float red;
	float blue;
	if(localGameData.teamColor==1) {
		red = 50;
		blue = 0;
	}
	else {
		red = 0;
		blue = 50;
	}
	//TEAM SCORE LABEL
	labelTeamScore = [[UILabel alloc] initWithFrame:CGRectMake(10,425,70,30)];
	labelTeamScore.text = @"0";
	labelTeamScore.font = [UIFont fontWithName:@"Helvetica" size:25.0];
	[labelTeamScore setTextAlignment:UITextAlignmentCenter];
	labelTeamScore.textColor = [UIColor whiteColor];
	labelTeamScore.backgroundColor = [UIColor colorWithRed:red green:0.0 blue:blue alpha:0.9];
	labelTeamScore.layer.borderColor = [UIColor blackColor].CGColor;
	labelTeamScore.layer.borderWidth = 2.0;
	[self.view addSubview:labelTeamScore];
	
	//OPPONENT SCORE LABEL
	labelOpponentScore = [[UILabel alloc] initWithFrame:CGRectMake(80,425,70,30)];
	labelOpponentScore.text = @"0";
	labelOpponentScore.font = [UIFont fontWithName:@"Helvetica" size:25.0];
	[labelOpponentScore setTextAlignment:UITextAlignmentCenter];
	labelOpponentScore.textColor = [UIColor whiteColor];
	labelOpponentScore.backgroundColor = [UIColor colorWithRed:blue green:0.0 blue:red alpha:0.9];
	labelOpponentScore.layer.borderColor = [UIColor blackColor].CGColor;
	labelOpponentScore.layer.borderWidth = 2.0;
	[self.view addSubview:labelOpponentScore];
	
	
	//SFX PLAYERS
	NSString *explosionPath = [[NSBundle mainBundle] pathForResource:@"explosion" ofType:@"wav"];
	NSURL *explosionURL = [[NSURL alloc] initFileURLWithPath:explosionPath];
	sfxExplosionPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:explosionURL error:nil];
	[explosionPath release];
	[explosionURL release];
	[sfxExplosionPlayer prepareToPlay];
	
	NSString *splashPath = [[NSBundle mainBundle] pathForResource:@"splash" ofType:@"wav"];
	NSURL *splashURL = [[NSURL alloc] initFileURLWithPath:splashPath];
	sfxSplashPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:splashURL error:nil];
	[splashPath release];
	[splashURL release];
	[sfxSplashPlayer prepareToPlay];
	
}

/*
 METHODS
*/

- (void) gotoMenu {
	NSLog(@"Back to Main Menu");
	[self dismissModalViewControllerAnimated:YES];
}

- (void) gotoOpponentView {	
	NSLog(@"Lets see the opponent!");
	OpponentViewController *opponentView = [[OpponentViewController alloc] init];
	opponentView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	[self presentModalViewController:opponentView animated:YES];
	//[opponentView release];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	//check boat1 position	
	if((localGameData.team_boat1_x == 0) && (localGameData.team_boat1_y == 0)) {
		UITouch *touch = [[event allTouches] anyObject];
		CGPoint location = [touch locationInView:touch.view];
		NSLog(@"Touch Event at: %f, %f",location.x,location.y);		
		//check if its in playable area
		NSInteger y_cord = (int) ((location.y - 152) / 30)+1;
		NSInteger x_cord = (int) ((location.x - 13) / 30)+1;
		if((x_cord<=10)&&(x_cord>0)&&(y_cord>0)&&(y_cord<=10)) {
			team_boat1 = [[UILabel alloc] initWithFrame:CGRectMake((location.x)-14,(location.y)-14,28,27)];
			team_boat1.backgroundColor = [UIColor whiteColor];
			[self.view addSubview:team_boat1];
		}			
	}
	
	//check boat2 position	
	else if((localGameData.team_boat2_x == 0) && (localGameData.team_boat2_y == 0)) {		
		UITouch *touch = [[event allTouches] anyObject];
		CGPoint location = [touch locationInView:touch.view];
		NSLog(@"Touch Event at: %f, %f",location.x,location.y);		
		//check if its in playable area
		NSInteger y_cord = (int) ((location.y - 152) / 30)+1;
		NSInteger x_cord = (int) ((location.x - 13) / 30)+1;
		if((x_cord<=10)&&(x_cord>0)&&(y_cord>0)&&(y_cord<=10)) {
			team_boat2 = [[UILabel alloc] initWithFrame:CGRectMake((location.x)-14,(location.y)-14,28,27)];
			team_boat2.backgroundColor = [UIColor whiteColor];
			[self.view addSubview:team_boat2];
		}
		
	}
	
	//check boat3 position	
	else if((localGameData.team_boat3_x == 0) && (localGameData.team_boat3_y == 0) && (localGameData.difficulty>2)) {		
		UITouch *touch = [[event allTouches] anyObject];
		CGPoint location = [touch locationInView:touch.view];
		NSLog(@"Touch Event at: %f, %f",location.x,location.y);		
		//check if its in playable area
		NSInteger y_cord = (int) ((location.y - 152) / 30)+1;
		NSInteger x_cord = (int) ((location.x - 13) / 30)+1;
		if((x_cord<=10)&&(x_cord>0)&&(y_cord>0)&&(y_cord<=10)) {
			team_boat3 = [[UILabel alloc] initWithFrame:CGRectMake((location.x)-14,(location.y)-14,28,27)];
			team_boat3.backgroundColor = [UIColor whiteColor];
			[self.view addSubview:team_boat3];
		}
		
	}
	
	//check boat4 position	
	else if((localGameData.team_boat4_x == 0) && (localGameData.team_boat4_y == 0) && (localGameData.difficulty>3)) {		
		UITouch *touch = [[event allTouches] anyObject];
		CGPoint location = [touch locationInView:touch.view];
		NSLog(@"Touch Event at: %f, %f",location.x,location.y);		
		//check if its in playable area
		NSInteger y_cord = (int) ((location.y - 152) / 30)+1;
		NSInteger x_cord = (int) ((location.x - 13) / 30)+1;
		if((x_cord<=10)&&(x_cord>0)&&(y_cord>0)&&(y_cord<=10)) {
			team_boat4 = [[UILabel alloc] initWithFrame:CGRectMake((location.x)-14,(location.y)-14,28,27)];
			team_boat4.backgroundColor = [UIColor whiteColor];
			[self.view addSubview:team_boat4];
		}
		
	}
	
	//check boat5 position	
	else if((localGameData.team_boat5_x == 0) && (localGameData.team_boat5_y == 0) && (localGameData.difficulty>4)) {		
		UITouch *touch = [[event allTouches] anyObject];
		CGPoint location = [touch locationInView:touch.view];
		NSLog(@"Touch Event at: %f, %f",location.x,location.y);		
		//check if its in playable area
		NSInteger y_cord = (int) ((location.y - 152) / 30)+1;
		NSInteger x_cord = (int) ((location.x - 13) / 30)+1;
		if((x_cord<=10)&&(x_cord>0)&&(y_cord>0)&&(y_cord<=10)) {
			team_boat5 = [[UILabel alloc] initWithFrame:CGRectMake((location.x)-14,(location.y)-14,28,27)];
			team_boat5.backgroundColor = [UIColor whiteColor];
			[self.view addSubview:team_boat5];
		}
		
	}
	
	else {	
		//NOTHING TO PLACE		
	}
	
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	//MOVE BOAT 1
	if((localGameData.team_boat1_x == 0) && (localGameData.team_boat1_y == 0)) {		
		UITouch *touch = [[event allTouches] anyObject];
		CGPoint location = [touch locationInView:touch.view];
		//MOVE BOAT
		team_boat1.center = location;
	}
	
	//MOVE BOAT 2
	else if((localGameData.team_boat2_x == 0) && (localGameData.team_boat2_y == 0)) {		
		UITouch *touch = [[event allTouches] anyObject];
		CGPoint location = [touch locationInView:touch.view];
		//MOVE BOAT
		team_boat2.center = location;
	}
	
	//MOVE BOAT 3
	else if((localGameData.team_boat3_x == 0) && (localGameData.team_boat3_y == 0) && (localGameData.difficulty>2)) {		
		UITouch *touch = [[event allTouches] anyObject];
		CGPoint location = [touch locationInView:touch.view];
		//MOVE BOAT
		team_boat3.center = location;
	}
	
	//MOVE BOAT 4
	else if((localGameData.team_boat4_x == 0) && (localGameData.team_boat4_y == 0) && (localGameData.difficulty>3)) {		
		UITouch *touch = [[event allTouches] anyObject];
		CGPoint location = [touch locationInView:touch.view];
		//MOVE BOAT
		team_boat4.center = location;
	}
	
	//MOVE BOAT 5
	else if((localGameData.team_boat5_x == 0) && (localGameData.team_boat5_y == 0) && (localGameData.difficulty>4)) {		
		UITouch *touch = [[event allTouches] anyObject];
		CGPoint location = [touch locationInView:touch.view];
		//MOVE BOAT
		team_boat5.center = location;
	}	
	else {
		//NOTHING TO MOVE
	}

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	//DROP AND SET BOAT 1
	if((localGameData.team_boat1_x == 0) && (localGameData.team_boat1_y == 0)) {	
		CGPoint location = team_boat1.center;
		NSInteger y_cord = (int) ((location.y - 152) / 30)+1;
		NSInteger x_cord = (int) ((location.x - 13) / 30)+1;
		NSLog(@"Dropped boat 1 at: %i, %i",x_cord,y_cord);
		if((x_cord<=10)&&(x_cord>0)&&(y_cord>0)&&(y_cord<=9)) {
			team_boat1.center = CGPointMake((((x_cord-1)*30)+25),(((y_cord-1)*30)+165));
			localGameData.team_boat1_x = x_cord;
			localGameData.team_boat1_y = y_cord;
			NSLog(@"Set team_boat1 poisition to: %i, %i",localGameData.team_boat1_x,localGameData.team_boat1_y);			
			if(!localGameData.MP_flag) {
				//generate an enemy position
				localGameData.opponent_boat1_x = (arc4random() % 10) + 1;
				localGameData.opponent_boat1_y = (arc4random() % 9) + 1;
				NSLog(@"Random generated opponent_boat1 position: %i, %i",localGameData.opponent_boat1_x,localGameData.opponent_boat1_y);
			}
		}
		else
			[team_boat1 removeFromSuperview];
	}
	
	//DROP AND SET BOAT 2
	else if((localGameData.team_boat2_x == 0) && (localGameData.team_boat2_y == 0)) {	
		CGPoint location = team_boat2.center;
		NSInteger y_cord = (int) ((location.y - 152) / 30)+1;
		NSInteger x_cord = (int) ((location.x - 13) / 30)+1;
		NSLog(@"Dropped boat 2 at: %i, %i",x_cord,y_cord);
		if((x_cord<=10)&&(x_cord>0)&&(y_cord>0)&&(y_cord<=9)) {
			team_boat2.center = CGPointMake((((x_cord-1)*30)+25),(((y_cord-1)*30)+165));
			
			//TEST TO CHECK THAT IT'S NOT THE SAME AS BEFORE
			if( 1
				/*
				 (x_cord != localGameData.team_boat1_x) && 
				 (y_cord != localGameData.team_boat1_y)
				*/
			  ) {
			
				localGameData.team_boat2_x = x_cord;
				localGameData.team_boat2_y = y_cord;			
				NSLog(@"Set team_boat2 poisition to: %i, %i",localGameData.team_boat2_x,localGameData.team_boat2_y);
				if(!localGameData.MP_flag) {
					//generate an enemy position
					localGameData.opponent_boat2_x = (arc4random() % 10) + 1;
					localGameData.opponent_boat2_y = (arc4random() % 9) + 1;
					NSLog(@"Random generated opponent_boat2 position: %i, %i",localGameData.opponent_boat2_x,localGameData.opponent_boat2_y);
				}				
				if(localGameData.difficulty==2) {
					//LAST BOAT START GAME
					[self gotoOpponentView];	
				}				
			}
			else
				[team_boat2 removeFromSuperview];
		}
		else
			[team_boat2 removeFromSuperview];		
	}
	
	//DROP AND SET BOAT 3
	else if((localGameData.team_boat3_x == 0) && (localGameData.team_boat3_y == 0) && (localGameData.difficulty>2)) {	
		CGPoint location = team_boat3.center;
		NSInteger y_cord = (int) ((location.y - 152) / 30)+1;
		NSInteger x_cord = (int) ((location.x - 13) / 30)+1;
		NSLog(@"Dropped boat 3 at: %i, %i",x_cord,y_cord);
		if((x_cord<=10)&&(x_cord>0)&&(y_cord>0)&&(y_cord<=9)) {
			team_boat3.center = CGPointMake((((x_cord-1)*30)+25),(((y_cord-1)*30)+165));
			localGameData.team_boat3_x = x_cord;
			localGameData.team_boat3_y = y_cord;
			NSLog(@"Set team_boat3 poisition to: %i, %i",localGameData.team_boat3_x,localGameData.team_boat3_y);
			if(!localGameData.MP_flag) {
				//generate an enemy position
				localGameData.opponent_boat3_x = (arc4random() % 10) + 1;
				localGameData.opponent_boat3_y = (arc4random() % 9) + 1;
				NSLog(@"Random generated opponent_boat3 position: %i, %i",localGameData.opponent_boat3_x,localGameData.opponent_boat3_y);
			}
			if(localGameData.difficulty==3) {
				//LAST BOAT START GAME
				[self gotoOpponentView];	
			}	
		}
		else
			[team_boat3 removeFromSuperview];
	}
	
	//DROP AND SET BOAT 4
	else if((localGameData.team_boat4_x == 0) && (localGameData.team_boat4_y == 0) && (localGameData.difficulty>3)) {	
		CGPoint location = team_boat4.center;
		NSInteger y_cord = (int) ((location.y - 152) / 30)+1;
		NSInteger x_cord = (int) ((location.x - 13) / 30)+1;
		NSLog(@"Dropped boat 4 at: %i, %i",x_cord,y_cord);
		if((x_cord<=10)&&(x_cord>0)&&(y_cord>0)&&(y_cord<=9)) {
			team_boat4.center = CGPointMake((((x_cord-1)*30)+25),(((y_cord-1)*30)+165));
			localGameData.team_boat4_x = x_cord;
			localGameData.team_boat4_y = y_cord;
			NSLog(@"Set team_boat4 poisition to: %i, %i",localGameData.team_boat4_x,localGameData.team_boat4_y);
			if(!localGameData.MP_flag) {
				//generate an enemy position
				localGameData.opponent_boat4_x = (arc4random() % 10) + 1;
				localGameData.opponent_boat4_y = (arc4random() % 9) + 1;
				NSLog(@"Random generated opponent_boat4 position: %i, %i",localGameData.opponent_boat4_x,localGameData.opponent_boat4_y);
			}
			else {
			
				NSString *urlString = @"http://api.dylanjones.info/battleboats/myboats?gid=";
				urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%d",localGameData.MP_gid]];
				urlString = [urlString stringByAppendingString:@"&uid="];
				urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%d",localGameData.MP_uid]];
				urlString = [urlString stringByAppendingString:@"&boats="];				
				int position = ((localGameData.team_boat1_y*10)-10)+localGameData.team_boat1_x;
				urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%d",position]];
				urlString = [urlString stringByAppendingString:@","];		
				position = ((localGameData.team_boat2_y*10)-10)+localGameData.team_boat2_x;
				urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%d",position]];
				urlString = [urlString stringByAppendingString:@","];
				position = ((localGameData.team_boat3_y*10)-10)+localGameData.team_boat3_x;
				urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%d",position]];
				urlString = [urlString stringByAppendingString:@","];
				position = ((localGameData.team_boat4_y*10)-10)+localGameData.team_boat4_x;
				urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%d",position]];
				
				NSLog(@"HTTP REQUEST: %@",urlString);
				NSError *error;
				NSString *responseString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:&error];
				
				if(responseString)
					NSLog(@"HTTP RESPONSE: %@",responseString);
				else
					NSLog(@"Error: %@",error);
				
				//WAITING FOR OPPONENT PLACEHOLDER
				labelWaiting = [[UILabel alloc] initWithFrame:CGRectMake(0,0,200,120)];
				labelWaiting.center = CGPointMake(320/2, 480/2);
				labelWaiting.numberOfLines = 0;
				labelWaiting.text = @"Waiting\n for\n Opponent";
				labelWaiting.font = [UIFont fontWithName:@"Helvetica" size:25.0];
				[labelWaiting setTextAlignment:UITextAlignmentCenter];
				labelWaiting.textColor = [UIColor whiteColor];
				labelWaiting.backgroundColor = [UIColor blackColor];
				[self.view addSubview:labelWaiting];					
				[self performSelector:@selector(opponentReady) withObject:nil];
			
			}
			if(localGameData.difficulty==4) {
				//LAST BOAT START GAME
				[self gotoOpponentView];		
			}
		}
		else
			[team_boat4 removeFromSuperview];		
	}
	
	//DROP AND SET BOAT 5
	else if((localGameData.team_boat5_x == 0) && (localGameData.team_boat5_y == 0) && (localGameData.difficulty>4)) {	
		CGPoint location = team_boat5.center;
		NSInteger y_cord = (int) ((location.y - 152) / 30)+1;
		NSInteger x_cord = (int) ((location.x - 13) / 30)+1;
		NSLog(@"Dropped boat 5 at: %i, %i",x_cord,y_cord);
		if((x_cord<=10)&&(x_cord>0)&&(y_cord>0)&&(y_cord<=9)) {
			team_boat5.center = CGPointMake((((x_cord-1)*30)+25),(((y_cord-1)*30)+165));
			localGameData.team_boat5_x = x_cord;
			localGameData.team_boat5_y = y_cord;
			NSLog(@"Set team_boat5 poisition to: %i, %i",localGameData.team_boat5_x,localGameData.team_boat5_y);
			if(!localGameData.MP_flag) {
				//generate an enemy position
				localGameData.opponent_boat5_x = (arc4random() % 10) + 1;
				localGameData.opponent_boat5_y = (arc4random() % 9) + 1;
				NSLog(@"Random generated opponent_boat5 position: %i, %i",localGameData.opponent_boat5_x,localGameData.opponent_boat5_y);
			}
			if(localGameData.difficulty==5) {
				//LAST BOAT START GAME
				[self gotoOpponentView];	
			}
		}
		else
			[team_boat5 removeFromSuperview];
	}
	
	else {
		//NOTHING TO DROP
	}
	
}

- (void) viewDidAppear:(BOOL)animated {
		
	//ONLY DO THIS ONCE IN GAMEPLAY
	if(localGameData.turnNumber>0) {
	
		//DRAW EXPLOSIONS AND SPLASHES
		int count = [localGameData.opponentMoves count];
		for(int a=0; a<count; a++) {
			int i = a;
			int x_cord;
			int y_cord;
			if(i<=10) {
				x_cord = i;
				y_cord = 1;
			}
			else if(i<=20) {
				x_cord = i-10;
				y_cord = 2;
			}
			else if(i<=30) {
				x_cord = i-20;
				y_cord = 3;
			}
			else if(i<=40) {
				x_cord = i-30;
				y_cord = 4;
			}
			else if(i<=50) {
				x_cord = i-40;
				y_cord = 5;
			}
			else if(i<=60) {
				x_cord = i-50;
				y_cord = 6;
			}
			else if(i<=70) {
				x_cord = i-60;
				y_cord = 7;
			}
			else if(i<=80) {
				x_cord = i-70;
				y_cord = 8;
			}
			else if(i<=90) {
				x_cord = i-80;
				y_cord = 9;
			}
			else{
				NSLog(@"The maths has gone wrong %i",i);
			}
			int squareStatus = [[localGameData.opponentMoves objectAtIndex:a] intValue];
			if(squareStatus==1) {
			
				//DRAW EXPLOSION
				UIColor *explosionImage = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"explosion.png"]];
				explosion = [[UILabel alloc] initWithFrame:CGRectMake((((x_cord-1)*30)+12),(((y_cord-1)*30)+152),28,27)];
				explosion.backgroundColor = explosionImage;
				[self.view addSubview:explosion];
				[explosionImage release];
			
			}
			else if(squareStatus==2) {
			
				//DRAW SPLASH
				//UIColor *splashImage = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"splash.png"]];
				UIColor *splashImage = [UIColor blackColor];
				splash = [[UILabel alloc] initWithFrame:CGRectMake((((x_cord-1)*30)+12),(((y_cord-1)*30)+152),28,27)];
				splash.backgroundColor = splashImage;
				[self.view addSubview:splash];
				[splashImage release];
			
			}
			else {
				//DO NOTHING;
			}
			
		}
	
		//IF SCORE HAS CHANGED PLAY EXPLOSION ELSE PLAY SPLASH AS LONG AS WE HAVE ALREADY HAD A TURN
		int stringTest =  [labelOpponentScore.text intValue];
		if((stringTest<localGameData.opponentScore) && (localGameData.turnNumber>0)) {
			//PLAY EXPLOSION
			[sfxExplosionPlayer play];
		}
		else if(localGameData.turnNumber>0) {
			//PLAY SPLASH
			[sfxSplashPlayer play];
		}
	
		//UPDATE SCORE CARD
		labelTeamScore.text = [NSString stringWithFormat:@"%d",localGameData.teamScore];
		labelOpponentScore.text = [NSString stringWithFormat:@"%d",localGameData.opponentScore];
	
		//DO WE NEED TO END THE GAME?
		
		///////FOR TESTING PURPOSES//////
		/**/	bool test = false;	 /**/
		/////////////////////////////////
		
		if((localGameData.teamNumberOfBoatsSunk == localGameData.difficulty) || (localGameData.opponentNumberOfBoatsSunk == localGameData.difficulty) ||  (test)) {

			NSString *alertTitle;
			NSString *alertMessage; 
			if(localGameData.teamScore > localGameData.opponentScore) {
				alertTitle = @"Congratulations";
				alertMessage = @"You Won! Would you like to submit your score to the High Scores table?\n\n\n";
			}
			else {
				alertTitle = @"Game Over";
				alertMessage = @"You Lost! Would you like to submit your score to the High Scores table anyway?\n\n\n";
			}
			
			alertHighScore = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage  delegate:self cancelButtonTitle:@"No Thanks" otherButtonTitles: @"Submit", nil];
			
			nicknameField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 110.0, 260.0, 25.0)];
			nicknameField.placeholder = @"Nickname";
			[nicknameField setBackgroundColor:[UIColor whiteColor]];
			[alertHighScore addSubview:nicknameField];
			
			[alertHighScore show];
			[alertHighScore release];
			[alertMessage release];
			[alertTitle release];
			
		}
		else {
			[self performSelector:@selector(gotoOpponentView) withObject:nil afterDelay:0.7];
			NSLog(@"Scores: %i, %i",localGameData.teamScore,localGameData.opponentScore);
		}
	
	}

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if(buttonIndex==0) {
		[self dismissModalViewControllerAnimated:YES];
	}
	else {
		userLocationManager = [[CLLocationManager alloc] init];
		userLocationManager.delegate = self;
		userLocationManager.distanceFilter = 2000;
		[userLocationManager startUpdatingLocation];
	}
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation 
		   fromLocation:(CLLocation *)oldLocation {
	[userLocationManager stopUpdatingLocation];
	userLocation = newLocation;
	NSString *urlString = @"http://api.dylanjones.info/battleboats/highscore/?nickname=";
	urlString = [urlString stringByAppendingString:nicknameField.text];
	urlString = [urlString stringByAppendingString:@"&score="];
	urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%d",localGameData.teamScore]];
	urlString = [urlString stringByAppendingString:@"&latitude="];
	urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%f",userLocation.coordinate.latitude]];
	urlString = [urlString stringByAppendingString:@"&longitude="];
	urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%f",userLocation.coordinate.longitude]];

	NSLog(@"HTTP REQUEST: %@",urlString);
	NSError *error;
	NSString *responseString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:&error];
	if(responseString)
		NSLog(@"Response: %@",responseString);
	else
		NSLog(@"Error: %@",error);
	//[responseString release];
	//[error release];
	[self dismissModalViewControllerAnimated:YES];

}


- (void) opponentReady {	
	
	if(localGameData.opponent_boat1_x!=0) {
		//stop calling yourself
	}
	else {
		
		[self performSelector:@selector(opponentReady) withObject:nil afterDelay:12];
		
		NSLog(@"Checking if opponent is ready");
		
		//check for opponent boats
		NSString *urlString = @"http://api.dylanjones.info/battleboats/ready?gid=";
		urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%d",localGameData.MP_gid]];
		urlString = [urlString stringByAppendingString:@"&uid="];
		urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%d",localGameData.MP_uid]];
		
		NSLog(@"HTTP REQUEST: %@",urlString);
		NSError *error;
		NSString *responseString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:&error];
		
		if(responseString) {
			NSLog(@"HTTP RESPONSE: %@",responseString);
			
			if(responseString.length>5) {
				
				//GET BOATS AND STORE IN GLOBAL DATA
				NSArray *opponentBoats = [responseString componentsSeparatedByString:@","];
				
				//BOAT 1
				int i = [[opponentBoats objectAtIndex:0] intValue];
				if(i<=10) {
					localGameData.opponent_boat1_x = i;
					localGameData.opponent_boat1_y = 1;
				}
				else if(i<=20) {
					localGameData.opponent_boat1_x = i-10;
					localGameData.opponent_boat1_y = 2;
				}
				else if(i<=30) {
					localGameData.opponent_boat1_x = i-20;
					localGameData.opponent_boat1_y = 3;
				}
				else if(i<=40) {
					localGameData.opponent_boat1_x = i-30;
					localGameData.opponent_boat1_y = 4;
				}
				else if(i<=50) {
					localGameData.opponent_boat1_x = i-40;
					localGameData.opponent_boat1_y = 5;
				}
				else if(i<=60) {
					localGameData.opponent_boat1_x = i-50;
					localGameData.opponent_boat1_y = 6;
				}
				else if(i<=70) {
					localGameData.opponent_boat1_x = i-60;
					localGameData.opponent_boat1_y = 7;
				}
				else if(i<=80) {
					localGameData.opponent_boat1_x = i-70;
					localGameData.opponent_boat1_y = 8;
				}
				else if(i<=90) {
					localGameData.opponent_boat1_x = i-80;
					localGameData.opponent_boat1_y = 9;
				}
				else{
					NSLog(@"The maths has gone wrong %i",i);
				}
				
				//BOAT 2
				i = [[opponentBoats objectAtIndex:1] intValue];
				if(i<=10) {
					localGameData.opponent_boat2_x = i;
					localGameData.opponent_boat2_y = 1;
				}
				else if(i<=20) {
					localGameData.opponent_boat2_x = i-10;
					localGameData.opponent_boat2_y = 2;
				}
				else if(i<=30) {
					localGameData.opponent_boat2_x = i-20;
					localGameData.opponent_boat2_y = 3;
				}
				else if(i<=40) {
					localGameData.opponent_boat2_x = i-30;
					localGameData.opponent_boat2_y = 4;
				}
				else if(i<=50) {
					localGameData.opponent_boat2_x = i-40;
					localGameData.opponent_boat2_y = 5;
				}
				else if(i<=60) {
					localGameData.opponent_boat2_x = i-50;
					localGameData.opponent_boat2_y = 6;
				}
				else if(i<=70) {
					localGameData.opponent_boat2_x = i-60;
					localGameData.opponent_boat2_y = 7;
				}
				else if(i<=80) {
					localGameData.opponent_boat2_x = i-70;
					localGameData.opponent_boat2_y = 8;
				}
				else if(i<=90) {
					localGameData.opponent_boat2_x = i-80;
					localGameData.opponent_boat2_y = 9;
				}
				else{
					NSLog(@"The maths has gone wrong %i",i);
				}
				
				//BOAT 3
				i = [[opponentBoats objectAtIndex:2] intValue];
				if(i<=10) {
					localGameData.opponent_boat3_x = i;
					localGameData.opponent_boat3_y = 1;
				}
				else if(i<=20) {
					localGameData.opponent_boat3_x = i-10;
					localGameData.opponent_boat3_y = 2;
				}
				else if(i<=30) {
					localGameData.opponent_boat3_x = i-20;
					localGameData.opponent_boat3_y = 3;
				}
				else if(i<=40) {
					localGameData.opponent_boat3_x = i-30;
					localGameData.opponent_boat3_y = 4;
				}
				else if(i<=50) {
					localGameData.opponent_boat3_x = i-40;
					localGameData.opponent_boat3_y = 5;
				}
				else if(i<=60) {
					localGameData.opponent_boat3_x = i-50;
					localGameData.opponent_boat3_y = 6;
				}
				else if(i<=70) {
					localGameData.opponent_boat3_x = i-60;
					localGameData.opponent_boat3_y = 7;
				}
				else if(i<=80) {
					localGameData.opponent_boat3_x = i-70;
					localGameData.opponent_boat3_y = 8;
				}
				else if(i<=90) {
					localGameData.opponent_boat3_x = i-80;
					localGameData.opponent_boat3_y = 9;
				}
				else{
					NSLog(@"The maths has gone wrong %i",i);
				}
				
				//BOAT 4
				i = [[opponentBoats objectAtIndex:3] intValue];
				if(i<=10) {
					localGameData.opponent_boat4_x = i;
					localGameData.opponent_boat4_y = 1;
				}
				else if(i<=20) {
					localGameData.opponent_boat4_x = i-10;
					localGameData.opponent_boat4_y = 2;
				}
				else if(i<=30) {
					localGameData.opponent_boat4_x = i-20;
					localGameData.opponent_boat4_y = 3;
				}
				else if(i<=40) {
					localGameData.opponent_boat4_x = i-30;
					localGameData.opponent_boat4_y = 4;
				}
				else if(i<=50) {
					localGameData.opponent_boat4_x = i-40;
					localGameData.opponent_boat4_y = 5;
				}
				else if(i<=60) {
					localGameData.opponent_boat4_x = i-50;
					localGameData.opponent_boat4_y = 6;
				}
				else if(i<=70) {
					localGameData.opponent_boat4_x = i-60;
					localGameData.opponent_boat4_y = 7;
				}
				else if(i<=80) {
					localGameData.opponent_boat4_x = i-70;
					localGameData.opponent_boat4_y = 8;
				}
				else if(i<=90) {
					localGameData.opponent_boat4_x = i-80;
					localGameData.opponent_boat4_y = 9;
				}
				else{
					NSLog(@"The maths has gone wrong %i",i);
				}
				
				//GET RID OF WAITING PLACEHOLDER AND GOTO OPPONENT VIEW
				[labelWaiting removeFromSuperview];
				[labelWaiting release];
				[self gotoOpponentView];
				
			}
			
		}
		else
			NSLog(@"Error: %@",error);
	}
}

////////////////////

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
	return YES;
	
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;

	nicknameField = nil;
	userLocationManager = nil;
}


- (void)dealloc {
    [super dealloc];
	
	[nicknameField release];
	[userLocationManager release];
	
	[team_boat1	release];
	[team_boat2	release];
	[team_boat3	release];
	[team_boat4	release];
	[team_boat5	release];
}


@end
	
