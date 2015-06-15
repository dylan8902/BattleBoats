//
//  OpponentView.m
//  BattleBoats
//
//  Created by Dylan Jones on 19/10/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "OpponentView.h"
#import "BattleBoatsAppDelegate.h"
#import "Game.h"

@implementation OpponentViewController

@synthesize buttonMenu;
@synthesize explosion;
@synthesize labelTeamScore;
@synthesize labelOpponentScore;
@synthesize labelWaiting;
@synthesize splash;
@synthesize sfxExplosionPlayer;
@synthesize sfxSplashPlayer;
@synthesize localGameData;

- (void)viewDidLoad {
	
	//INITALISE GLOBAL DATA AND STORE AS LOCAL
	BattleBoatsAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	localGameData = [appDelegate gameData];
	
	//INITIALISE BACKGROUND IMAGE
	NSString *background = @"blue.png";	
	if(localGameData.teamColor==0) {
		background = @"red.png";
	}
	UIColor *backgroundImage = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:background]];
	self.view.backgroundColor = backgroundImage;
	[background release];
	[backgroundImage release];
	
	//BUTTON TO GO BACK
	buttonMenu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	buttonMenu.frame = CGRectMake(0, 0, 60, 30);
	buttonMenu.center = CGPointMake(280, 440);
	[buttonMenu setTitle:@"Back" forState:UIControlStateNormal];
	[buttonMenu addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
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
	labelTeamScore.text = [NSString stringWithFormat:@"%d",localGameData.teamScore];
	labelTeamScore.font = [UIFont fontWithName:@"Helvetica" size:25.0];
	[labelTeamScore setTextAlignment:UITextAlignmentCenter];
	labelTeamScore.textColor = [UIColor whiteColor];
	labelTeamScore.backgroundColor = [UIColor colorWithRed:red green:0.0 blue:blue alpha:0.9];
	labelTeamScore.layer.borderColor = [UIColor blackColor].CGColor;
	labelTeamScore.layer.borderWidth = 2.0;
	[self.view addSubview:labelTeamScore];
	
	//OPPONENT SCORE LABEL
	labelOpponentScore = [[UILabel alloc] initWithFrame:CGRectMake(80,425,70,30)];
	labelOpponentScore.text = [NSString stringWithFormat:@"%d",localGameData.opponentScore];
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
	
	//INCREMENT TURN NUMBER
	localGameData.turnNumber++;
	
	//DRAW EXPLOSIONS AND SPLASHES
	int count = [localGameData.teamMoves count];
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
		int squareStatus = [[localGameData.teamMoves objectAtIndex:a] intValue];
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
	
}

///METHODS///

- (void) goBack {
	NSLog(@"Go back a view");
	[self dismissModalViewControllerAnimated:YES];
}

- (void) opponentReady {
	//REPEAT REQUEST UNTIL OPPONENT MOVE HAS OCCURED
	
	NSString *urlString = @"http://api.dylanjones.info/battleboats/turn?gid=";
	urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%d",localGameData.MP_gid]];
	urlString = [urlString stringByAppendingString:@"&uid="];
	urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%d",localGameData.MP_uid]];
	
	NSLog(@"HTTP REQUEST: %@",urlString);
	NSError *error;
	NSString *responseString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:&error];
	
	if(responseString) {
		NSLog(@"HTTP RESPONSE: %@",responseString);
		
		if((responseString.length == 1) && ([responseString intValue] == 0)) {
			//KEEP WAITING AND CHECKING
			[self performSelector:@selector(opponentReady) withObject:nil afterDelay:5];
		}
		else {
			//SPLIT MOVE AND RESULT
			NSArray *response = [responseString componentsSeparatedByString:@","];
			
			if([response objectAtIndex:0] == @"HIT") {						
				//ADD POINTS
				localGameData.opponentScore = localGameData.opponentScore + ((90 - localGameData.turnNumber) * 10);				
				//INCREMENT BOAT SINK COUNT
				localGameData.teamNumberOfBoatsSunk++;				
				//RECORD MOVE IN GLOBAL GAME DATA
				[localGameData.opponentMoves replaceObjectAtIndex:[[response objectAtIndex:1] intValue] withObject:[NSNumber numberWithInt:1]];
			}
			else {
				//RECORD MOVE IN GLOBAL GAME DATA
				[localGameData.opponentMoves replaceObjectAtIndex:[[response objectAtIndex:1] intValue] withObject:[NSNumber numberWithInt:2]];
			}
			
			//[response release];
			[self performSelector:@selector(goBack) withObject:nil afterDelay:0.5];
		}
	}
	else
		NSLog(@"Error: %@",error);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    NSLog(@"Touch Event at: %f, %f",location.x,location.y);
	NSInteger y_cord = (int) ((location.y - 152) / 30) +1;
	NSInteger x_cord = (int) ((location.x - 13) / 30) +1;
	NSLog(@"X-axis square: %i",x_cord);
    NSLog(@"Y-axis square: %i",y_cord);
	if((x_cord<=10)&&(x_cord>0)&&(y_cord>0)&&(y_cord<=9)) {
		NSLog(@"we are within the playable area, check if it has aleady been done, save the hit, play and draw something");
		
		//ONLY PROGRESS IF THIS MOVE HAS NOT BEEN DONE BEFORE
		int here = ((y_cord*10)-10)+x_cord;
		if([[localGameData.teamMoves objectAtIndex:here] intValue]==0) {
				
			if(
			   ((x_cord==localGameData.opponent_boat1_x)&&(y_cord==localGameData.opponent_boat1_y)) || 
			   ((x_cord==localGameData.opponent_boat2_x)&&(y_cord==localGameData.opponent_boat2_y)) ||
			   ((x_cord==localGameData.opponent_boat3_x)&&(y_cord==localGameData.opponent_boat3_y)) || 
			   ((x_cord==localGameData.opponent_boat4_x)&&(y_cord==localGameData.opponent_boat4_y)) ||
			   ((x_cord==localGameData.opponent_boat5_x)&&(y_cord==localGameData.opponent_boat5_y))
			   ) {
				
				NSLog(@"BANG! Draw and play explosion");
				
				//DRAW EXPLOSION
				UIColor *explosionImage = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"explosion.png"]];
				explosion = [[UILabel alloc] initWithFrame:CGRectMake((((x_cord-1)*30)+12),(((y_cord-1)*30)+152),28,27)];
				explosion.backgroundColor = explosionImage;
				[self.view addSubview:explosion];
				[explosionImage release];
				
				//PLAY EXPLOSION
				[sfxExplosionPlayer play];
				
				//ADD POINTS
				localGameData.teamScore = localGameData.teamScore + ((90 - localGameData.turnNumber) * 10);				
				//RECORD MOVE IN GLOBAL GAME DATA				
				[localGameData.teamMoves replaceObjectAtIndex:here withObject:[NSNumber numberWithInt:1]];				
				//INCREMENT BOAT SINK COUNT
				localGameData.opponentNumberOfBoatsSunk++;		
				
			}
			
			else {
				
				NSLog(@"SPLASH! Draw and play splash");
				
				//DRAW SPLASH
				//UIColor *splashImage = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"splash.png"]];
				UIColor *splashImage = [UIColor blackColor];
				splash = [[UILabel alloc] initWithFrame:CGRectMake((((x_cord-1)*30)+12),(((y_cord-1)*30)+152),28,27)];
				splash.backgroundColor = splashImage;
				[self.view addSubview:splash];
				[splashImage release];
				
				//PLAY SPLASH
				[sfxSplashPlayer play];
				
				//RECORD MOVE IN GLOBAL GAME DATA
				[localGameData.teamMoves replaceObjectAtIndex:here withObject:[NSNumber numberWithInt:2]];
				
			}
			
			if(localGameData.MP_flag) {
				//SEND MOVE TO SERVER - ADD WAITING PLACEHOLDER
				
				NSString *urlString = @"http://api.dylanjones.info/battleboats/move?gid=";
				urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%d",localGameData.MP_gid]];
				urlString = [urlString stringByAppendingString:@"&uid="];
				urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%d",localGameData.MP_uid]];
				urlString = [urlString stringByAppendingString:@"&move="];				
				urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%d",here]];
				
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
			
			else {
			
				//AI TURN
				int here = 0;
				int squareStatus = 0;		
				do{			
					x_cord = (arc4random() % 10) + 1;
					y_cord = (arc4random() % 9) + 1;
					here = ((y_cord*10)-10)+x_cord;
					squareStatus = [[localGameData.opponentMoves objectAtIndex:here] intValue];
					
				} while(squareStatus!=0);
				
				
				if(
				   ((x_cord==localGameData.team_boat1_x)&&(y_cord==localGameData.team_boat1_y)) || 
				   ((x_cord==localGameData.team_boat2_x)&&(y_cord==localGameData.team_boat2_y)) ||
				   ((x_cord==localGameData.team_boat3_x)&&(y_cord==localGameData.team_boat3_y)) || 
				   ((x_cord==localGameData.team_boat4_x)&&(y_cord==localGameData.team_boat4_y)) ||
				   ((x_cord==localGameData.team_boat5_x)&&(y_cord==localGameData.team_boat5_y))
				   ) {
					
					//ADD POINTS
					localGameData.opponentScore = localGameData.opponentScore + ((90 - localGameData.turnNumber) * 10);					
					//RECORD MOVE IN GLOBAL GAME DATA
					[localGameData.opponentMoves replaceObjectAtIndex:here withObject:[NSNumber numberWithInt:1]];					
					//INCREMENT BOAT SINK COUNT
					localGameData.teamNumberOfBoatsSunk++;	
					
				}
				
				else {					
					//RECORD MOVE IN GLOBAL GAME DATA
					[localGameData.opponentMoves replaceObjectAtIndex:here withObject:[NSNumber numberWithInt:2]];
				}
				
				//GO BACK A VIEW
				[self performSelector:@selector(goBack) withObject:nil afterDelay:0.5];
			}
			
		}
		else {
			//THIS MOVE HAS BEEN DONE BEFORE, DO NOTHING.
		}
	
	}
	else {
		//TOUCH NOT IN PLAYABLE AREA, DO NOTHING.
	}
	
}

///////////////////////	

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
	self.explosion = nil;
	self.splash = nil;
	self.labelTeamScore = nil;
	self.labelOpponentScore = nil;
}


- (void)dealloc {
    [super dealloc];
	[explosion release];
	[splash release];
	[labelTeamScore release];
	[labelOpponentScore release];
}


@end
