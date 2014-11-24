//
//  CCNode+EachGameScene.m
//  StarTing
//
//  Created by Yuefeng Wu on 11/16/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "EachGameScene.h"
#import <Parse/Parse.h>
#import "GreenCard.h"
#import "RedCard.h"
#import "WinnerScene.h"

@implementation EachGameScene{
    NSString *currentUsername;
    CCLabelTTF *redAppleHint_TTF;
    CCLabelTTF *greenAppleHint_TTF;
    CCLabelTTF *judger_redAppleHint_TTF;
    CCLabelTTF *selected_redAppleHint_TTF;
    int currentNum;
    int precardNum;
}

- (void)didLoadFromCCB {
    PFUser *currentUser = [PFUser currentUser];
    currentUsername = currentUser[@"username"];
    
    redAppleHint_TTF.visible = NO;
    judger_redAppleHint_TTF.visible = NO;
    selected_redAppleHint_TTF.visible = NO;
    currentNum = 0;
    precardNum = 0;
}

- (void)onEnter{
    [super onEnter];
    [self schedule:@selector(getGameStatus) interval:1.0f];
    [self getGameStatus];
}

- (void)getGameStatus{
    // Get game status again
    [PFCloud callFunctionInBackground:@"getGameStatus"
                       withParameters:@{@"gameID" : self.gameID}
                                block:^(PFObject *success, NSError *error) {
                                    if (!error) {
                                        NSNumber *started = success[@"started"];
                                        if ([started doubleValue] == 0) {
                                            WinnerScene *winnerScene = (WinnerScene*)[CCBReader load:@"WinnerScene"];
                                            winnerScene.gameID = self.gameID;
                                            [self.parent addChild:winnerScene];
                                            [self removeFromParent];
                                        }
                                        NSString *judger = success[@"judger"];
                                        PFObject *currentGreen = success[@"greencard"];
                                        NSString *greenCard_keyword = currentGreen[@"Keyword"];
                                        NSString *greenCard_detail = @"";
                                        if ([judger isEqualToString: currentUsername]) {
                                            // Get current green
                                            judger_redAppleHint_TTF.visible = YES;
                                            GreenCard *greencard = (GreenCard*)[CCBReader load:@"GreenCard"];
                                            greencard.keyword = greenCard_keyword;
                                            greencard.detail = greenCard_detail;
                                            greencard.positionType = CCPositionTypeNormalized;
                                            greencard.position = CGPointMake(0.5, 0.7);
                                            greencard.scale = 0.6;
                                            NSLog(@"%@", greencard);
                                            [self addChild:greencard];
                                            
                                            // Get player's red card
                                            [PFCloud callFunctionInBackground:@"getSelectedReds"
                                                               withParameters:@{@"gameID" : self.gameID}
                                                                        block:^(NSArray *success, NSError *error) {
                                                                            if (!error) {
                                                                                CGFloat x = 0.3;
                                                                                for (PFObject *eachRed in success) {
                                                                                    if (eachRed[@"selectedCard"] != NULL) {
                                                                                        currentNum ++;
                                                                                    }
                                                                                }
                                                                                if (currentNum > precardNum) {
                                                                                    for (PFObject *eachRed in success) {
                                                                                        if (eachRed[@"selectedCard"] != NULL) {
                                                                                            // Display my red cards
                                                                                            RedCard *redcard = (RedCard*)[CCBReader load:@"RedCard"];
                                                                                            redcard.keyword = eachRed[@"selectedCard"][@"Keyword"];
                                                                                            redcard.detail = @"";
                                                                                            redcard.RedNum = eachRed[@"selectedCard"][@"cardNumber"];
                                                                                            redcard.gameID = self.gameID;
                                                                                            redcard.positionType = CCPositionTypeNormalized;
                                                                                            redcard.position = CGPointMake(x, 0.47);
                                                                                            x += 0.3;
                                                                                            redcard.scale = 0.6;
                                                                                            [self addChild:redcard];
                                                                                        }
                                                                                        precardNum = currentNum;
                                                                                    }
                                                                                }
                                                                            }
                                                                        }];
                                        } else {
                                            // Get current green
                                            redAppleHint_TTF.visible = YES;
                                            selected_redAppleHint_TTF.visible = YES;

                                            GreenCard *greencard = (GreenCard*)[CCBReader load:@"GreenCard"];
                                            greencard.keyword = greenCard_keyword;
                                            greencard.detail = greenCard_detail;
                                            greencard.positionType = CCPositionTypeNormalized;
                                            greencard.position = CGPointMake(0.5, 0.7);
                                            greencard.scale = 0.6;
                                            [self addChild:greencard];
                                            
                                            // Get myself's red cards
                                            [PFCloud callFunctionInBackground:@"getReds"
                                                               withParameters:@{@"gameID" : self.gameID}
                                                                        block:^(NSArray *success, NSError *error) {
                                                                            if (!error) {
                                                                                CGFloat x = 0.15;
                                                                                for (PFObject *eachRed in success) {
                                                                                    // Display my red cards
                                                                                    RedCard *redcard = (RedCard*)[CCBReader load:@"RedCard"];
                                                                                    redcard.keyword = eachRed[@"Keyword"];
                                                                                    redcard.detail = @"";
                                                                                    redcard.RedNum = eachRed[@"cardNumber"];
                                                                                    redcard.gameID = self.gameID;
                                                                                    redcard.positionType = CCPositionTypeNormalized;
                                                                                    redcard.position = CGPointMake(x, 0.47);
                                                                                    x += 0.185;
                                                                                    redcard.scale = 0.6;
                                                                                    [self addChild:redcard];
                                                                                }
                                                                            }
                                                                        }];
                                            
                                            // Get all red cards
                                            [PFCloud callFunctionInBackground:@"getSelectedReds"
                                                               withParameters:@{@"gameID" : self.gameID}
                                                                        block:^(NSArray *success, NSError *error) {
                                                                            if (!error) {
                                                                                CGFloat x = 0.3;
                                                                                for (PFObject *eachRed in success) {
                                                                                    if (eachRed[@"selectedCard"] != NULL) {
                                                                                        cardNum ++;
                                                                                    // Display my red cards
                                                                                    RedCard *redcard = (RedCard*)[CCBReader load:@"RedCard"];
                                                                                    redcard.keyword = eachRed[@"selectedCard"][@"Keyword"];
                                                                                    redcard.detail = @"";
                                                                                    redcard.RedNum = eachRed[@"selectedCard"][@"cardNumber"];
                                                                                    redcard.gameID = self.gameID;
                                                                                    redcard.positionType = CCPositionTypeNormalized;
                                                                                    redcard.position = CGPointMake(x, 0.25);
                                                                                    x += 0.3;
                                                                                    redcard.scale = 0.6;
                                                                                    
                                                                                    // Add selected card's owner's name to card
                                                                                    CCLabelTTF *ownerName = [CCLabelTTF node];
                                                                                    ownerName.string = eachRed[@"user"];
                                                                                    ownerName.positionType = CCPositionTypeNormalized;
                                                                                    ownerName.position = CGPointMake(0.5, -0.1);
                                                                                    ownerName.color = [CCColor colorWithRed:0.f green:0.f blue:0.f];
                                                                                    ownerName.fontSize = 15.f;
                                                                                    [redcard addChild:ownerName];
                                                                                    
                                                                                    [self addChild:redcard];
                                                                                    }
                                                                                }
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
