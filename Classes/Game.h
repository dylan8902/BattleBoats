//
//  Game.h
//  BattleBoats
//
//  Created by Dylan Jones on 02/11/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Game : NSObject {

	NSInteger teamColor;
	NSInteger difficulty;
	NSInteger turnNumber;
	NSInteger teamScore;
	NSInteger opponentScore;
	NSInteger teamNumberOfBoatsSunk;
	NSInteger opponentNumberOfBoatsSunk;
	
	NSMutableArray *teamMoves;
	NSMutableArray *opponentMoves;
	
	NSInteger MP_flag;
	long MP_uid;
	long MP_opponent;
	int MP_gid;

	NSInteger team_boat1_x;
	NSInteger team_boat1_y;

	NSInteger team_boat2_x;
	NSInteger team_boat2_y;

	NSInteger team_boat3_x;
	NSInteger team_boat3_y;

	NSInteger team_boat4_x;
	NSInteger team_boat4_y;
	
	NSInteger team_boat5_x;
	NSInteger team_boat5_y;
	
	NSInteger opponent_boat1_x;
	NSInteger opponent_boat1_y;
	
	NSInteger opponent_boat2_x;
	NSInteger opponent_boat2_y;
	
	NSInteger opponent_boat3_x;
	NSInteger opponent_boat3_y;
	
	NSInteger opponent_boat4_x;
	NSInteger opponent_boat4_y;
	
	NSInteger opponent_boat5_x;
	NSInteger opponent_boat5_y;

	
}

@property (nonatomic) NSInteger teamColor;
@property (nonatomic) NSInteger difficulty;
@property (nonatomic) NSInteger turnNumber;
@property (nonatomic) NSInteger teamScore;
@property (nonatomic) NSInteger opponentScore;
@property (nonatomic) NSInteger teamNumberOfBoatsSunk;
@property (nonatomic) NSInteger opponentNumberOfBoatsSunk;

@property (nonatomic,retain) NSMutableArray *teamMoves;
@property (nonatomic,retain) NSMutableArray *opponentMoves;

@property (nonatomic) NSInteger MP_flag;
@property (nonatomic) long MP_uid;
@property (nonatomic) long MP_opponent;
@property (nonatomic) int MP_gid;

@property (nonatomic) NSInteger team_boat1_x;
@property (nonatomic) NSInteger team_boat1_y;

@property (nonatomic) NSInteger team_boat2_x;
@property (nonatomic) NSInteger team_boat2_y;

@property (nonatomic) NSInteger team_boat3_x;
@property (nonatomic) NSInteger team_boat3_y;

@property (nonatomic) NSInteger team_boat4_x;
@property (nonatomic) NSInteger team_boat4_y;

@property (nonatomic) NSInteger team_boat5_x;
@property (nonatomic) NSInteger team_boat5_y;

@property (nonatomic) NSInteger opponent_boat1_x;
@property (nonatomic) NSInteger opponent_boat1_y;

@property (nonatomic) NSInteger opponent_boat2_x;
@property (nonatomic) NSInteger opponent_boat2_y;

@property (nonatomic) NSInteger opponent_boat3_x;
@property (nonatomic) NSInteger opponent_boat3_y;

@property (nonatomic) NSInteger opponent_boat4_x;
@property (nonatomic) NSInteger opponent_boat4_y;

@property (nonatomic) NSInteger opponent_boat5_x;
@property (nonatomic) NSInteger opponent_boat5_y;

@end
