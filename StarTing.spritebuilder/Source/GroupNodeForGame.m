//
//  CCNode+GroupNodeForGame.m
//  StarTing
//
//  Created by Yuefeng Wu on 11/16/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GroupNodeForGame.h"
#import <Parse/Parse.h>

@implementation GroupNodeForGame{
    CCLabelTTF *groupName_TTF;
    NSArray *membersArray;
}

- (void)onEnter {
    [super onEnter];
    self.userInteractionEnabled = YES;
    groupName_TTF.string = self.ListNode_Name;
    
    [PFCloud callFunctionInBackground:@"getGroup"
                       withParameters:@{@"groupID" : self.ListNode_Groupid}
                                block:^(PFObject *success, NSError *error) {
                                    if (!error) {
                                        membersArray = success[@"members"];
                                    }
                                }];
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
    [PFCloud callFunctionInBackground:@"createGame"
                       withParameters:@{@"groupID" : self.ListNode_Groupid, @"members" : membersArray}
                                block:^(NSArray *success, NSError *error) {
                                    if (!error) {
                                        
                                    }
                                }];
    
    CCScene *GamesScene = [CCBReader loadAsScene:@"GamesScene"];
    [[CCDirector sharedDirector] replaceScene:GamesScene];
}

@end
