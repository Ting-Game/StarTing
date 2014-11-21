//
//  CCNode+GamesScene.m
//  StarTing
//
//  Created by Yuefeng Wu on 10/4/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GamesScene.h"
#import <Parse/Parse.h>
#import "CurrentGameNode.h"

@implementation GamesScene{
    NSString *each_object_groupName;
}

- (void)onEnter{
    [super onEnter];
    // pull current game list from Parse
    [PFCloud callFunctionInBackground:@"getGames"
                       withParameters:@{}
                                block:^(NSArray *success, NSError *error) {
                                    if (!error) {
                                        if (success != NULL) {
                                            if (success.count > 0) {
                                                for (int i = 0; i < success.count; i++) {
                                                    PFObject *each_object = success[i];
                                                    NSString *each_object_groupid = each_object[@"group"];
                                                    NSString *each_object_gameid = each_object.objectId;
                                                    
                                                    [PFCloud callFunctionInBackground:@"getGroup"
                                                                       withParameters:@{@"groupID" : each_object_groupid}
                                                                                block:^(PFObject *success, NSError *error) {
                                                                                    if (!error) {
                                                                                        each_object_groupName = success[@"name"];
                                                                                        
                                                                                        CurrentGameNode *currentGameNode = (CurrentGameNode*)[CCBReader load:@"CurrentGameNode"];
                                                                                        currentGameNode.gameID = each_object_gameid;
                                                                                        currentGameNode.groupName = each_object_groupName;
                                                                                        
                                                                                        currentGameNode.anchorPoint = CGPointMake(0, 0);
                                                                                        currentGameNode.position = CGPointMake(0, 220 + i * (currentGameNode.contentSizeInPoints.height));
                                                                                        currentGameNode.positionType = CCPositionTypeMake(CCPositionTypePoints.xUnit, CCPositionTypePoints.yUnit, CCPositionReferenceCornerTopLeft);
                                                                                        [self addChild:currentGameNode];
                                                                                    }
                                                                                }];
                                                }
                                            }
                                            else {
                                            }
                                        }
                                    }
                                }];
}

- (void)Friends_Button {
    CCScene *FriendsScene = [CCBReader loadAsScene:@"FriendsScene"];
    [[CCDirector sharedDirector] replaceScene:FriendsScene];
}

- (void)Groups_Button {
    CCScene *GroupsScene = [CCBReader loadAsScene:@"GroupsScene"];
    [[CCDirector sharedDirector] replaceScene:GroupsScene];
}

- (void)Games_Button {
    CCScene *GamesScene = [CCBReader loadAsScene:@"GamesScene"];
    [[CCDirector sharedDirector] replaceScene:GamesScene];
}

- (void)Settings_Button {
    CCScene *SettingsScene = [CCBReader loadAsScene:@"SettingsScene"];
    [[CCDirector sharedDirector] replaceScene:SettingsScene];
}

- (void)launchGame_button {
    CCScene *SelectGameScene = [CCBReader loadAsScene:@"SelectGameScene"];
    [[CCDirector sharedDirector] replaceScene:SelectGameScene];
}

@end