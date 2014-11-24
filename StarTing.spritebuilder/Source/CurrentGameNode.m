//
//  CCNode+CurrentGameNode.m
//  StarTing
//
//  Created by Yuefeng Wu on 11/16/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CurrentGameNode.h"
#import "EachGameScene.h"
#import <Parse/Parse.h>
#import "WinnerScene.h"

@implementation CurrentGameNode{
    CCLabelTTF *currentGameName_TTF;
}

- (void)onEnter{
    [super onEnter];
    self.userInteractionEnabled = YES;
    currentGameName_TTF.string =  [NSString stringWithFormat:@"Apples To Apples In : %@", self.groupName];
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    // Get game status
    [PFCloud callFunctionInBackground:@"getGameStatus"
                       withParameters:@{@"gameID" : self.gameID}
                                block:^(PFObject *success, NSError *error) {
                                    if (!error) {
                                        NSNumber *started = success[@"started"];
                                        if ([started doubleValue] == 0) {
                                            WinnerScene *winnerScene = (WinnerScene*)[CCBReader load:@"WinnerScene"];
                                            winnerScene.gameID = self.gameID;
                                            [self.parent.parent addChild:winnerScene];
                                            [self.parent removeFromParent];
                                        } else {
                                            EachGameScene *eachGameScene = (EachGameScene*)[CCBReader load:@"EachGameScene"];
                                            eachGameScene.gameID = self.gameID;
                                            [self.parent.parent addChild:eachGameScene];
                                            [self.parent removeFromParent];
                                        }

                                    }
                                }];
}

@end
