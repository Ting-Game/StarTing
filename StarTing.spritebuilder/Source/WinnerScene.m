//
//  CCNode+WinnerScene.m
//  StarTing
//
//  Created by Yuefeng Wu on 11/20/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "WinnerScene.h"
#import <Parse/Parse.h>
#import "EachGameScene.h"
#import "GreenCard.h"
#import "RedCard.h"

@implementation WinnerScene{
    CCLabelTTF *winnername_TTF;
    CCButton *newRound_button;
    NSString *currentUsername;
    CCLabelTTF *rule_TTF;
    CCNode *gameNode;
    NSString *winner;
}

- (void)didLoadFromCCB {
    newRound_button.visible = NO;
    rule_TTF.visible = NO;
    gameNode.visible = NO;
}

- (void)onEnter{
    [super onEnter];
    [self schedule:@selector(getGameStatus) interval:1.0f];
    
    PFUser *currentUser = [PFUser currentUser];
    currentUsername = currentUser[@"username"];
    
    // Get game status
    [PFCloud callFunctionInBackground:@"getGameStatus"
                       withParameters:@{@"gameID" : self.gameID}
                                block:^(PFObject *success, NSError *error) {
                                    if (!error) {
                                        //NSString *roundWinner = success[@"roundWinner"];
                                        //winnername_TTF.string = roundWinner;
                                        NSString *judger = success[@"judger"];
                                        if ([judger isEqualToString: currentUsername]) {
                                            newRound_button.visible = YES;
                                        }
                                    }
                                }];
}

- (void)getGameStatus {
    // Get game status
    [PFCloud callFunctionInBackground:@"getGameStatus"
                       withParameters:@{@"gameID" : self.gameID}
                                block:^(PFObject *success, NSError *error) {
                                    if (!error) {
                                        NSNumber *started = success[@"started"];
                                        NSNumber *firstRound = success[@"firstRound"];
                                        if ([started doubleValue] != 0) {
                                            EachGameScene *eachGameScene = (EachGameScene*)[CCBReader load:@"EachGameScene"];
                                            eachGameScene.gameID = self.gameID;
                                            [self.parent addChild:eachGameScene];
                                            [self removeFromParent];
                                        }else{
                                            if ([firstRound doubleValue] != 0) {
                                                rule_TTF.visible = YES;
                                            } else {
                                                gameNode.visible = YES;
                                                // Get game status again
                                                [PFCloud callFunctionInBackground:@"getGameStatus"
                                                                   withParameters:@{@"gameID" : self.gameID}
                                                                            block:^(PFObject *success, NSError *error) {
                                                                                if (!error) {
                                                                                    winner = success[@"roundWinner"];
                                                                                    PFObject *currentGreen = success[@"greencard"];
                                                                                    NSString *greenCard_keyword = currentGreen[@"Keyword"];
                                                                                    // Get current green
                                                                                    GreenCard *greencard = (GreenCard*)[CCBReader load:@"GreenCard"];
                                                                                    greencard.keyword = greenCard_keyword;
                                                                                    greencard.detail = @"";
                                                                                    greencard.positionType = CCPositionTypeNormalized;
                                                                                    greencard.position = CGPointMake(0.5, 0.635);
                                                                                    greencard.scale = 0.6;
                                                                                    [self addChild:greencard];
                                                                                    
                                                                                    // Get all red cards
                                                                                    [PFCloud callFunctionInBackground:@"getSelectedReds"
                                                                                                       withParameters:@{@"gameID" : self.gameID}
                                                                                                                block:^(NSArray *success, NSError *error) {
                                                                                                                    if (!error) {
                                                                                                                        CGFloat x = 0.2;
                                                                                                                        for (PFObject *eachRed in success) {
                                                                                                                            if (eachRed[@"selectedCard"] != NULL) {
                                                                                                                                // Display my red cards
                                                                                                                                RedCard *redcard = (RedCard*)[CCBReader load:@"RedCard"];
                                                                                                                                redcard.keyword = eachRed[@"selectedCard"][@"Keyword"];
                                                                                                                                redcard.detail = @"";
                                                                                                                                redcard.RedNum = eachRed[@"selectedCard"][@"cardNumber"];
                                                                                                                                redcard.gameID = self.gameID;
                                                                                                                                redcard.positionType = CCPositionTypeNormalized;
                                                                                                                                redcard.position = CGPointMake(x, 0.41);
                                                                                                                                x += 0.3;
                                                                                                                                redcard.scale = 0.6;
                                                                                                                                
                                                                                                                                // Add selected card's owner's name to card
                                                                                                                                CCLabelTTF *ownerName = [CCLabelTTF node];
                                                                                                                                ownerName.string = eachRed[@"user"];
                                                                                                                                ownerName.positionType = CCPositionTypeNormalized;
                                                                                                                                ownerName.position = CGPointMake(0.5, -0.05);
                                                                                                                                ownerName.color = [CCColor colorWithRed:0.f green:0.f blue:0.f];
                                                                                                                                ownerName.fontSize = 17.f;
                                                                                                                                ownerName.fontName = @"Sansation-BoldItalic.ttf";
                                                                                                                                [redcard addChild:ownerName];
                                                                                                                                
                                                                                                                                [self addChild:redcard];
                                                                                                                            }
                                                                                                                        }
                                                                                                                    }
                                                                                                                }];
                                                                                    // Display round winner
                                                                                    [PFCloud callFunctionInBackground:@"getSelectedReds"
                                                                                                       withParameters:@{@"gameID" : self.gameID}
                                                                                                                block:^(NSArray *success, NSError *error) {
                                                                                                                    if (!error) {
                                                                                                                        for (PFObject *eachRed in success) {
                                                                                                                            if (eachRed[@"selectedCard"] != NULL) {
                                                                                                                                if ([eachRed[@"user"] isEqualToString:winner]) {
                                                                                                                                // Display my red cards
                                                                                                                                RedCard *redcard = (RedCard*)[CCBReader load:@"RedCard"];
                                                                                                                                redcard.keyword = eachRed[@"selectedCard"][@"Keyword"];
                                                                                                                                redcard.detail = @"";
                                                                                                                                redcard.RedNum = eachRed[@"selectedCard"][@"cardNumber"];
                                                                                                                                redcard.gameID = self.gameID;
                                                                                                                                redcard.positionType = CCPositionTypeNormalized;
                                                                                                                                redcard.position = CGPointMake(0.5, 0.17);
                                                                                                                                redcard.scale = 0.6;
                                                                                                                                
                                                                                                                                // Add selected card's owner's name to card
                                                                                                                                CCLabelTTF *ownerName = [CCLabelTTF node];
                                                                                                                                ownerName.string = eachRed[@"user"];
                                                                                                                                ownerName.positionType = CCPositionTypeNormalized;
                                                                                                                                ownerName.position = CGPointMake(0.5, -0.05);
                                                                                                                                ownerName.color = [CCColor colorWithRed:0.f green:0.f blue:0.f];
                                                                                                                                ownerName.fontSize = 17.f;
                                                                                                                                ownerName.fontName = @"Sansation-BoldItalic.ttf";
                                                                                                                                [redcard addChild:ownerName];
                                                                                                                                
                                                                                                                                [self addChild:redcard];
                                                                                                                            }
                                                                                                                        }
                                                                                                                    }
                                                                                                                }
                                                                                     }];
                                                                                }
                                                                            }];
                                            }
                                        }
                                    }
                                }];
}

- (void)newRound_button {
    
    // Get game status
    [PFCloud callFunctionInBackground:@"getGameStatus"
                       withParameters:@{@"gameID" : self.gameID}
                                block:^(PFObject *success, NSError *error) {
                                    if (!error) {
                                        NSString *judger = success[@"judger"];
                                        NSNumber *started = success[@"started"];
                                        if ([judger isEqualToString: currentUsername] && [started doubleValue] == 0) {
                                            // Game Begin
                                            [PFCloud callFunctionInBackground:@"gameBegin"
                                                               withParameters:@{@"gameID" : self.gameID}
                                                                        block:^(PFObject *success, NSError *error) {
                                                                            if (!error) {
                                                                                
                                                                            }
                                                                        }];
                                        }
                                    }
                                }];
}

- (void)quitToGameScene_button{
    CCScene *GamesScene = [CCBReader loadAsScene:@"GamesScene"];
    [[CCDirector sharedDirector] replaceScene:GamesScene];
}

@end
