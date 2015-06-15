//
//  MultiplayerSetupView.m
//  BattleBoats
//
//  Created by Dylan Jones on 19/11/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MultiplayerSetupView.h"
#import "YourView.h"
#import "Game.h"

@implementation MultiplayerSetupView

@synthesize buttonMenu;
@synthesize buttonJoin;
@synthesize labelUid;
@synthesize localGameData;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	//INITALISE GLOBAL DATA AND STORE AS LOCAL
	BattleBoatsAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	localGameData = [appDelegate gameData];
	
	//INITIALISE BACKGROUND IMAGE
	UIColor *backgroundImage = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"menu.png"]];
	self.view.backgroundColor = backgroundImage;
	[backgroundImage release];
	
	//INITIALISE MENU BUTTON
	buttonMenu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	buttonMenu.frame = CGRectMake(0, 0, 60, 30);
	buttonMenu.center = CGPointMake(285, 440);
	[buttonMenu setTitle:@"Menu" forState:UIControlStateNormal];
	[buttonMenu addTarget:self action:@selector(gotoMenu) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:buttonMenu];
	
	//GENERATE UID AND DISPLAY
	localGameData.MP_uid = [[NSDate date] timeIntervalSince1970];
	labelUid = [[UILabel alloc] initWithFrame:(CGRectMake(0,0,180,30))];
	labelUid.center = CGPointMake(160,190);
	labelUid.text = [@" Your ID: " stringByAppendingString:[NSString stringWithFormat:@"%d",localGameData.MP_uid]];
	[self.view addSubview:labelUid];
	
	//SEND UID, RECIEVE LIST OF POSSIBLE USERS	
	NSString *urlString = @"http://api.dylanjones.info/battleboats/users?uid=";
	urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%d",localGameData.MP_uid]];	
	NSLog(@"HTTP REQUEST: %@",urlString);
	NSError *error;
	NSString *responseString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:&error];
	
	if(responseString) {
		NSLog(@"Response: %@",responseString);
		NSArray *users = [responseString componentsSeparatedByString:@";"];
		
		//INITIALISE BUTTON FOR EACH USER ID
		for( int a=0; a<[users count]-1; a++) {

				buttonJoin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
				buttonJoin.frame = CGRectMake(0, 0, 110, 30);
				buttonJoin.center = CGPointMake(160, (a*40)+240);
				[buttonJoin setTitle:[users objectAtIndex:a] forState:UIControlStateNormal];
				[buttonJoin addTarget:self action:@selector(joinGame:) forControlEvents:UIControlEventTouchUpInside];
				buttonJoin.tag = [[users objectAtIndex:a] intValue];
				[self.view addSubview:buttonJoin];
			
		}
	
	}
	else
		NSLog(@"Error: %@",error);
	
	//CHECK FOR OPPONENT AFTER 12 SECONDS
	[self performSelector:@selector(checkOpponent) withObject:nil afterDelay:12];
	
	
}

- (void) gotoMenu {
	NSLog(@"Back to Main Menu");
	[self dismissModalViewControllerAnimated:YES];
}

- (void) checkOpponent {
	
	//ONLY IF GAME HAS NOT STARTED
	if(localGameData.MP_gid==0) {
	
		//CHECK FOR GAMES WITH ME IN
		NSString *urlString = @"http://api.dylanjones.info/battleboats/opponentcheck?uid=";
		urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%d",localGameData.MP_uid]];	
		NSLog(@"HTTP REQUEST: %@",urlString);
		NSError *error;
		NSString *responseString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:&error];
		
		if(responseString) {
			NSLog(@"Response: %@",responseString);		
			localGameData.MP_gid = [responseString intValue];
			
			if(localGameData.MP_gid!=0) {
				//SOMEONE WANTS TO PLAY ME
				
				//ALERT GAME WITH CONTINUE
				UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Multiplayer" message:@"Someone would like to play you!" delegate:self cancelButtonTitle:@"Bring It On!" otherButtonTitles:nil];
				[alertView show];
				[alertView release];
				
				//GO TO YOUR VIEW
				YourViewController *yourView = [[YourViewController alloc] init];
				yourView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
				[self presentModalViewController:yourView animated:YES];
				[yourView release];
				
			}
		}
		else
			NSLog(@"Error: %@",error);
		
		if(localGameData.MP_gid==0)
			[self performSelector:@selector(checkOpponent) withObject:nil afterDelay:12];
	}
		
}

- (void) joinGame:(id)sender {
    localGameData.MP_opponent = ((UIControl *) sender).tag;
	
	//SEND START GAME
	NSString *urlString = @"http://api.dylanjones.info/battleboats/startgame?uid=";
	urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%d",localGameData.MP_uid]];
	urlString = [urlString stringByAppendingString:@"&opponent="];
	urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%d",localGameData.MP_opponent]];
				 
	NSLog(@"HTTP REQUEST: %@",urlString);
	NSError *error;
	NSString *responseString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:&error];
	
	if(responseString) {
		
		localGameData.MP_gid = [responseString intValue];
		
		NSLog(@"uid: %d opponent: %d gid: %d",localGameData.MP_uid,localGameData.MP_opponent,localGameData.MP_gid);
		
		//LOAD YOUR VIEW TO POSITION BOATS
		YourViewController *yourView = [[YourViewController alloc] init];
		yourView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
		[self presentModalViewController:yourView animated:YES];
		[yourView release];
		
	}
	else
		NSLog(@"Error: %@",error);
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
	
	buttonMenu = nil;
	labelUid = nil;

}


- (void)dealloc {
    [super dealloc];
	
	[labelUid release];

}


@end
