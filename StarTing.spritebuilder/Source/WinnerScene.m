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

@implementation WinnerScene{
    CCTextField *winnername_TTF;
    CCButton *newRound_button;
    NSString *currentUsername;
}

- (void)didLoadFromCCB {
    newRound_button.visible = NO;
}

- (void)onEnter{
    [super onEnter];
    [self schedule:@selector(getGameStatus) interval:5.0f];
    
    PFUser *currentUser = [PFUser currentUser];
    currentUsername = currentUser[@"username"];

    // Get game status
    [PFCloud callFunctionInBackground:@"getGameStatus"
                       withParameters:@{@"gameID" : self.gameID}
                                block:^(PFObject *success, NSError *error) {
                                    if (!error) {
                                        NSString *roundWinner = success[@"roundWinner"];
                                        winnername_TTF.string = roundWinner;
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
                                        if ([started doubleValue] == 1) {
                                            EachGameScene *eachGameScene = (EachGameScene*)[CCBReader load:@"EachGameScene"];
                                            eachGameScene.gameID = self.gameID;
                                            [self.parent addChild:eachGameScene];
                                            [self removeFromParent];
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
    EachGameScene *eachGameScene = (EachGameScene*)[CCBReader load:@"EachGameScene"];
    eachGameScene.gameID = self.gameID;
    [self.parent addChild:eachGameScene];
    [self removeFromParent];
}

@end
